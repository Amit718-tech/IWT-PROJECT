package com.election.servlet;

import com.election.dao.StudentDAO;
import com.election.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/student-login")
public class StudentLoginServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sic = request.getParameter("sic");
        String password = request.getParameter("password");
        
        if (sic == null || password == null) {
            response.sendRedirect("login.jsp?error=missing");
            return;
        }
        
        Student student = studentDAO.validateLogin(sic, password);
        
        if (student != null) {
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            session.setAttribute("userType", "student");
            response.sendRedirect("student-dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
