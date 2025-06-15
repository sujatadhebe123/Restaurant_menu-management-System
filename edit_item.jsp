<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = "", category = "", description = "";
    double price = 0.0;

    Connection con=null;
    PreparedStatement pstmt;
    ResultSet rs;

    try {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
        String sql = "SELECT * FROM menu WHERE id = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            category = rs.getString("category");
            price = rs.getDouble("price");
            description = rs.getString("description");
        }
        rs.close();
    } catch (Exception e) {
        out.print("<p style='color:red;'>Error fetching data: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Menu Item</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fefefe;
            padding: 30px;
        }
        form {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px #aaa;
        }
        label {
            display: block;
            margin-top: 15px;
        }
        input, textarea, select {
            width: 100%;
            padding: 10px;
        }
        .btn {
            margin-top: 20px;
            background-color: #007BFF;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 5px;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">✏️ Edit Menu Item</h2>

<form method="post" action="">
    <label>Dish Name:</label>
    <input type="text" name="name" value="<%=name%>" required>

    <label>Category:</label>
    <select name="category" required>
        <option value="Starter" <%= category.equals("Starter") ? "selected" : "" %>>Starter</option>
        <option value="Main Course" <%= category.equals("Main Course") ? "selected" : "" %>>Main Course</option>
        <option value="Dessert" <%= category.equals("Dessert") ? "selected" : "" %>>Dessert</option>
        <option value="Drink" <%= category.equals("Drink") ? "selected" : "" %>>Drink</option>
    </select>

    <label>Price (₹):</label>
    <input type="number" step="0.01" name="price" value="<%=price%>" required>

    <label>Description:</label>
    <textarea name="description" rows="4" required><%=description%></textarea>

    <button type="submit" class="btn">Update Item</button>
</form>

<div class="back-link">
    <a href="view_menu.jsp">← Back to Menu</a>
</div>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String newName = request.getParameter("name");
        String newCategory = request.getParameter("category");
        double newPrice = Double.parseDouble(request.getParameter("price"));
        String newDescription = request.getParameter("description");

        try {
            String updateSql = "UPDATE menu SET name=?, category=?, price=?, description=? WHERE id=?";
            pstmt = con.prepareStatement(updateSql);
            pstmt.setString(1, newName);
            pstmt.setString(2, newCategory);
            pstmt.setDouble(3, newPrice);
            pstmt.setString(4, newDescription);
            pstmt.setInt(5, id);

            int updated = pstmt.executeUpdate();
            if (updated > 0) {
                out.print("<script>alert('✔️ Item updated successfully!'); location='view_menu.jsp';</script>");
            } else {
                out.print("<p style='color:red;'>❌ Failed to update item.</p>");
            }
            con.close();
        } catch (Exception e) {
            out.print("<p style='color:red;'>Error updating data: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
