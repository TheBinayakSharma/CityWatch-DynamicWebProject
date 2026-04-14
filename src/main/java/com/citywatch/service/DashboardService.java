// com/citywatch/service/DashboardService.java
package com.citywatch.service;

import com.citywatch.dao.NoticeDao;
import com.citywatch.dao.TaskDao;
import com.citywatch.dao.UserDao;
import com.citywatch.model.Notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Aggregates all statistics and recent-notice data needed
 * by every role's dashboard in a single service call.
 */
public class DashboardService {

    private final UserDao userDao = new UserDao();
    private final TaskDao taskDao = new TaskDao();
    private final NoticeDao noticeDao = new NoticeDao();

    // =========================
    // Admin dashboard stats
    // =========================
    public Map<String, Object> getAdminStats() {

        int available = taskDao.countByStatus("AVAILABLE");
        int inProgress = taskDao.countByStatus("IN_PROGRESS");
        int completed = taskDao.countByStatus("COMPLETED");

        Map<String, Object> stats = new HashMap<>();

        stats.put("totalOrgs", userDao.countByRole("ORGANIZATION"));
        stats.put("totalCivilians", userDao.countByRole("CIVILIAN"));

        stats.put("totalAvailable", available);
        stats.put("tasksInProgress", inProgress);
        stats.put("completedTasks", completed);

        stats.put("totalTasks", available + inProgress + completed);

        stats.put("totalNotices", noticeDao.count());
        stats.put("recentNotices", noticeDao.findRecent(5));

        return stats;
    }

    // =========================
    // Org dashboard stats
    // =========================
    public Map<String, Object> getOrgStats(int orgUserId) {

        Map<String, Object> stats = new HashMap<>();

        stats.put("availableCount", taskDao.countByStatus("AVAILABLE"));
        stats.put("assignedCount",
                taskDao.findByOrgAndStatus(orgUserId, "IN_PROGRESS").size());
        stats.put("completedCount",
                taskDao.findByOrgAndStatus(orgUserId, "COMPLETED").size());

        stats.put("recentNotices", noticeDao.findRecent(5));

        return stats;
    }

    // =========================
    // Civilian dashboard stats
    // =========================
    public Map<String, Object> getCivilianStats() {

        Map<String, Object> stats = new HashMap<>();

        stats.put("availableCount", taskDao.countByStatus("AVAILABLE"));
        stats.put("inProgressCount", taskDao.countByStatus("IN_PROGRESS"));
        stats.put("completedCount", taskDao.countByStatus("COMPLETED"));

        stats.put("recentNotices", noticeDao.findRecent(5));

        return stats;
    }

    // =========================
    // Convenience method
    // =========================
    public List<Notice> getRecentNotices(int limit) {
        return noticeDao.findRecent(limit);
    }
}