<%@ page import="java.util.*, com.election.dao.*, com.election.model.*" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ElectionDAO electionDAO = new ElectionDAO();
    CandidateDAO candidateDAO = new CandidateDAO();
    VoteDAO voteDAO = new VoteDAO();
    
    List<Election> endedElections = new ArrayList<>();
    List<Election> allElections = electionDAO.getAllElections();
    
    for (Election e : allElections) {
        if (e.getStatus().equals("ended")) {
            endedElections.add(e);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Election Results</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }
        .navbar {
            background: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 15px;
            border-radius: 5px;
        }
        .navbar a:hover {
            background: #34495e;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        .result {
            border-bottom: 1px solid #ddd;
            margin-bottom: 25px;
            padding-bottom: 20px;
        }
        .result h3 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .candidate-result {
            margin-left: 20px;
            padding: 8px;
            border-left: 3px solid #3498db;
            margin-top: 5px;
        }
        .vote-count {
            font-weight: bold;
            color: #27ae60;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #3498db;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .total-votes {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>
        Welcome, <%= student.getSicNumber() %>
    </div>
    <div>
        <a href="student-dashboard.jsp">Dashboard</a>
        <a href="results.jsp">Results</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Election Results</h2>
    <a href="student-dashboard.jsp" class="back-link"> Back to Dashboard</a>
    
    <%
        if (endedElections.isEmpty()) {
    %>
        <p>No completed elections yet. Results will appear here after elections end.</p>
    <%
        } else {
            for (Election e : endedElections) {
                Map<Integer, Integer> voteCounts = voteDAO.getElectionResults(e.getId());
                List<Candidate> candidates = candidateDAO.getCandidatesByElection(e.getId());
                
                int totalVotes = 0;
                for (int votes : voteCounts.values()) {
                    totalVotes = totalVotes + votes;
                }
    %>
                <div class="result">
                    <h3><%= e.getTitle() %></h3>
                    <div class="total-votes">Total Votes Cast: <%= totalVotes %></div>
                    <%
                        for (Candidate c : candidates) {
                            int votes = 0;
                            if (voteCounts.containsKey(c.getId())) {
                                votes = voteCounts.get(c.getId());
                            }
                            double percent = 0;
                            if (totalVotes > 0) {
                                percent = (votes * 100.0 / totalVotes);
                            }
                    %>
                        <div class="candidate-result">
                            <strong><%= c.getName() %></strong> (SIC: <%= c.getSicNumber() %>) - 
                            <span class="vote-count"><%= votes %> votes</span> 
                            (<%= String.format("%.1f", percent) %>%)
                        </div>
                    <%
                        }
                    %>
                </div>
    <%
            }
        }
    %>
</div>

</body>
</html>