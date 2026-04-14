// com/citywatch/service/UserService.java
package com.citywatch.service;

import com.citywatch.config.DBConnection;
import com.citywatch.dao.CivilianDao;
import com.citywatch.dao.OrganizationDao;
import com.citywatch.dao.UserDao;
import com.citywatch.model.Civilian;
import com.citywatch.model.Organization;
import com.citywatch.model.User;
import com.citywatch.util.PasswordUtil;
import com.citywatch.util.ValidationUtil;

import java.sql.Connection;
import java.util.List;

/**
 * Business-logic layer for user account management.
 * Handles validation, registration, profile management,
 * and role-based operations.
 */
public class UserService {

    private final UserDao userDao = new UserDao();
    private final OrganizationDao orgDao = new OrganizationDao();
    private final CivilianDao civilianDao = new CivilianDao();

    // =========================================================
    // REGISTRATION
    // =========================================================

    /**
     * @return null if success, otherwise field name causing failure
     */
    public String register(
            String fullName,
            String username,
            String password,
            String email,
            String phone,
            String role,
            String orgName,
            String orgType,
            String address,
            String wardNoStr
    ) {

        Connection conn = DBConnection.getInstance().getConnection();

        if (ValidationUtil.isNullOrEmpty(fullName) || ValidationUtil.containsDigit(fullName))
            return "fullName";

        if (ValidationUtil.isNullOrEmpty(username) || !ValidationUtil.isUsernameUnique(username, conn))
            return "username";

        if (ValidationUtil.isNullOrEmpty(password) || password.length() < 6)
            return "password";

        if (!ValidationUtil.isValidEmail(email) || !ValidationUtil.isEmailUnique(email, conn))
            return "email";

        if (!ValidationUtil.isValidPhone(phone) || !ValidationUtil.isPhoneUnique(phone, conn))
            return "phone";

        if (!"ORGANIZATION".equals(role) && !"CIVILIAN".equals(role))
            return "role";

        User user = new User(
                username,
                PasswordUtil.hashPassword(password),
                fullName,
                email,
                phone,
                role
        );

        userDao.insertUser(user);
        User saved = userDao.findByUsername(username);

        if ("ORGANIZATION".equals(role)) {

            Organization org = new Organization();
            org.setUserId(saved.getId());
            org.setOrgName(orgName != null && !orgName.isBlank() ? orgName : fullName);
            org.setOrgType(orgType != null ? orgType : "");
            org.setAddress(address != null ? address : "");

            orgDao.insert(org);

        } else {

            Civilian civ = new Civilian();
            civ.setUserId(saved.getId());
            civ.setAddress(address != null ? address : "");

            try {
                civ.setWardNo(Integer.parseInt(wardNoStr));
            } catch (Exception ignored) {
            }

            civilianDao.insert(civ);
        }

        return null;
    }

    // =========================================================
    // LOOKUPS
    // =========================================================

    public User findById(int id) {
        return userDao.findById(id);
    }

    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    public List<User> getAllByRole(String role) {
        return userDao.findByRole(role);
    }

    public List<User> getAll() {
        return userDao.findAll();
    }

    public int countByRole(String role) {
        return userDao.countByRole(role);
    }

    // =========================================================
    // PROFILE UPDATES
    // =========================================================

    public boolean updateUser(User user) {
        return userDao.updateUser(user);
    }

    public boolean updateOrgProfile(Organization org) {
        return orgDao.update(org);
    }

    public boolean updateCivilianProfile(Civilian civ) {
        return civilianDao.update(civ);
    }

    // =========================================================
    // DELETE USER
    // =========================================================

    public boolean deleteUserWithProfile(int userId, String role) {

        if ("ORGANIZATION".equals(role)) {
            orgDao.deleteByUserId(userId);
        } else if ("CIVILIAN".equals(role)) {
            civilianDao.deleteByUserId(userId);
        }

        return userDao.deleteUser(userId);
    }

    public boolean removeLastByRole(String role) {
        return userDao.removeLastByRole(role);
    }

    // =========================================================
    // PROFILE RETRIEVAL
    // =========================================================

    public Organization getOrgProfile(int userId) {
        return orgDao.findByUserId(userId);
    }

    public Civilian getCivilianProfile(int userId) {
        return civilianDao.findByUserId(userId);
    }

    public List<Organization> getAllOrgs() {
        return orgDao.findAll();
    }

    public List<Civilian> getAllCivilians() {
        return civilianDao.findAll();
    }

    // =========================================================
    // PASSWORD MANAGEMENT
    // =========================================================

    public boolean changePassword(int userId, String newPlainPassword) {
        return userDao.updatePassword(
                userId,
                PasswordUtil.hashPassword(newPlainPassword)
        );
    }

    public String changePasswordVerified(int userId, String currentPlain, String newPlain) {

        User user = userDao.findById(userId);

        if (user == null)
            return "User not found.";

        if (!PasswordUtil.verifyPassword(currentPlain, user.getPassword()))
            return "Current password is incorrect.";

        if (newPlain == null || newPlain.length() < 6)
            return "New password must be at least 6 characters.";

        userDao.updatePassword(userId, PasswordUtil.hashPassword(newPlain));

        return null;
    }

    // =========================================================
    // ACCOUNT LOCKING
    // =========================================================

    public boolean lockUser(int userId) {
        User user = userDao.findById(userId);
        if (user == null) return false;

        user.setLocked(true);
        return userDao.updateUser(user);
    }

    public boolean unlockUser(int userId) {
        User user = userDao.findById(userId);
        if (user == null) return false;

        user.setLocked(false);
        return userDao.updateUser(user);
    }
}