// com/citywatch/service/AuthService.java
package com.citywatch.service;

import com.citywatch.config.DBConnection;
import com.citywatch.dao.UserDao;
import com.citywatch.model.User;
import com.citywatch.util.PasswordUtil;
import com.citywatch.util.TokenUtil;

import java.sql.*;

public class AuthService {

    private final UserDao userDao = new UserDao();

    // =========================
    // LOGIN
    // =========================
    public User login(String username, String password) {

        User user = userDao.findByUsername(username);
        if (user == null) return null;

        if (isAccountLocked(user.getId())) return null;

        if (!PasswordUtil.verifyPassword(password, user.getPassword())) {
            recordFailedAttempt(user.getId());
            return null;
        }

        resetAttempts(user.getId());
        return user;
    }

    // =========================
    // FAILED LOGIN ATTEMPTS
    // =========================
    public void recordFailedAttempt(int userId) {

        Connection conn = DBConnection.getInstance().getConnection();

        String upsert =
                "INSERT INTO login_attempts (user_id, attempt_count, last_attempt) " +
                "VALUES (?, 1, NOW()) " +
                "ON DUPLICATE KEY UPDATE attempt_count = attempt_count + 1, last_attempt = NOW()";

        try (PreparedStatement ps = conn.prepareStatement(upsert)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("recordFailedAttempt upsert: " + e.getMessage());
        }

        String check =
                "SELECT attempt_count FROM login_attempts WHERE user_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(check)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) >= 5) {
                lockAccount(userId);
            }

        } catch (SQLException e) {
            System.err.println("recordFailedAttempt check: " + e.getMessage());
        }
    }

    // =========================
    // LOCK ACCOUNT
    // =========================
    public void lockAccount(int userId) {

        String sql =
                "UPDATE login_attempts " +
                "SET locked_until = DATE_ADD(NOW(), INTERVAL 15 MINUTE) " +
                "WHERE user_id = ?";

        try (PreparedStatement ps =
                     DBConnection.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("lockAccount: " + e.getMessage());
        }
    }

    // =========================
    // RESET ATTEMPTS
    // =========================
    public void resetAttempts(int userId) {

        String sql =
                "UPDATE login_attempts " +
                "SET attempt_count = 0, locked_until = NULL " +
                "WHERE user_id = ?";

        try (PreparedStatement ps =
                     DBConnection.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("resetAttempts: " + e.getMessage());
        }
    }

    // =========================
    // CHECK LOCK STATUS
    // =========================
    public boolean isAccountLocked(int userId) {

        User user = userDao.findById(userId);
        if (user != null && user.isLocked()) return true;

        String sql = "SELECT locked_until FROM login_attempts WHERE user_id = ?";

        try (PreparedStatement ps =
                     DBConnection.getInstance().getConnection().prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Timestamp lockedUntil = rs.getTimestamp("locked_until");

                if (lockedUntil != null &&
                        lockedUntil.after(new Timestamp(System.currentTimeMillis()))) {
                    return true;
                }
            }

        } catch (SQLException e) {
            System.err.println("isAccountLocked: " + e.getMessage());
        }

        return false;
    }

    // =========================
    // PASSWORD RESET
    // =========================
    public String generateResetToken(int userId) {
        return TokenUtil.generateResetToken(userId);
    }

    public boolean resetPassword(String token, String newPassword) {

        int userId = TokenUtil.validateToken(token);
        if (userId == -1) return false;

        String hashed = PasswordUtil.hashPassword(newPassword);
        boolean updated = userDao.updatePassword(userId, hashed);

        if (updated) {
            TokenUtil.markTokenUsed(token);
        }

        return updated;
    }
}