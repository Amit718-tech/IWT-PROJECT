<%@ page import="java.util.*, com.election.dao.*, com.election.model.*" %>
<%
    Member member = (Member) session.getAttribute("member");
    if (member == null) {
        response.sendRedirect("memberacc.jsp");
        return;
    }
    ElectionDAO electionDAO = new ElectionDAO();
    List<Election> elections = electionDAO.getAllElections();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Committee Dashboard</title>
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
            border-bottom: 2px solid #e74c3c;
            padding-bottom: 10px;
        }
        .election-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
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
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-create {
            background: #27ae60;
            font-size: 16px;
            padding: 12px 25px;
        }
        .btn-create:hover {
            background: #2ecc71;
        }
        .btn-end {
            background: #e74c3c;
        }
        .btn-end:hover {
            background: #c0392b;
        }
        .status-ongoing {
            color: #27ae60;
            font-weight: bold;
        }
        .status-ended {
            color: #7f8c8d;
            font-weight: bold;
        }
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>
        Committee: <%= member.getName() %> (SIC: <%= member.getSicNumber() %>)
    </div>
    <div>
        <a href="member-dashboard.jsp">Dashboard</a>
        <a href="create-election.jsp">Create Election</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <%
        if (request.getParameter("election") != null && request.getParameter("election").equals("created")) {
    %>
        <div class="message">Election created successfully!</div>
    <%
        } else if (request.getParameter("election") != null && request.getParameter("election").equals("ended")) {
    %>
        <div class="message">Election ended. Results are now visible to students.</div>
    <%
        }
    %>

    <div style="margin-bottom: 20px;">
        <a href="create-election.jsp"><button class="btn btn-create">Create New Election</button></a>
    </div>

    <div class="section">
        <h2>All Elections</h2>
        <%
            if (elections.isEmpty()) {
        %>
            <p>No elections created yet. Click "Create New Election" to start.</p>
        <%
            } else {
                for (Election election : elections) {
        %>
                <div class="election-card">
                    <div class="election-title"><%= election.getTitle() %></div>
                    <p>Status: 
                        <%
                            if ("ongoing".equals(election.getStatus())) {
                        %>
                            <span class="status-ongoing">ONGOING</span>
                        <%
                            } else {
                        %>
                            <span class="status-ended">ENDED</span>
                        <%
                            }
                        %>
                    </p>
                    <p>Created: <%= election.getCreatedAt() %></p>
                    <%
                        if ("ongoing".equals(election.getStatus())) {
                    %>
                        <form action="end-election" method="post" style="display: inline;">
                            <input type="hidden" name="electionId" value="<%= election.getId() %>">
                            <button type="submit" class="btn btn-end" onclick="return confirm('Are you sure? This will end the election and make results visible to students.')">End Election</button>
                        </form>
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