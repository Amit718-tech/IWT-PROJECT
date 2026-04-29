package com.election.dao;

import com.election.model.Candidate;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidateDAO {
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

    public boolean addCandidate(Candidate candidate) {
        String sql = "INSERT INTO candidates (election_id, sic_number, name, description) VALUES (?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, candidate.getElectionId());
            ps.setString(2, candidate.getSicNumber());
            ps.setString(3, candidate.getName());
            ps.setString(4, candidate.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    public List<Candidate> getCandidatesByElection(int electionId) {
        List<Candidate> list = new ArrayList<>();
        String sql = "SELECT * FROM candidates WHERE election_id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, electionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Candidate c = new Candidate();
                c.setId(rs.getInt("id"));
                c.setElectionId(rs.getInt("election_id"));
                c.setSicNumber(rs.getString("sic_number"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                list.add(c);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }
}