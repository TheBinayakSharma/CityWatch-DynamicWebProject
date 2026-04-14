// com/citywatch/dao/OrganizationDao.java
package com.citywatch.dao;

import com.citywatch.config.DBConnection;
import com.citywatch.model.Organization;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrganizationDao {

    private Connection getConn() {
        return DBConnection.getInstance().getConnection();
    }

    private Organization mapRow(ResultSet rs) throws SQLException {
        Organization o = new Organization();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setOrgName(rs.getString("org_name"));
        o.setOrgType(rs.getString("org_type"));
        o.setAddress(rs.getString("address"));
        // joined columns (may or may not be present)
        try { o.setUsername(rs.getString("username")); } catch (SQLException ignored) {}
        try { o.setEmail(rs.getString("email")); }       catch (SQLException ignored) {}
        try { o.setPhone(rs.getString("phone")); }       catch (SQLException ignored) {}
        try { o.setFullName(rs.getString("full_name")); } catch (SQLException ignored) {}
        return o;
    }

    public List<Organization> findAll() {
        List<Organization> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username, u.email, u.phone, u.full_name " +
                     "FROM organizations o JOIN users u ON o.user_id = u.id ORDER BY o.id DESC";
        try (Statement st = getConn().createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("OrganizationDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }

    public Organization findByUserId(int userId) {
        String sql = "SELECT o.*, u.username, u.email, u.phone, u.full_name " +
                     "FROM organizations o JOIN users u ON o.user_id = u.id WHERE o.user_id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("OrganizationDao.findByUserId: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean insert(Organization org) {
        String sql = "INSERT INTO organizations (user_id, org_name, org_type, address) VALUES (?,?,?,?)";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, org.getUserId());
            ps.setString(2, org.getOrgName());
            ps.setString(3, org.getOrgType());
            ps.setString(4, org.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("OrganizationDao.insert: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean update(Organization org) {
        String sql = "UPDATE organizations SET org_name=?, org_type=?, address=? WHERE user_id=?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setString(1, org.getOrgName());
            ps.setString(2, org.getOrgType());
            ps.setString(3, org.getAddress());
            ps.setInt(4, org.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("OrganizationDao.update: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean deleteByUserId(int userId) {
        String sql = "DELETE FROM organizations WHERE user_id = ?";
        try (PreparedStatement ps = getConn().prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("OrganizationDao.deleteByUserId: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}