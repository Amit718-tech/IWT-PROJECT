package com.election.dao;

import com.election.model.Student;
import java.sql.*;

public class StudentDAO {
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

    public boolean registerStudent(Student student) {
        String sql = "INSERT INTO students (sic_number, email, section, year, password) VALUES (?,?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student.getSicNumber());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getSection());
            ps.setInt(4, student.getYear());
            ps.setString(5, student.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    public Student validateLogin(String sicNumber, String password) {
        String sql = "select * FROM students WHERE sic_number=? AND password=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sicNumber);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = new Student();
                s.setSicNumber(rs.getString("sic_number"));
                s.setEmail(rs.getString("email"));
                s.setSection(rs.getString("section"));
                s.setYear(rs.getInt("year"));
                s.setPassword(rs.getString("password"));
                return s;
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return null;
    }

    public boolean studentExists(String sicNumber) {
        String sql = "SELECT 1 FROM students WHERE sic_number=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sicNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }
}
