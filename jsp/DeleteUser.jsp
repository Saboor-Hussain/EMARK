<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("DELETE FROM user_info WHERE id = ?");
        pst.setInt(1, id);
        pst.executeUpdate();
        response.sendRedirect("AdminDashboard.jsp");
    } 
    catch(Exception e) {
        out.println("<h3 style='color:red'>Error: "+e+"</h3>");
    }
%>
