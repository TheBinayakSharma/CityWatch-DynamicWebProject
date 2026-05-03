package com.citywatch.controller;

import com.citywatch.dao.NoticeDao;
import com.citywatch.dao.TaskDao;
import com.citywatch.service.DashboardService;
import com.citywatch.service.TaskService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/org/*")
public class OrgController extends HttpServlet {

    private final TaskDao taskDao = new TaskDao();
    private final NoticeDao noticeDao = new NoticeDao();
    private final TaskService taskService = new TaskService();
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) path = "/home";

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int orgUserId = (int) session.getAttribute("userId");

        switch (path) {
            case "/home":
                showHome(req, resp, orgUserId);
                break;
            case "/notices":
                showNotices(req, resp);
                break;
            case "/tasks":
                showAvailable(req, resp);
                break;
            case "/assigned":
                showAssigned(req, resp, orgUserId);
                break;
            case "/completed":
                showCompleted(req, resp, orgUserId);
                break;
            case "/inProgress":
                showAllInProgress(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/org/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int orgUserId = (int) session.getAttribute("userId");

        try {
            switch (action != null ? action : "") {
                case "claimTask":
                    taskService.claimTask(Integer.parseInt(req.getParameter("taskId")), orgUserId);
                    resp.sendRedirect(req.getContextPath() + "/org/assigned");
                    break;
                case "completeTask":
                    taskService.completeTask(Integer.parseInt(req.getParameter("taskId")), orgUserId);
                    resp.sendRedirect(req.getContextPath() + "/org/completed");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/org/home");
            }
        } catch (Exception e) {
            req.setAttribute("errorMsg", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp, int orgUserId)
            throws ServletException, IOException {
        Map<String, Object> stats = dashboardService.getOrgStats(orgUserId);
        stats.forEach(req::setAttribute);
        fwd(req, resp, "org/home.jsp");
    }

    private void showNotices(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("notices", noticeDao.findAll());
        fwd(req, resp, "org/notices.jsp");
    }

    private void showAvailable(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("tasks", taskDao.findByStatus("AVAILABLE"));
        fwd(req, resp, "org/tasks.jsp");
    }

    private void showAssigned(HttpServletRequest req, HttpServletResponse resp, int orgUserId)
            throws ServletException, IOException {
        req.setAttribute("tasks", taskDao.findByOrgAndStatus(orgUserId, "IN_PROGRESS"));
        fwd(req, resp, "org/assigned.jsp");
    }

    private void showCompleted(HttpServletRequest req, HttpServletResponse resp, int orgUserId)
            throws ServletException, IOException {
        req.setAttribute("tasks", taskDao.findByOrgAndStatus(orgUserId, "COMPLETED"));
        fwd(req, resp, "org/completed.jsp");
    }

    private void showAllInProgress(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("tasks", taskDao.findByStatus("IN_PROGRESS"));
        fwd(req, resp, "org/inProgress.jsp");
    }

    private void fwd(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/" + view).forward(req, resp);
    }
}