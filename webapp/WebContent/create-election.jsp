<%@ page import="com.election.model.Member" %>
<%
    Member member = (Member) session.getAttribute("member");
    if (member == null) {
        response.sendRedirect("memberacc.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create Election</title>
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
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-family: Arial;
        }
        .candidate-block {
            border: 1px solid #ddd;
            padding: 15px;
            margin-top: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .btn {
            background: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
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
    <script>
        function updateCandidates() {
            let num = document.getElementById("numCandidates").value;
            let container = document.getElementById("candidatesContainer");
            container.innerHTML = "";
            for (let i = 1; i <= num; i++) {
                container.innerHTML = container.innerHTML + `
                    <div class="candidate-block">
                        <h4>Candidate ` + i + `</h4>
                        <label>SIC Number:</label>
                        <input type="text" name="candidateSic_` + i + `" required>
                        <label>Full Name:</label>
                        <input type="text" name="candidateName_` + i + `" required>
                        <label>Description:</label>
                        <textarea name="candidateDesc_` + i + `" rows="2"></textarea>
                    </div>
                `;
            }
        }
    </script>
</head>
<body>

<div class="navbar">
    <div>
        Committee: <%= member.getName() %>
    </div>
    <div>
        <a href="member-dashboard.jsp">Dashboard</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Create New Election</h2>
    <form action="create-election" method="post">
        <label>Election Title:</label>
        <input type="text" name="title" required>
        
        <label>Number of Candidates:</label>
        <input type="number" name="numCandidates" id="numCandidates" min="1" max="10" required onchange="updateCandidates()">
        
        <div id="candidatesContainer"></div>
        
        <button type="submit" class="btn">Create Election</button>
        <a href="member-dashboard.jsp"><button type="button" class="btn btn-cancel">Cancel</button></a>
    </form>
</div>

</body>
</html>