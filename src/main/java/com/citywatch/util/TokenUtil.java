// com/citywatch/util/TokenUtil.java
package com.citywatch.util;

import com.citywatch.config.DBConnection;

import java.sql.*;
import java.util.UUID;

public class TokenUtil {

    public static String generateResetToken(int userId) {
        String token = UUID.randomUUID().toString();
        String sql = "INSERT INTO password_reset_tokens (user_id, token, expires_at) " +
                     "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 1 HOUR))";
        try (PreparedStatement ps = DBConnection.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, token);
            ps.executeUpdate();
            return token;
        } catch (SQLException e) {
            System.err.println("TokenUtil.generateResetToken: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    /** Returns the user_id if the token is valid and not expired, else -1. */
    public static int validateToken(String token) {
        String sql = "SELECT user_id FROM password_reset_tokens " +
                     "WHERE token = ? AND used = 0 AND expires_at > NOW()";
        try (PreparedStatement ps = DBConnection.getInstance().getConnection().prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("user_id");
        } catch (SQLException e) {
            System.err.println("TokenUtil.validateToken: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return -1;
    }

    public static void markTokenUsed(String token) {
        String sql = "UPDATE password_reset_tokens SET used = 1 WHERE token = ?";
        try (PreparedStatement ps = DBConnection.getInstance().getConnection().prepareStatement(sql)) {
            ps.setString(1, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("TokenUtil.markTokenUsed: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}