// com/citywatch/dao/TaskDao.java
package com.citywatch.dao;

import com.citywatch.config.DBConnection;
import com.citywatch.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDao {

    private Connection getConn() {
        return DBConnection.getInstance().getConnection();
    }

    private Task mapRow(ResultSet rs) throws SQLException {
        Task t = new Task();
        t.setId(rs.getInt("id"));
        t.setTitle(rs.getString("title"));
        t.setDescription(rs.getString("description"));
        t.setStatus(rs.getString("status"));
        int ao = rs.getInt("assigned_org");
        t.setAssignedOrg(rs.wasNull() ? null : ao);
        t.setCreatedBy(rs.getInt("created_by"));
        t.setCreatedAt(rs.getTimestamp("created_at"));
        t.setCompletedAt(rs.getTimestamp("completed_at"));
        try { t.setAssignedOrgName(rs.getString("org_name")); } catch (SQLException ignored) {}
        return t;
    }

    public List<Task> findAll() {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, o.org_name FROM tasks t " +
                     "LEFT JOIN organizations o ON t.assigned_org = o.user_id ORDER BY t.created_at DESC";
        try (Statement st = getConn().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("TaskDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Task> findByStatus(String status) {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, o.org_name FROM tasks t " +
                     "LEFT JOIN organizations o ON t.assigned_org = o.user_id " +
                     "WHERE t.status = ? ORDER BY t.created_at DESC";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("TaskDao.findByStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Task> findByOrgId(int orgUserId) {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, o.org_name FROM tasks t " +
                     "LEFT JOIN organizations o ON t.assigned_org = o.user_id " +
                     "WHERE t.assigned_org = ? ORDER BY t.created_at DESC";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, orgUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("TaskDao.findByOrgId: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Task> findByOrgAndStatus(int orgUserId, String status) {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, o.org_name FROM tasks t " +
                     "LEFT JOIN organizations o ON t.assigned_org = o.user_id " +
                     "WHERE t.assigned_org = ? AND t.status = ? ORDER BY t.created_at DESC";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, orgUserId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("TaskDao.findByOrgAndStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public boolean insertTask(Task task) {
        String sql = "INSERT INTO tasks (title, description, created_by) VALUES (?,?,?)";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setInt(3, task.getCreatedBy());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("TaskDao.insertTask: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean updateTask(Task task) {
        String sql = "UPDATE tasks SET title=?, description=? WHERE id=?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setInt(3, task.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("TaskDao.updateTask: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean deleteTask(int id) {
        String sql = "DELETE FROM tasks WHERE id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("TaskDao.deleteTask: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean claimTask(int taskId, int orgUserId) {
        String sql = "UPDATE tasks SET status='IN_PROGRESS', assigned_org=? WHERE id=? AND status='AVAILABLE'";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, orgUserId);
            ps.setInt(2, taskId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("TaskDao.claimTask: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean completeTask(int taskId) {
        String sql = "UPDATE tasks SET status='COMPLETED', completed_at=NOW() WHERE id=? AND status='IN_PROGRESS'";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, taskId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("TaskDao.completeTask: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM tasks WHERE status = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("TaskDao.countByStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return 0;
    }
}