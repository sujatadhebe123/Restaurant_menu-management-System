<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header1.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 40px;
            text-align: center;
        }
        .order-box {
            background: #fff;
            padding: 25px;
            margin: auto;
            width: 400px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            border-radius: 10px;
        }
        input, select {
            margin: 10px;
            padding: 10px;
            width: 80%;
        }
        .btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="order-box">
    <h2>🛒 Confirm Your Order</h2>

<%
    int menuId = Integer.parseInt(request.getParameter("id"));
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    try {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
        ps = con.prepareStatement("SELECT * FROM menu WHERE id=?");
        ps.setInt(1, menuId);
        rs = ps.executeQuery();
        if (rs.next()) {
%>
    <form action="place_order.jsp" method="post">
        <input type="hidden" name="menu_id" value="<%= menuId %>">
        <p><strong>Item:</strong> <%= rs.getString("name") %></p>
        <p><strong>Price:</strong> ₹<%= rs.getDouble("price") %></p>
        <input type="text" name="customer_name" placeholder="Your Name" required><br>
        <input type="number" name="quantity" placeholder="Quantity" min="1" required><br>
        <input type="submit" class="btn" value="Place Order">
    </form>
<%
        }
        con.close();
    } catch(Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
</div>

</body>
</html>

<%@ include file="footer1.jsp" %>
