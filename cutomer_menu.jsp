<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header1.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu - Aabyay's Restaurant</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('background1.jpg');
            background-size: cover;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .menu-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            display: inline-block;
            margin: 20px;
            padding: 20px;
            width: 250px;
            box-shadow: 0px 0px 10px gray;
        }
        .menu-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .menu-price {
            color: green;
            font-size: 18px;
        }
        .order-btn {
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .order-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2>🍽️ Our Delicious Menu</h2>

<%
    Connection con;
    Statement stmt;
    ResultSet rs;
    try {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM menu");

        while(rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String category = rs.getString("category");
            double price = rs.getDouble("price");
            String desc = rs.getString("description");
%>
    <div class="menu-card">
        <div class="menu-title"><%= name %></div>
        <div><em><%= category %></em></div>
        <div class="menu-price">₹<%= price %></div>
        <p><%= desc %></p>
        <form action="order_item.jsp" method="get">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="submit" value="Order Now" class="order-btn">
        </form>
    </div>
<%
        }
        con.close();
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>

</body>
</html>

<%@ include file="footer1.jsp" %>
