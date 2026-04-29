package com.election.dao;

import com.election.model.Member;
import java.sql.*;

public class MemberDAO {
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

    public Member validateLogin(String sicNumber, String password) {
        String sql = "SELECT * FROM members WHERE sic_number=? AND password=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sicNumber);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member m = new Member();
                m.setSicNumber(rs.getString("sic_number"));
                m.setPassword(rs.getString("password"));
                m.setName(rs.getString("name"));
                m.setRole(rs.getString("role"));
                return m;
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return null;
    }
}