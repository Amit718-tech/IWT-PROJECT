<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Committee Login - Election Portal</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #2c3fe8, #e74c3c);
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-box {
            background: white;
            padding: 35px;
            border-radius: 15px;
            width: 360px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
        }
        .form-box .icon {
            font-size: 36px;
            margin-bottom: 8px;
        }
        .form-box h2 {
            color: #2c3e50;
            margin-bottom: 6px;
        }
        .form-box .sub {
            font-size: 13px;
            color: #6c757d;
            margin-bottom: 22px;
        }
        input {
            width: 90%;
            padding: 12px;
            margin: 8px;
            border-radius: 8px;
            border: 1.5px solid #ccc;
            font-size: 14px;
        }
        input:focus {
            outline: none;
            border-color: #2c3fe8;
        }
        button {
            width: 95%;
            padding: 12px;
            background: #0c1a6c;
            color: white;
            border: none;
            border-radius: 10px;
            margin-top: 10px;
            cursor: pointer;
            font-size: 15px;
        }
        button:hover {
            background: #2838e7;
        }
        .alert {
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 10px;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }
        .back-link {
            margin-top: 16px;
            font-size: 13px;
        }
        .back-link a {
            color: #2c3fe8;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-box">
        <div class="icon">S</div>
        <h2>Committee Login</h2>
        <p class="sub">Election Committee Members Only</p>

        <%
            if (request.getParameter("error") != null && request.getParameter("error").equals("invalid")) {
        %>
            <div class="alert alert-error">Invalid SIC or password.</div>
        <%
            }
        %>

        <form action="member-login" method="post">
            <input type="text" name="sic" placeholder="Enter SIC (e.g. admin001)" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <button type="submit">Login as Committee Member</button>
        </form>

        <div class="back-link">
            <a href="login.jsp"> Back to Student Login</a>
        </div>
    </div>
</div>

</body>
</html>