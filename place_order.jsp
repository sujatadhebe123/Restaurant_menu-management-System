<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Placed</title>
    <div class="top-buttons">
<a href="index0.jsp" class="btn btn-edit">🏠 Back to Home</a>
</div>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            text-align: center;
            padding: 50px;
        }
        .message {
            padding: 20px;
            background: #e0ffe0;
            color: green;
            display: inline-block;
            border-radius: 8px;
            font-size: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<%
    String customer = request.getParameter("customer_name");
    int menuId = Integer.parseInt(request.getParameter("menu_id"));
    int qty = Integer.parseInt(request.getParameter("quantity"));

    Connection con;
    PreparedStatement ps;
    try {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
        String query = "INSERT INTO orders(menu_id, customer_name, quantity, order_time) VALUES (?, ?, ?, ?)";
        ps = con.prepareStatement(query);
        ps.setInt(1, menuId);
        ps.setString(2, customer);
        ps.setInt(3, qty);
        ps.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));

        int result = ps.executeUpdate();
        if(result > 0) {
            out.print("<div class='message'>✅ Order placed successfully!</div>");
        } else {
            out.print("<div class='message' style='color:red;'>❌ Failed to place order.</div>");
        }
        con.close();
    } catch(Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>

</body>
</html>

<%@ include file="footer.jsp" %>
