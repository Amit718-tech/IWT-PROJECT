package com.election.servlet;

import com.election.dao.ElectionDAO;
import com.election.dao.CandidateDAO;
import com.election.model.Election;
import com.election.model.Candidate;
import com.election.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/create-election")
public class CreateElectionServlet extends HttpServlet {
    private ElectionDAO electionDAO = new ElectionDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");
        
        if (member == null) {
            response.sendRedirect("memberacc.jsp");
            return;
        }
        
        String title = request.getParameter("title");
        int numCandidates = Integer.parseInt(request.getParameter("numCandidates"));
        
        Election election = new Election();
        election.setTitle(title);
        election.setCreatedBy(member.getSicNumber());
        
        int electionId = electionDAO.createElection(election);
        
        if (electionId != -1) {
            for (int i = 1; i <= numCandidates; i++) {
                String sic = request.getParameter("candidateSic_" + i);
                String name = request.getParameter("candidateName_" + i);
                String description = request.getParameter("candidateDesc_" + i);
                
                Candidate candidate = new Candidate();
                candidate.setElectionId(electionId);
                candidate.setSicNumber(sic);
                candidate.setName(name);
                candidate.setDescription(description);
                
                candidateDAO.addCandidate(candidate);
            }
            response.sendRedirect("member-dashboard.jsp?election=created");
        } else {
            response.sendRedirect("create-election.jsp?error=failed");
        }
    }
}