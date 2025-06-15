<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String idStr = request.getParameter("id");
    if (idStr != null && !idStr.isEmpty()) {
        int id = Integer.parseInt(idStr);
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/pune", "postgres", "12345");

            String sql = "DELETE FROM menu WHERE id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, id);
            int result = pstmt.executeUpdate();

            if (result > 0) {
                out.print("<script>alert('✔️ Item deleted successfully!'); location='view_menu.jsp';</script>");
            } else {
                out.print("<script>alert('❌ Item not found or could not be deleted.'); location='view_menu.jsp';</script>");
            }
        } catch (Exception e) {
            out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                out.print("<p style='color:red;'>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
    } else {
        out.print("<script>alert('⚠️ Invalid ID provided!'); location='view_menu.jsp';</script>");
    }
%>
