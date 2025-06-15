<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Menu Item</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #e8f0fe;
            padding: 30px;
        }
        h2 {
            text-align: center;
        }
        form {
            max-width: 500px;
            margin: auto;
            background: white;
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
            margin-top: 5px;
        }
        .btn {
            margin-top: 20px;
            background-color: #28a745;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #218838;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>➕ Add New Menu Item</h2>

<%
    if("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        Connection con;
        PreparedStatement pstmt;
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");
            String sql = "INSERT INTO menu(name, category, price, description) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, category);
            pstmt.setDouble(3, price);
            pstmt.setString(4, description);

            int i = pstmt.executeUpdate();
            if(i > 0){
                out.print("<p style='color:green; text-align:center;'>✔️ Item added successfully!</p>");
            } else {
                out.print("<p style='color:red; text-align:center;'>❌ Failed to add item.</p>");
            }
            con.close();
        } catch(Exception e) {
            out.print("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<form method="post" action="">
    <label>Dish Name:</label>
    <input type="text" name="name" required>

    <label>Category:</label>
    <select name="category" required>
        <option>Starter</option>
        <option>Main Course</option>
        <option>Dessert</option>
        <option>Drink</option>
        <option>Breakfast</option>
        <option>Beverage</option>
        
    </select>

    <label>Price (₹):</label>
    <input type="number" step="0.01" name="price" required>

    <label>Description:</label>
    <textarea name="description" rows="4" required></textarea>

    <button type="submit" class="btn">Add Item</button>
</form>

<div class="back-link">
    <a href="view_menu.jsp">← Back to Menu</a>
</div>

</body>
</html>
