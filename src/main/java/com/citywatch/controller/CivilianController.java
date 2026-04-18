// com/citywatch/controller/CivilianController.java
package com.citywatch.controller;

import com.citywatch.dao.NoticeDao;
import com.citywatch.dao.TaskDao;
import com.citywatch.service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/civilian/*")
public class CivilianController extends HttpServlet {

    private final TaskDao taskDao = new TaskDao();
    private final NoticeDao noticeDao = new NoticeDao();
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/home";

        switch (path) {
            case "/home":
                showHome(req, resp);
                break;

            case "/notices":
                showNotices(req, resp);
                break;

            case "/tasks":
                showAvailable(req, resp);
                break;

            case "/inProgress":
                showInProgress(req, resp);
                break;

            case "/completed":
                showCompleted(req, resp);
                break;

            case "/requestTask":
                fwd(req, resp, "civilian/requestTask.jsp");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/civilian/home");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String path = req.getPathInfo();
        if ("/requestTask".equals(path)) {
            doRequestTask(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/civilian/home");
        }
    }

    private void doRequestTask(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");
        String title = req.getParameter("title");
        String desc = req.getParameter("description");

        com.citywatch.model.Task task = new com.citywatch.model.Task();
        task.setTitle(title);
        task.setDescription(desc);
        task.setCreatedBy(userId);

        taskDao.insertTaskWithStatus(task, "PENDING");
        resp.sendRedirect(req.getContextPath() + "/civilian/home?success=Request sent for approval");
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, Object> stats = dashboardService.getCivilianStats();
        stats.forEach(req::setAttribute);
        fwd(req, resp, "civilian/home.jsp");
    }

    private void showNotices(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("notices", noticeDao.findAll());
        fwd(req, resp, "civilian/notices.jsp");
    }

    private void showAvailable(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("tasks", taskDao.findByStatus("AVAILABLE"));
        fwd(req, resp, "civilian/tasks.jsp");
    }

    private void showInProgress(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("tasks", taskDao.findByStatus("IN_PROGRESS"));
        fwd(req, resp, "civilian/inProgress.jsp");
    }

    private void showCompleted(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("tasks", taskDao.findByStatus("COMPLETED"));
        fwd(req, resp, "civilian/completed.jsp");
    }

    private void fwd(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/" + view).forward(req, resp);
    }
}