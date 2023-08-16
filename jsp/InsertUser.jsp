<%@ page import="java.sql.*" %>
<%
    String fName = request.getParameter("fname");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String pass = request.getParameter("password");
    String phoneNo = request.getParameter("phoneNo");
    String dob = request.getParameter("dob");
    String type = request.getParameter("type");

    if(fName==null || fName.isEmpty() || name==null || name.isEmpty() || email==null || email.isEmpty() || pass==null || pass.isEmpty() || dob.isEmpty() ) {
        response.sendRedirect("InsertUserForm.jsp?message=Fields Cannot be Empty");
    }
    else{
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
            
            PreparedStatement pst = con.prepareStatement("INSERT INTO user_info (FullName, UserName, Email, Password, PhoneNo , DateOfBirth ,Type) VALUES (?, ?, ?, ?, ? , ? , ?)");
            pst.setString(1, fName);
            pst.setString(2, name);
            pst.setString(3, email);
            pst.setString(4, pass);
            pst.setString(5, phoneNo);
            pst.setString(6, dob);
            pst.setString(7, type);
            
            pst.executeUpdate();
            con.close();
        } 
        
        catch(Exception e) {
            out.println("<h3 style='color:red'>Error: "+e+"</h3>");
        }
        response.sendRedirect("AdminDashboard.jsp");
    }
%>
