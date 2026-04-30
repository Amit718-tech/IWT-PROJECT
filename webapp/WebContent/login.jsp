<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - Silicon University Election Portal</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-box {
            background: white;
            padding: 40px;
            border-radius: 20px;
            width: 340px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .login-box h2 {
            margin-bottom: 8px;
            color: #2c3e50;
        }
        .login-box .subtitle {
            font-size: 13px;
            color: #6c757d;
            margin-bottom: 22px;
        }
        .input-box {
            width: 90%;
            padding: 12px;
            margin: 8px 0;
            border-radius: 10px;
            border: 1.5px solid #ccc;
            font-size: 14px;
        }
        .input-box:focus {
            outline: none;
            border-color: #2a5298;
        }
        .btn {
            width: 95%;
            padding: 12px;
            margin-top: 12px;
            border: none;
            border-radius: 11px;
            background: #2a5298;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }
        .btn:hover {
            background: #1e3c72;
        }
        .alert {
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 12px;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
        }
        .link {
            margin-top: 14px;
            font-size: 14px;
        }
        .link a {
            color: #2a5298;
            text-decoration: none;
        }
        .link a:hover {
            text-decoration: underline;
        }
        .divider {
            margin: 18px 0;
            font-size: 13px;
            color: gray;
        }
        .committee {
            margin-top: 12px;
            font-size: 13px;
        }
        .committee a {
            color: #1c0503;
            text-decoration: none;
            font-weight: bold;
        }
        .committee a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-box">
        <h2>Election Portal</h2>
        <p class="subtitle">Silicon University - Secure Voting System</p>

        <%
            if (request.getParameter("error") != null && request.getParameter("error").equals("invalid")) {
        %>
            <div class="alert alert-error">Invalid SIC or password. Try again.</div>
        <%
            }
        %>
        <%
            if (request.getParameter("registered") != null && request.getParameter("registered").equals("true")) {
        %>
            <div class="alert alert-success">Registered successfully! Please login.</div>
        <%
            }
        %>

        <form action="student-login" method="post">
            <input type="text" name="sic" class="input-box" placeholder="Enter SIC (e.g. 24bcsg40)" required>
            <input type="password" name="password" class="input-box" placeholder="Enter Password" required>
            <button class="btn" type="submit">Login</button>
        </form>

        <div class="link">
            Don't have an account? <a href="createacc.jsp">Create Account</a>
        </div>

        <div class="divider">---- OR ----</div>

        <div class="committee">
            <a href="memberacc.jsp">Login as Election Committee Member</a>
        </div>
    </div>
</div>

</body>
</html>
