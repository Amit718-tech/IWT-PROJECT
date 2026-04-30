<%@ page import="java.util.*, com.election.dao.*, com.election.model.*" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int electionId = Integer.parseInt(request.getParameter("electionId"));
    ElectionDAO electionDAO = new ElectionDAO();
    CandidateDAO candidateDAO = new CandidateDAO();
    VoteDAO voteDAO = new VoteDAO();
    
    Election election = electionDAO.getElectionById(electionId);
    
    if (election == null || !election.getStatus().equals("ongoing")) {
        response.sendRedirect("student-dashboard.jsp");
        return;
    }
    
    if (voteDAO.hasVoted(student.getSicNumber(), electionId)) {
        response.sendRedirect("student-dashboard.jsp?vote=failed");
        return;
    }
    
    List<Candidate> candidates = candidateDAO.getCandidatesByElection(electionId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Cast Your Vote</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0f2f5;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .candidate {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #f9f9f9;
        }
        .candidate:hover {
            background: #f0f0f0;
        }
        input[type="radio"] {
            margin-right: 10px;
            transform: scale(1.2);
        }
        .candidate-name {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }
        .candidate-sic {
            color: #7f8c8d;
            font-size: 14px;
        }
        .candidate-desc {
            margin-top: 10px;
            color: #555;
        }
        .btn {
            background: #27ae60;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .btn:hover {
            background: #2ecc71;
        }
        .btn-cancel {
            background: #95a5a6;
            margin-left: 10px;
        }
        .btn-cancel:hover {
            background: #7f8c8d;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Vote for: <%= election.getTitle() %></h2>
    
    <form action="cast-vote" method="post">
        <input type="hidden" name="electionId" value="<%= electionId %>">
        
        <%
            for (Candidate c : candidates) {
        %>
            <div class="candidate">
                <input type="radio" name="candidateId" value="<%= c.getId() %>" required>
                <span class="candidate-name"><%= c.getName() %></span>
                <span class="candidate-sic">(SIC: <%= c.getSicNumber() %>)</span>
                <div class="candidate-desc"><%= c.getDescription() != null ? c.getDescription() : "No description provided" %></div>
            </div>
        <%
            }
        %>
        
        <button type="submit" class="btn">Confirm Vote</button>
        <a href="student-dashboard.jsp"><button type="button" class="btn btn-cancel">Cancel</button></a>
    </form>
</div>

</body>
</html>