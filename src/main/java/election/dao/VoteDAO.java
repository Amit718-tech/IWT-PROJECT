package com.election.dao;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class VoteDAO {
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

    public boolean hasVoted(String studentSic, int electionId) {
        String sql = "SELECT 1 FROM votes WHERE student_sic=? AND election_id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentSic);
            ps.setInt(2, electionId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    public boolean castVote(String studentSic, int candidateId, int electionId) {
        if (hasVoted(studentSic, electionId)) return false;
        String sql = "INSERT INTO votes (student_sic, candidate_id, election_id) VALUES (?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentSic);
            ps.setInt(2, candidateId);
            ps.setInt(3, electionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    public Map<Integer, Integer> getElectionResults(int electionId) {
        Map<Integer, Integer> results = new HashMap<>();
        String sql = "SELECT candidate_id, COUNT(*) as cnt FROM votes WHERE election_id=? GROUP BY candidate_id";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, electionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                results.put(rs.getInt("candidate_id"), rs.getInt("cnt"));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return results;
    }
}