// com/citywatch/controller/AdminController.java
package com.citywatch.controller;

import com.citywatch.dao.NoticeDao;
import com.citywatch.dao.TaskDao;
import com.citywatch.model.Civilian;
import com.citywatch.model.Notice;
import com.citywatch.model.Organization;
import com.citywatch.model.Task;
import com.citywatch.model.User;
import com.citywatch.service.DashboardService;
import com.citywatch.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {

    private final UserService userService = new UserService();
    private final TaskDao taskDao = new TaskDao();
    private final NoticeDao noticeDao = new NoticeDao();
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null)
            path = "/home";

        switch (path) {
            case "/home":
                showHome(req, resp);
                break;

            case "/orgs":
                showOrgs(req, resp);
                break;

            case "/civilians":
                showCivilians(req, resp);
                break;

            case "/tasks":
                showTasks(req, resp);
                break;

            case "/notices":
                showNotices(req, resp);
                break;

            case "/completedTasks":
                resp.sendRedirect(req.getContextPath() + "/admin/tasks?status=COMPLETED");
                break;

            case "/tasksInProgress":
                resp.sendRedirect(req.getContextPath() + "/admin/tasks?status=IN_PROGRESS");
                break;

            case "/addTask":
                fwd(req, resp, "admin/addTask.jsp");
                break;

            case "/addNotice":
                fwd(req, resp, "admin/addNotice.jsp");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/admin/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null)
            action = "";

        try {

            switch (action) {

                // Tasks
                case "addTask":
                    Task t = new Task();
                    t.setTitle(req.getParameter("title"));
                    t.setDescription(req.getParameter("description"));
                    t.setCreatedBy((int) req.getSession().getAttribute("userId"));
                    taskDao.insertTask(t);
                    resp.sendRedirect(req.getContextPath() + "/admin/tasks");
                    break;

                case "updateTask":
                    Task ut = new Task();
                    ut.setId(Integer.parseInt(req.getParameter("id")));
                    ut.setTitle(req.getParameter("title"));
                    ut.setDescription(req.getParameter("description"));
                    taskDao.updateTask(ut);
                    resp.sendRedirect(req.getContextPath() + "/admin/tasks");
                    break;

                case "deleteTask":
                    taskDao.deleteTask(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/tasks");
                    break;

                // Notices
                case "addNotice":
                    Notice n = new Notice();
                    n.setTitle(req.getParameter("title"));
                    n.setDescription(req.getParameter("description"));
                    n.setCreatedBy((int) req.getSession().getAttribute("userId"));
                    noticeDao.insertNotice(n);
                    resp.sendRedirect(req.getContextPath() + "/admin/notices");
                    break;

                case "updateNotice":
                    Notice un = new Notice();
                    un.setId(Integer.parseInt(req.getParameter("id")));
                    un.setTitle(req.getParameter("title"));
                    un.setDescription(req.getParameter("description"));
                    noticeDao.updateNotice(un);
                    resp.sendRedirect(req.getContextPath() + "/admin/notices");
                    break;

                case "deleteNotice":
                    noticeDao.deleteNotice(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/notices");
                    break;

                // Orgs
                case "deleteOrg":
                    userService.deleteUserWithProfile(
                            Integer.parseInt(req.getParameter("userId")),
                            "ORGANIZATION");
                    resp.sendRedirect(req.getContextPath() + "/admin/orgs");
                    break;

                case "removeLastOrg":
                    userService.removeLastByRole("ORGANIZATION");
                    resp.sendRedirect(req.getContextPath() + "/admin/orgs");
                    break;

                // Civilians
                case "deleteCivilian":
                    userService.deleteUserWithProfile(
                            Integer.parseInt(req.getParameter("userId")),
                            "CIVILIAN");
                    resp.sendRedirect(req.getContextPath() + "/admin/civilians");
                    break;

                case "removeLastCivilian":
                    userService.removeLastByRole("CIVILIAN");
                    resp.sendRedirect(req.getContextPath() + "/admin/civilians");
                    break;

                // Lock / Unlock user
                case "lockUser":
                    int lockId = Integer.parseInt(req.getParameter("userId"));
                    userService.lockUser(lockId);
                    String lockRole = userService.findById(lockId).getRole();
                    resp.sendRedirect(req.getContextPath() + "/admin/" + ("ORGANIZATION".equals(lockRole) ? "orgs" : "civilians"));
                    break;

                case "unlockUser":
                    int unlockId = Integer.parseInt(req.getParameter("userId"));
                    userService.unlockUser(unlockId);
                    String unlockRole = userService.findById(unlockId).getRole();
                    resp.sendRedirect(req.getContextPath() + "/admin/" + ("ORGANIZATION".equals(unlockRole) ? "orgs" : "civilians"));
                    break;

                case "updateOrg":
                    Organization uo = new Organization();
                    uo.setUserId(Integer.parseInt(req.getParameter("userId")));
                    uo.setOrgName(req.getParameter("orgName"));
                    uo.setOrgType(req.getParameter("orgType"));
                    uo.setAddress(req.getParameter("address"));

                    User uoUser = userService.findById(uo.getUserId());
                    uoUser.setFullName(req.getParameter("fullName"));
                    uoUser.setEmail(req.getParameter("email"));
                    uoUser.setPhone(req.getParameter("phone"));

                    userService.updateUser(uoUser);
                    userService.updateOrgProfile(uo);
                    resp.sendRedirect(req.getContextPath() + "/admin/orgs");
                    break;

                case "updateCivilian":
                    Civilian uc = new Civilian();
                    uc.setUserId(Integer.parseInt(req.getParameter("userId")));
                    uc.setAddress(req.getParameter("address"));
                    try {
                        uc.setWardNo(Integer.parseInt(req.getParameter("wardNo")));
                    } catch (Exception ignored) {
                    }

                    User ucUser = userService.findById(uc.getUserId());
                    ucUser.setFullName(req.getParameter("fullName"));
                    ucUser.setEmail(req.getParameter("email"));
                    ucUser.setPhone(req.getParameter("phone"));

                    userService.updateUser(ucUser);
                    userService.updateCivilianProfile(uc);
                    resp.sendRedirect(req.getContextPath() + "/admin/civilians");
                    break;

                case "addOrg":
                    userService.register(
                            req.getParameter("fullName"),
                            req.getParameter("username"),
                            req.getParameter("password"),
                            req.getParameter("email"),
                            req.getParameter("phone"),
                            "ORGANIZATION",
                            req.getParameter("orgName"),
                            req.getParameter("orgType"),
                            req.getParameter("address"),
                            null);
                    resp.sendRedirect(req.getContextPath() + "/admin/orgs");
                    break;

                case "addCivilian":
                    userService.register(
                            req.getParameter("fullName"),
                            req.getParameter("username"),
                            req.getParameter("password"),
                            req.getParameter("email"),
                            req.getParameter("phone"),
                            "CIVILIAN",
                            null,
                            null,
                            req.getParameter("address"),
                            req.getParameter("wardNo"));
                    resp.sendRedirect(req.getContextPath() + "/admin/civilians");
                    break;

                case "approveTask":
                    taskDao.approveTask(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/tasks");
                    break;

                case "rejectTask":
                    taskDao.rejectTask(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/tasks");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/admin/home");
            }

        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    // Page handlers
    private void showHome(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, Object> stats = dashboardService.getAdminStats();
        stats.forEach(req::setAttribute);
        fwd(req, resp, "admin/home.jsp");
    }

    private void showOrgs(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("orgs", userService.getAllOrgs());
        fwd(req, resp, "admin/orgs.jsp");
    }

    private void showCivilians(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("civilians", userService.getAllCivilians());
        fwd(req, resp, "admin/civilians.jsp");
    }

    private void showTasks(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String status = req.getParameter("status");
        if (status == null || status.isEmpty() || "ALL".equals(status)) {
            req.setAttribute("tasks", taskDao.findAll());
            req.setAttribute("currentFilter", "ALL");
        } else {
            req.setAttribute("tasks", taskDao.findByStatus(status));
            req.setAttribute("currentFilter", status);
        }
        
        req.setAttribute("pendingTasks", taskDao.findByStatus("PENDING"));
        fwd(req, resp, "admin/tasks.jsp");
    }

    private void showNotices(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("notices", noticeDao.findAll());
        fwd(req, resp, "admin/notices.jsp");
    }

    private void showCompletedTasks(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("tasks", taskDao.findByStatus("COMPLETED"));
        fwd(req, resp, "admin/completedTasks.jsp");
    }

    private void showInProgress(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("tasks", taskDao.findByStatus("IN_PROGRESS"));
        fwd(req, resp, "admin/tasksInProgress.jsp");
    }

    private void fwd(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/" + view).forward(req, resp);
    }
}