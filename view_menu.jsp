<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header1.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - View Menu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 30px;
        }
        h2 {
            text-align: center;
        }
        table {
            margin: auto;
            width: 80%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        .btn {
            padding: 6px 12px;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            border-radius: 4px;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-edit {
            background-color: #ffc107;
        }
        .top-buttons {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <h2>🍽️ Admin Panel - View Menu Items</h2>

    <div class="top-buttons">
        <a href="add_item.jsp" class="btn">➕ Add New Item</a>
        <a href="index0.jsp" class="btn btn-edit">🏠 Back to Home</a>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Dish Name</th>
            <th>Category</th>
            <th>Price (₹)</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>

<%
Connection con;
Statement stmt;
ResultSet rs;
try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM menu");
    while (rs.next()) {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String category = rs.getString("category");
        Double price = rs.getDouble("price");
        String description = rs.getString("description");
%>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= category %></td>
            <td><%= price %></td>
            <td><%= description %></td>
            <td>
                <a href="edit_item.jsp?id=<%=id%>" class="btn btn-edit">Edit</a>
                <a href="delete.jsp?id=<%=id%>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
            </td>
        </tr>
<%
    }
    con.close();
} catch(Exception e) {
    out.print("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
}
%>
    </table>
    <%@ include file="footer1.jsp" %>

</body>
</html>
