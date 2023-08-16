<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/form.css">
</head>
<body>
    <center>
    <img src="../images/LogoColor.png" alt="Emark_logo">
    <h2>Edit User</h2>
    
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String fname, name, email , password, phoneNo ,dob;
        int  money;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
            PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info WHERE id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                fname = rs.getString("FullName");
                name = rs.getString("UserName");
                email = rs.getString("Email");
                password = rs.getString("Password");
                phoneNo = rs.getString("PhoneNo");
                money = rs.getInt("Money");
                dob = rs.getString("DateOfBirth");
            }
            else {
                out.println("User ID not found");
                return;
            }

    %>
    <form action="UpdateUser.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <label for="Fullname">FullName:</label>
        <input type="text" name="fullName" value="<%=fname%>"><br>
        <label for="Username">UserName:</label>
        <input type="text" name="userName" value="<%=name%>"><br>
        <label for="email">Email:</label>
        <input type="email" name="email" value="<%=email%>"><br>
        <label for="password">Password:</label>
        <input type="text" name="password" value="<%=password%>"><br>
        <label for="phoneNo">Phone Number:</label>
        <input type="tel" name="phoneNo" value="<%=phoneNo%>"><br>
        <label for="DOB">Date Of Birth:</label>
        <input type="date" name="DOB" value="<%=dob%>"><br>
        <!-- <label for="money">Money:</label> -->
        <input type="hidden" name="money" value="<%=money%>" hidden><br>
        <input type="submit" value="Save">
        <a href="AdminDashboard.jsp"> Back </a>
    </form>
    
    <%
        }

        catch(Exception e)
        {
            out.println("<h3 style='color:red'> Error: "+e+"</h3>");
        } 
    %>
    </center>
</body>
</html>
