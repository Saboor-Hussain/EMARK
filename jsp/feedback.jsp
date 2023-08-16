<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String comment = request.getParameter("comment");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        
        PreparedStatement pst = con.prepareStatement("INSERT INTO feedback (Name, Email, Comments) VALUES (?, ?, ?)");
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, comment);
        
        pst.executeUpdate();
        con.close();
    } 
    
    catch(Exception e) {
        out.println("<h3 style='color:red'>Error: "+e+"</h3>");
    }
    response.sendRedirect("../index.html");
%>
