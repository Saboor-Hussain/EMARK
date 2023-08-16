<%@ page import="java.sql.*" %>
<%
    String fName , name , email , pass, phoneNo , dob ,type;


    fName = request.getParameter("fName");
    name = request.getParameter("name");
    email = request.getParameter("email");
    pass = request.getParameter("password");
    phoneNo = request.getParameter("phoneNo");
    dob = request.getParameter("dob");
    type = request.getParameter("type");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("INSERT INTO user_info (FullName, UserName, Email, Password, PhoneNo , DateOfBirth ,Type ,Money) VALUES (?, ?, ?, ?, ? , ? , ? ,?)");
        pst.setString(1, fName);
        pst.setString(2, name);
        pst.setString(3, email);
        pst.setString(4, pass);
        pst.setString(5, phoneNo);
        pst.setString(6, dob);
        pst.setString(7, type);
        pst.setInt(8, 0);
        
        pst.executeUpdate();
        con.close();
        response.sendRedirect("../htmlFiles/login.html");
    } 

    catch(Exception e) {
        out.println("<h3 style='color:red'>Error: "+e+"</h3>");
    }

%>