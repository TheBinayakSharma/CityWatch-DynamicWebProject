// com/citywatch/dao/NoticeDao.java
package com.citywatch.dao;

import com.citywatch.config.DBConnection;
import com.citywatch.model.Notice;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoticeDao {

    private Connection getConn() {
        return DBConnection.getInstance().getConnection();
    }

    private Notice mapRow(ResultSet rs) throws SQLException {
        Notice n = new Notice();
        n.setId(rs.getInt("id"));
        n.setTitle(rs.getString("title"));
        n.setDescription(rs.getString("description"));
        n.setCreatedBy(rs.getInt("created_by"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        n.setUpdatedAt(rs.getTimestamp("updated_at"));
        return n;
    }

    public List<Notice> findAll() {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT * FROM notices ORDER BY created_at DESC";
        try (Statement st = getConn().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("NoticeDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Notice> findRecent(int limit) {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT * FROM notices ORDER BY created_at DESC LIMIT ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("NoticeDao.findRecent: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public Notice findById(int id) {
        String sql = "SELECT * FROM notices WHERE id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("NoticeDao.findById: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean insertNotice(Notice notice) {
        String sql = "INSERT INTO notices (title, description, created_by) VALUES (?,?,?)";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, notice.getTitle());
            ps.setString(2, notice.getDescription());
            ps.setInt(3, notice.getCreatedBy());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("NoticeDao.insertNotice: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean updateNotice(Notice notice) {
        String sql = "UPDATE notices SET title=?, description=? WHERE id=?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, notice.getTitle());
            ps.setString(2, notice.getDescription());
            ps.setInt(3, notice.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("NoticeDao.updateNotice: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean deleteNotice(int id) {
        String sql = "DELETE FROM notices WHERE id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("NoticeDao.deleteNotice: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public int count() {
        String sql = "SELECT COUNT(*) FROM notices";
        try (Statement st = getConn().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("NoticeDao.count: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return 0;
    }
}