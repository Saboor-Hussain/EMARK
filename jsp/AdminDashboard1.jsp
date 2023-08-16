<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Admin Dashboard</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <center>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Password</th>
                <th>Phone Number</th>
                <th>Money</th>
                <th>Delete User</th>
                <th>Edit User</th>
            </tr>

            <%
            int id, phoneNo,money,totalMoney = 0;
            String name,email,password;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
                PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info");
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    id = rs.getInt("id");
                    name = rs.getString("Name");
                    email = rs.getString("Email");
                    password = rs.getString("Password");
                    phoneNo = rs.getInt("PhoneNo");
                    money = rs.getInt("Money");

                    totalMoney += money;

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + password + "</td>");
                    out.println("<td>" + phoneNo + "</td>");
                    out.println("<td>" + money + "</td>");
                    
                    //delete button
                    out.println("<td>");
                    out.println("<form action='DeleteUser.jsp' method='post'>");
                    out.println("<input type='hidden' name='id' value='" + id + "'>");
                    out.println("<input type='submit' value='Delete'>");
                    out.println("</form>");
                    out.println("</td>");

                    //edit button
                    out.println("<td>");
                    out.println("<form action='EditUser.jsp' method='post'>");
                    out.println("<input type='hidden' name='id' value='" + id + "'>");
                    out.println("<input type='submit' value='Edit'>");
                    out.println("</form>");
                    out.println("</td>");
                    

                    out.println("</tr>");
                }        
            } catch(Exception e) {
                out.println("<h3 style='color:red'>Error: "+e+"</h3>");
            } 

            
        %>

        <tr>
            <form action="InsertUser.jsp" method="post">
                <td><input type="text" name="id"></td>
                <td><input type="text" name="name"></td>
                <td><input type="text" name="email"></td>
                <td><input type="text" name="password"></td>
                <td><input type="text" name="phoneNo"></td>
                <td><input type="text" name="money"></td>
                <td colspan="2"><button type="submit">Insert</button></td>
            </form>
        </tr>
    </table>
    <h2>Total Money in Accounts: <% out.println(totalMoney); %></h2>
</center>

</body>
</html>
