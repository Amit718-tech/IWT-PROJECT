package com.election.servlet;

import com.election.dao.VoteDAO;
import com.election.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cast-vote")
public class CastVoteServlet extends HttpServlet {
    private VoteDAO voteDAO = new VoteDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        
        if (student == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int candidateId = Integer.parseInt(request.getParameter("candidateId"));
        int electionId = Integer.parseInt(request.getParameter("electionId"));
        
        boolean success = voteDAO.castVote(student.getSicNumber(), candidateId, electionId);
        
        if (success) {
            response.sendRedirect("student-dashboard.jsp?vote=success");
        } else {
            response.sendRedirect("student-dashboard.jsp?vote=failed");
        }
    }
}