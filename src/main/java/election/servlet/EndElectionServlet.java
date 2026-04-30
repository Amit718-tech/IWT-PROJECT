package com.election.servlet;

import com.election.dao.ElectionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/end-election")
public class EndElectionServlet extends HttpServlet {
    private ElectionDAO electionDAO = new ElectionDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        if (session.getAttribute("member") == null) {
            response.sendRedirect("memberacc.jsp");
            return;
        }
        
        int electionId = Integer.parseInt(request.getParameter("electionId"));
        
        if (electionDAO.endElection(electionId)) {
            response.sendRedirect("member-dashboard.jsp?election=ended");
        } else {
            response.sendRedirect("member-dashboard.jsp?error=failed");
        }
    }
}