package com.election.dao;

import com.election.model.Election;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ElectionDAO {
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/election_portal";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "16012006";  // NO PASSWORD

    private Connection getConnection() throws SQLException {
        try { 
            Class.forName("org.postgresql.Driver"); 
        } catch (ClassNotFoundException e) { 
            e.printStackTrace(); 
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public int createElection(Election election) {
        String sql = "INSERT INTO elections (title, status, created_by) VALUES (?, 'ongoing', ?) RETURNING id";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, election.getTitle());
            ps.setString(2, election.getCreatedBy());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return -1;
    }

    public List<Election> getOngoingElections() {
        List<Election> list = new ArrayList<>();
        String sql = "SELECT * FROM elections WHERE status='ongoing' ORDER BY created_at DESC";
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Election e = new Election();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setStatus(rs.getString("status"));
                e.setCreatedBy(rs.getString("created_by"));
                e.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(e);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    public List<Election> getAllElections() {
        List<Election> list = new ArrayList<>();
        String sql = "SELECT * FROM elections ORDER BY created_at DESC";
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Election e = new Election();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setStatus(rs.getString("status"));
                e.setCreatedBy(rs.getString("created_by"));
                e.setCreatedAt(rs.getTimestamp("created_at"));
                e.setEndedAt(rs.getTimestamp("ended_at"));
                list.add(e);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    public Election getElectionById(int id) {
        String sql = "SELECT * FROM elections WHERE id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Election e = new Election();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setStatus(rs.getString("status"));
                e.setCreatedBy(rs.getString("created_by"));
                e.setCreatedAt(rs.getTimestamp("created_at"));
                e.setEndedAt(rs.getTimestamp("ended_at"));
                return e;
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return null;
    }

    public boolean endElection(int electionId) {
        String sql = "UPDATE elections SET status='ended', ended_at=CURRENT_TIMESTAMP WHERE id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, electionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }
}