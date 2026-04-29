<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>College Election Portal</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background-color: #4d4f52;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
        }

        .logo img {
            width: 40px;
            margin-right: 10px;
        }

        .menu a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
            font-size: 16px;
        }

        .menu a:hover {
            text-decoration: underline;
        }

        .hero {
            height: 80vh;
            background: linear-gradient(to right, #dfe1e5, #c9d6ed);
            color: rgb(3, 0, 7);
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .hero h1 {
            font-size: 45px;
            margin-bottom: 10px;
        }

        .hero p {
            font-size: 18px;
        }

        .top-img {
            width: 500px;
            margin-bottom: 15px;
            border-radius: 10px;
        }

        .bottom-images {
            margin-top: 25px;
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        .bottom-images img {
            width: 300px;
            height: 160px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .footer {
            background-color: #174a8b;
            color: white;
            display: flex;
            justify-content: space-between;
            padding: 30px 60px;
            flex-wrap: wrap;
        }

        .footer-left img {
            width: 50px;
            margin-bottom: 10px;
        }

        .footer-left p {
            line-height: 1.6;
        }

        .footer-center {
            text-align: center;
        }

        .footer-right {
            text-align: right;
        }

        .footer-right h3 {
            margin: 5px 0;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="logo">
           
            Silicon University
        </div>
        <div class="menu">
            <a href="https://www.bing.com/ck/a?!&&p=ccc0fcfdcae9e273cc5384f376de618cd9b9bdbb0f078af5dd47232fd3e23a11JmltdHM9MTc3NzMzNDQwMA&ptn=3&ver=2&hsh=4&fclid=04305bfa-d699-6df4-17ff-4f85d7cb6cd6&psq=silicon+university&u=a1aHR0cHM6Ly9zaWxpY29uLmFjLmluLw">Home</a>
            <a href="login.jsp">Login / Sign Up</a>
            <a href="about.jsp">About Us</a>
        </div>
    </div>

    <div class="hero">
        <div>
            <img src="https://images.shiksha.com/mediadata/images/1545110892php6P9h5M.png" class="top-img" alt="College">
            <h1>Welcome to College Election Portal</h1>
            <p>Vote securely and transparently for your college leaders</p>
            <div class="bottom-images">
                <img src="https://th.bing.com/th/id/OIP.3I3bMRZzBkQ5Gtreaotd9QHaFL?w=255&h=180&c=7&r=0&o=7&dpr=2&pid=1.7&rm=3" alt="Voting">
                <img src="https://tse3.mm.bing.net/th/id/OIP.sDE0AjLc7ZF5VZg6_23cVAHaFL?rs=1&pid=ImgDetMain&o=7&rm=3" alt="Election">
                <img src="https://th.bing.com/th/id/OIP.8-XVoPOJAMDVXaXlwgPrVgHaFL?w=243&h=180&c=7&r=0&o=7&dpr=2&pid=1.7&rm=3" alt="Students">
            </div>
        </div>
    </div>

    <div class="footer">
        <div class="footer-left">
            <p>
                Silicon University,<br>
                Silicon Hills, Patia,<br>
                Bhubaneswar - 751024<br>
                Odisha, India.
            </p>
        </div>
        <div class="footer-center">
            <p>Phone: 9937289499 / 06742725448</p>
            <p>Email: info@silicon.ac.in</p>
        </div>
        <div class="footer-right">
            <p style="font-size: 12px;">Formerly known as</p>
            <h3>Silicon Institute<br>of Technology</h3>
            <p>All rights reserved.</p>
        </div>
    </div>
</body>
</html>