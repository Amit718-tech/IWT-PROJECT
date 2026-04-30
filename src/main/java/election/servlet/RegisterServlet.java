package com.election.servlet;

import com.election.dao.StudentDAO;
import com.election.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sic = request.getParameter("sic");
        String email = request.getParameter("email");
        String yearStr = request.getParameter("year");
        String section = request.getParameter("section");
        String password = request.getParameter("password");

        if (sic == null || email == null || yearStr == null || section == null || password == null) {
            response.sendRedirect("createacc.jsp?error=missing");
            return;
        }
        
        int year;
        try {
            year = Integer.parseInt(yearStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("createacc.jsp?error=invalid_year");
            return;
        }
        
        if (studentDAO.studentExists(sic)) {
            response.sendRedirect("createacc.jsp?error=exists");
            return;
        }
        
        Student student = new Student(sic, email, section.toUpperCase(), year, password);
        
        if (studentDAO.registerStudent(student)) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            response.sendRedirect("createacc.jsp?error=registration_failed");
        }
    }
}