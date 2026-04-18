// com/citywatch/controller/AuthController.java
package com.citywatch.controller;

import com.citywatch.config.DBConnection;
import com.citywatch.dao.CivilianDao;
import com.citywatch.dao.OrganizationDao;
import com.citywatch.dao.UserDao;
import com.citywatch.model.Civilian;
import com.citywatch.model.Organization;
import com.citywatch.model.User;
import com.citywatch.service.AuthService;
import com.citywatch.util.PasswordUtil;
import com.citywatch.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(urlPatterns = {
        "/login",
        "/register",
        "/logout",
        "/forgot-password",
        "/reset-password",
        "/error"
})
public class AuthController extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final UserDao userDao = new UserDao();
    private final OrganizationDao orgDao = new OrganizationDao();
    private final CivilianDao civilianDao = new CivilianDao();

    // GET
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        switch (path) {
            case "/login":
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                break;

            case "/register":
                req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                break;

            case "/forgot-password":
                req.getRequestDispatcher("/WEB-INF/views/auth/reset.jsp").forward(req, resp);
                break;

            case "/reset-password":
                req.getRequestDispatcher("/WEB-INF/views/auth/newPassword.jsp").forward(req, resp);
                break;

            case "/error":
                req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
                break;

            case "/logout":
                doLogout(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    // POST
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        switch (path) {
            case "/login":
                doLogin(req, resp);
                break;

            case "/register":
                doRegister(req, resp);
                break;

            case "/forgot-password":
                doForgotPassword(req, resp);
                break;

            case "/reset-password":
                doResetPassword(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    // LOGIN
    private void doLogin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (ValidationUtil.isNullOrEmpty(username) || ValidationUtil.isNullOrEmpty(password)) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        User user = authService.login(username, password);

        if (user == null) {
            req.setAttribute("error", "Invalid credentials or account locked.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // Create session
        HttpSession session = req.getSession(true);
        session.setAttribute("userId", user.getId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("fullName", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

        // Persistent cookie (24h)
        Cookie cookie = new Cookie("user_id", String.valueOf(user.getId()));
        cookie.setMaxAge(24 * 60 * 60);
        cookie.setHttpOnly(true);
        cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
        resp.addCookie(cookie);

        // Redirect by role
        String ctx = req.getContextPath();

        switch (user.getRole()) {
            case "ADMIN":
                resp.sendRedirect(ctx + "/admin/home");
                break;

            case "ORGANIZATION":
                resp.sendRedirect(ctx + "/org/home");
                break;

            case "CIVILIAN":
                resp.sendRedirect(ctx + "/civilian/home");
                break;

            default:
                resp.sendRedirect(ctx + "/login");
        }
    }

    // REGISTER
    private void doRegister(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String fullName = req.getParameter("full_name");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String role = req.getParameter("role"); // ORGANIZATION | CIVILIAN
        String orgName = req.getParameter("org_name");
        String orgType = req.getParameter("org_type");
        String address = req.getParameter("address");
        String wardNoStr = req.getParameter("ward_no");

        Connection conn = DBConnection.getInstance().getConnection();

        // Validation
        if (ValidationUtil.isNullOrEmpty(fullName) || ValidationUtil.containsDigit(fullName)) {
            forward(req, resp, "error", "fullName", "/WEB-INF/views/auth/register.jsp");
            return;
        }

        if (ValidationUtil.isNullOrEmpty(username) || !ValidationUtil.isUsernameUnique(username, conn)) {
            forward(req, resp, "error", "username", "/WEB-INF/views/auth/register.jsp");
            return;
        }

        if (ValidationUtil.isNullOrEmpty(password) || password.length() < 6) {
            forward(req, resp, "error", "password", "/WEB-INF/views/auth/register.jsp");
            return;
        }

        if (!ValidationUtil.isValidEmail(email) || !ValidationUtil.isEmailUnique(email, conn)) {
            forward(req, resp, "error", "email", "/WEB-INF/views/auth/register.jsp");
            return;
        }

        if (!ValidationUtil.isValidPhone(phone) || !ValidationUtil.isPhoneUnique(phone, conn)) {
            forward(req, resp, "error", "phone", "/WEB-INF/views/auth/register.jsp");
            return;
        }

        if (!"ORGANIZATION".equals(role) && !"CIVILIAN".equals(role)) {
            forward(req, resp, "error", "role", "/WEB-INF/views/auth/register.jsp");
            return;
        }

        // Build & insert user
        User user = new User(
                username,
                PasswordUtil.hashPassword(password),
                fullName,
                email,
                phone,
                role
        );

        boolean inserted = userDao.insertUser(user);

        if (!inserted) {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        User saved = userDao.findByUsername(username);

        // Insert role-specific profile
        if ("ORGANIZATION".equals(role)) {
            Organization org = new Organization();
            org.setUserId(saved.getId());
            org.setOrgName(orgName != null ? orgName : fullName);
            org.setOrgType(orgType != null ? orgType : "");
            org.setAddress(address != null ? address : "");
            orgDao.insert(org);

        } else {
            Civilian civ = new Civilian();
            civ.setUserId(saved.getId());
            civ.setAddress(address != null ? address : "");

            try {
                civ.setWardNo(Integer.parseInt(wardNoStr));
            } catch (Exception ignored) {}

            civilianDao.insert(civ);
        }

        resp.sendRedirect(req.getContextPath() + "/login?success=registered");
    }

    // FORGOT PASSWORD
    private void doForgotPassword(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String username = req.getParameter("username");

        if (ValidationUtil.isNullOrEmpty(username)) {
            req.setAttribute("error", "Please enter your username.");
            req.getRequestDispatcher("/WEB-INF/views/auth/reset.jsp").forward(req, resp);
            return;
        }

        // Find user by username
        String sql = "SELECT id FROM users WHERE username = ?";

        try (java.sql.PreparedStatement ps =
                     DBConnection.getInstance().getConnection().prepareStatement(sql)) {

            ps.setString(1, username);
            java.sql.ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String token = authService.generateResetToken(userId);

                // Show token in attribute (for the pop-up modal)
                req.setAttribute("token", token);

            } else {
                req.setAttribute("error", "No account found with that username.");
            }

        } catch (Exception e) {
            req.setAttribute("error", "An error occurred.");
        }

        req.getRequestDispatcher("/WEB-INF/views/auth/reset.jsp").forward(req, resp);
    }

    // RESET PASSWORD
    private void doResetPassword(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String token = req.getParameter("token");
        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (ValidationUtil.isNullOrEmpty(token) || ValidationUtil.isNullOrEmpty(newPass)) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/WEB-INF/views/auth/newPassword.jsp").forward(req, resp);
            return;
        }

        if (!newPass.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("/WEB-INF/views/auth/newPassword.jsp").forward(req, resp);
            return;
        }

        boolean ok = authService.resetPassword(token, newPass);

        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/login?success=passwordReset");
        } else {
            req.setAttribute("error", "Invalid or expired token.");
            req.getRequestDispatcher("/WEB-INF/views/auth/newPassword.jsp").forward(req, resp);
        }
    }

    // LOGOUT
    private void doLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        // Expire cookie
        Cookie cookie = new Cookie("user_id", "");
        cookie.setMaxAge(0);
        cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
        resp.addCookie(cookie);

        resp.sendRedirect(req.getContextPath() + "/login");
    }

    // Helper
    private void forward(HttpServletRequest req, HttpServletResponse resp,
                         String attrKey, String attrVal, String view)
            throws ServletException, IOException {

        req.setAttribute(attrKey, attrVal);
        req.getRequestDispatcher(view).forward(req, resp);
    }
}