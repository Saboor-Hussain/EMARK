<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String fname = request.getParameter("fullName");
    String name = request.getParameter("userName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phoneNo = request.getParameter("phoneNo");
    String dob = request.getParameter("DOB");
    int money = Integer.parseInt(request.getParameter("money"));

    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("UPDATE user_info SET FullName=? , UserName=?, Email=?, Password=?, PhoneNo=?, DateOfBirth= ?, Money=? WHERE id=?");
        pst.setString(1, fname);
        pst.setString(2, name);
        pst.setString(3, email);
        pst.setString(4, password);
        pst.setString(5, phoneNo);
        pst.setString(6, dob);
        pst.setInt(7, money);

        pst.setInt(8, id);
        int x = pst.executeUpdate();

        if(x > 0){
            response.sendRedirect("UserDashboard.jsp?message=User updated successfully");
        } 
        else {
            response.sendRedirect("UserDashboard.jsp?message=Failed to update user");
        }

    } 
    catch(Exception e) {
        out.println("<h3 style='color:red'>Error: " + e + "</h3>");
    } 
%>
