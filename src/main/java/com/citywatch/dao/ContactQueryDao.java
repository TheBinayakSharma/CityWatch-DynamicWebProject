package com.citywatch.dao;

import com.citywatch.config.DBConnection;
import com.citywatch.model.ContactQuery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactQueryDao {

    public boolean insert(ContactQuery query) {
        String sql = "INSERT INTO contact_queries (name, phone_number, query_text, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, query.getName());
            ps.setString(2, query.getPhoneNumber());
            ps.setString(3, query.getQueryText());
            ps.setString(4, query.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public java.util.List<ContactQuery> getAllQueries() {
        java.util.List<ContactQuery> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM contact_queries ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactQuery q = new ContactQuery();
                q.setId(rs.getInt("id"));
                q.setName(rs.getString("name"));
                q.setPhoneNumber(rs.getString("phone_number"));
                q.setQueryText(rs.getString("query_text"));
                q.setStatus(rs.getString("status"));
                q.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE contact_queries SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
