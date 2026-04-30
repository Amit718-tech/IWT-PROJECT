<%@ page import="java.util.*, com.election.dao.*, com.election.model.*" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ElectionDAO electionDAO = new ElectionDAO();
    VoteDAO voteDAO = new VoteDAO();
    List<Election> ongoingElections = electionDAO.getOngoingElections();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Student Dashboard</title>
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
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .section {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .section h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        .election-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
        }
        .election-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .election-title {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
        }
        .btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn:hover {
            background: #2980b9;
        }
        .vote-btn {
            background: #27ae60;
        }
        .vote-btn:hover {
            background: #2ecc71;
        }
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>
        Welcome, <%= student.getSicNumber() %> (Section <%= student.getSection() %>)
    </div>
    <div>
        <a href="student-dashboard.jsp">Dashboard</a>
        <a href="results.jsp">Results</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <%
        if (request.getParameter("vote") != null && request.getParameter("vote").equals("success")) {
    %>
        <div class="message success">Vote cast successfully!</div>
    <%
        } else if (request.getParameter("vote") != null && request.getParameter("vote").equals("failed")) {
    %>
        <div class="message error">Failed to cast vote. You may have already voted.</div>
    <%
        }
    %>

    <div class="section">
        <h2>Ongoing Elections</h2>
        <%
            if (ongoingElections.isEmpty()) {
        %>
            <p>No ongoing elections at the moment.</p>
        <%
            } else {
                for (Election election : ongoingElections) {
        %>
                <div class="election-card">
                    <div class="election-title"><%= election.getTitle() %></div>
                    <p>Status: <strong style="color: #27ae60;"><%= election.getStatus() %></strong></p>
                    <%
                        if (!voteDAO.hasVoted(student.getSicNumber(), election.getId())) {
                    %>
                        <form action="vote.jsp" method="get">
                            <input type="hidden" name="electionId" value="<%= election.getId() %>">
                            <button type="submit" class="btn vote-btn">Vote Now</button>
                        </form>
                    <%
                        } else {
                    %>
                        <p style="color: #7f8c8d;">You have already voted in this election.</p>
                    <%
                        }
                    %>
                </div>
        <%
                }
            }
        %>
    </div>
</div>

</body>
</html>