// com/citywatch/dao/CivilianDao.java
package com.citywatch.dao;

import com.citywatch.config.DBConnection;
import com.citywatch.model.Civilian;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CivilianDao {

    private Connection getConn() {
        return DBConnection.getInstance().getConnection();
    }

    private Civilian mapRow(ResultSet rs) throws SQLException {
        Civilian c = new Civilian();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setAddress(rs.getString("address"));
        c.setWardNo(rs.getInt("ward_no"));
        try { c.setUsername(rs.getString("username")); }  catch (SQLException ignored) {}
        try { c.setEmail(rs.getString("email")); }        catch (SQLException ignored) {}
        try { c.setPhone(rs.getString("phone")); } catch (SQLException ignored) {}
        try { c.setFullName(rs.getString("full_name")); } catch (SQLException ignored) {}
        try { c.setLocked(rs.getBoolean("is_locked")); } catch (SQLException ignored) {}
        return c;
    }

    public List<Civilian> findAll() {
        List<Civilian> list = new ArrayList<>();
        String sql = "SELECT c.*, u.username, u.email, u.phone, u.full_name, u.is_locked " +
                     "FROM civilians c JOIN users u ON c.user_id = u.id ORDER BY c.id DESC";
        try (Statement st = getConn().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("CivilianDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public Civilian findByUserId(int userId) {
        String sql = "SELECT c.*, u.username, u.email, u.phone, u.full_name, u.is_locked " +
                     "FROM civilians c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("CivilianDao.findByUserId: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean insert(Civilian c) {
        String sql = "INSERT INTO civilians (user_id, address, ward_no) VALUES (?,?,?)";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, c.getUserId());
            ps.setString(2, c.getAddress());
            ps.setInt(3, c.getWardNo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CivilianDao.insert: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean update(Civilian c) {
        String sql = "UPDATE civilians SET address=?, ward_no=? WHERE user_id=?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, c.getAddress());
            ps.setInt(2, c.getWardNo());
            ps.setInt(3, c.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CivilianDao.update: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean deleteByUserId(int userId) {
        String sql = "DELETE FROM civilians WHERE user_id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CivilianDao.deleteByUserId: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}