<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Student Registration</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: linear-gradient(to right, #1e3c72, #2a5298);
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-box {
            background: white;
            padding: 30px;
            border-radius: 15px;
            width: 350px;
            text-align: center;
        }

        input {
            width: 90%;
            padding: 10px;
            margin: 8px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        button {
            width: 95%;
            padding: 12px;
            background: #2a5298;
            color: white;
            border: none;
            border-radius: 10px;
            margin-top: 10px;
            cursor: pointer;
        }

        .error {
            color: red;
            font-size: 13px;
        }
        
        .success {
            color: green;
            font-size: 13px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-box">
        <h2>Student Register</h2>

        <%
            if (request.getParameter("error") != null) {
                String error = request.getParameter("error");
        %>
            <div class="error">
                <%
                    if (error.equals("missing")) {
                        out.print("Please fill all details!");
                    } else if (error.equals("exists")) {
                        out.print("SIC already exists! Please login.");
                    } else if (error.equals("invalid_year")) {
                        out.print("Invalid year format!");
                    } else {
                        out.print("Registration failed. Please try again.");
                    }
                %>
            </div>
        <%
            }
        %>

        <form action="register" method="post" onsubmit="return validate()">
            <input type="text" name="sic" id="sic" placeholder="Enter SIC" required>
            <input type="email" name="email" id="email" placeholder="Enter Email" required>
            <input type="text" name="year" id="year" placeholder="Enter Year of Joining" required>
            <input type="text" name="section" id="section" placeholder="Enter Section (A/B/C)" required>
            <input type="password" name="password" id="password" placeholder="Set Password" required>
            <input type="password" id="confirm" placeholder="Confirm Password" required>
            <div class="error" id="msg"></div>
            <button type="submit">Register</button>
        </form>
    </div>
</div>

<script>
function validate() {
    let sic = document.getElementById("sic").value.trim();
    let email = document.getElementById("email").value.trim();
    let year = document.getElementById("year").value.trim();
    let section = document.getElementById("section").value.trim().toUpperCase();
    let password = document.getElementById("password").value.trim();
    let confirm = document.getElementById("confirm").value.trim();
    let msg = document.getElementById("msg");

    if (!sic || !email || !year || !section || !password || !confirm) {
        msg.innerText = "Please fill all details!";
        return false;
    }

    if (sic.length < 3) {
        msg.innerText = "SIC must be at least 3 characters";
        return false;
    }

    if (isNaN(year) || year.length !== 4) {
        msg.innerText = "Year must be a 4-digit number";
        return false;
    }

    if (section !== 'A' && section !== 'B' && section !== 'C') {
        msg.innerText = "Section must be A, B, or C";
        return false;
    }

    if (password !== confirm) {
        msg.innerText = "Passwords do not match!";
        return false;
    }

    return true;
}
</script>

</body>
</html>