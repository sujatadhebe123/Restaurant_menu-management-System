<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header1.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome - Restaurant Menu System</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('background1.jpg'); /* Ensure the image exists */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.8); /* Light overlay for better readability */
            margin: 50px auto;
            border-radius: 10px;
            width: 80%;
            max-width: 600px;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            margin: 10px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="main-content">
    <h1>🍽️ Welcome to Aabhyay's Restaurant</h1>
    <p>Select your role to continue:</p>
    <a href="view_menu.jsp" class="btn">Admin Panel</a>
    <a href="cutomer_menu.jsp" class="btn">View Menu & Order</a>
    <a href="view_order.jsp" class="btn">View Orders</a>
    
</div>

<%@ include file="footer1.jsp" %>
</body>
</html>
