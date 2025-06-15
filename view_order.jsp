<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header1.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Orders</title>
    <div class="top-buttons">
<a href="index0.jsp" class="btn btn-edit">🏠 Back to Home</a>
</div>
    <style>
        body {
            font-family: Arial;
            background-color: #f2f2f2;
            margin: 20px;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        h2 {
            text-align: center;
            color: #333;
        }
    </style>
</head>
<body>

<h2>📋 All Customer Orders</h2>

<table>
    <tr>
        <th>Order ID</th>
        <th>Customer Name</th>
        <th>Menu Item</th>
        <th>Category</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Total</th>
        <th>Order Time</th>
    </tr>
    

<%
Connection con;
Statement stmt;
ResultSet rs;

try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
    stmt = con.createStatement();
    
    String sql = "SELECT o.id AS order_id, o.customer_name, o.quantity, o.order_time, " +
                 "m.name AS menu_name, m.category, m.price " +
                 "FROM orders o JOIN menu m ON o.menu_id = m.id ORDER BY o.order_time DESC";
    
    rs = stmt.executeQuery(sql);
    
    while(rs.next()) {
        int orderId = rs.getInt("order_id");
        String customerName = rs.getString("customer_name");
        String menuName = rs.getString("menu_name");
        String category = rs.getString("category");
        int quantity = rs.getInt("quantity");
        double price = rs.getDouble("price");
        Timestamp orderTime = rs.getTimestamp("order_time");
        double total = quantity * price;
%>
    <tr>
        <td><%= orderId %></td>
        <td><%= customerName %></td>
        <td><%= menuName %></td>
        <td><%= category %></td>
        <td><%= quantity %></td>
        <td>₹<%= price %></td>
        <td>₹<%= total %></td>
        <td><%= orderTime %></td>
    </tr>
<%
    }
    con.close();
} catch(Exception e) {
    out.println("<tr><td colspan='8' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
}
%>

</table>

</body>
</html>

<%@ include file="footer1.jsp" %>
