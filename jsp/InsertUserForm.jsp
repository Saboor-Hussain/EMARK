<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert User</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/form.css">
</head>
<body>
    <center>
        <img src="../images/LogoColor.png" alt="Emark_logo">
        <h2>Add New User</h2>
        <%
            String message = request.getParameter("message");
            if(message!=null){
                out.println("<h3>"+message+"</h3>");
            }
        %>
        <form action="InsertUser.jsp" method="post">
            <!-- <label>ID:</label>
            <input type="text" name="id" placeholder="Enter ID"><br><br> -->
            <label>FullName:</label>
            <input type="text" name="fname" placeholder="Enter Your Name" required><br><br>
            <label>Username:</label>
            <input type="text" name="name" placeholder="Enter Username" required><br><br>
            <label>Email:</label>
            <input type="email" name="email" placeholder="Enter Email" required><br><br>
            <label>Password:</label>
            <input type="password" name="password" pattern="[0-9a-zA-Z]{8,25}" placeholder="Enter a strong password" required><br><br>
            <label>Phone Number:</label>
            <input type="tel" name="phoneNo" placeholder="Enter Phone Number" pattern="[+]?[0-9]{11,13}" title="Phone number must be between 11-13 digits, You can also Use '+'" required><br><br>
            <label>Date Of Birth:</label>
            <input type="date" name="dob" title="ENTER YOUR Date of Birth" required ><br><br>
            <input type="hidden" name="type" value="User" required>
            <input type="submit" value="Add User">
            <a href="AdminDashboard.jsp"> Back </a>
        </form>

        
    </center>
</body>
</html>
