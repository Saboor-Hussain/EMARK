<%@ page import="java.sql.*" %>
<%@ include file="AdminRecord.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Admin Dashboard</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon"  href="../images/LogoColor.png" />
    <link rel="stylesheet" href="../css/AdminDashboard.css">
    <link rel="stylesheet" href="../css/table.css">
    <link rel="stylesheet" href="../css/header.css">
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
        const options = document.querySelector('.options');
        const logoutBtn = document.getElementById('logout-btn');

        options.addEventListener('click', function() {
            logoutBtn.classList.toggle('hidden');
        });
        function InsertUser() {
            window.location.href = "InsertUserForm.jsp";
        }
        function Logout() {
            window.location.href = "logout.jsp";
        }
        });


    </script>

</head>
<body>
    <nav>
        <div class="logo">
            <img src="../images/LogoColor.png" alt="Emark_logo">
        </div>
        <div class="icons">
            <a href="AdminDashboard.jsp"><img src="../images/dashboard_logo1.png" alt="Dashboard" title="Dashboard"></a>
            <a href="SearchUser.jsp"><img src="../images/search_user.png" alt="search_user" title="Search User"></a>
            <a href="SearchTransantion.jsp"><img src="../images/search_transaction.png" alt="search_transaction" title="Search Transaction"></a>
        </div>
    </nav>
    <section>


        <div class="header">
            <h2>Admin Dashboard</h2>
            <!-- <h3>Total money</h3> -->
            <div class="logout">
                <div class="profile-picture" id="profile-pic">
                    <img src="../images/Admin-Profile.png" alt="Profile Picture">
                    <div class="options">
                        <ul>
                            <li><a href="../jsp/logout.jsp">Log Out</a></li>
                        </ul>
                    </div>
                </div>
                <label><a>Administrator</a></label>
            </div>
            </div>
          </div>
          

        <div class="row">
            <div class="col3">
                <h3> Total Balance: </h3>
                <h3 style="color: black;"><b> Rs<% out.println(totalMoney); %> </b></h3>
                <img src="../images/total_balance.png" alt="deposit money">
            </div>
        </div>
        <center>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Phone Number</th>
                    <th>Date of Birth</th>
                    <th>Money</th>
                    <th>Delete User</th>
                    <th>Edit User</th>
                </tr>
    
                <%
                int id,money;
                String fname,name,email,password , phoneNo , dob;
    
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
                    PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info ORDER BY Money DESC LIMIT 3");
                    ResultSet rs = pst.executeQuery();
    
                    while (rs.next()) {
                        id = rs.getInt("id");
                        fname = rs.getString("FullName");
                        name = rs.getString("UserName");
                        email = rs.getString("Email");
                        password = rs.getString("Password");
                        phoneNo = rs.getString("PhoneNo");
                        dob = rs.getString("DateOfBirth");
                        money = rs.getInt("Money");
                        
                        
    
                        out.println("<tr>");
    
                        out.println("<td>" + id + "</td>");
                        out.println("<td>" + fname + "</td>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + email + "</td>");
                        out.println("<td>" + password + "</td>");
                        out.println("<td>" + phoneNo + "</td>");
                        out.println("<td>" + dob + "</td>");
                        out.println("<td>" + money + "</td>");
                        
                        //delete button
                        out.println("<td>");
                        out.println("<form action='DeleteUser.jsp' method='post'>");
                        out.println("<input type='hidden' name='id' value='" + id + "'>");
                        out.println("<input class='deleteButton' type='submit' value='' title='Delete User'>");
                        out.println("</form>");
                        out.println("</td>");
    
                        //edit button
                        out.println("<td>");
                        out.println("<form action='EditUser.jsp' method='post'>");
                        out.println("<input type='hidden' name='id' value='" + id + "'>");
                        out.println("<input class='editButton' type='submit' value='' title='Edit User'> ");
                        out.println("</form>");
                        out.println("</td>");
                        
    
                        out.println("</tr>");
                    }        
                } catch(Exception e) {
                    out.println("<h3 style='color:red'>Error: "+e+"</h3>");
                } 
    
                
            %>
    
            <tr>
                <td colspan="10">
                    <button class="insertButton" onclick="InsertUser()">Insert User</button>
                </td>
            </tr>
        </table>
    </center>

    <div class="row">
        <div class="col1">
            <h3> Total Deposit: </h3>
            <h3 style="color: black;"> Rs<% out.println(totalDeposit); %></h3>
            <img src="../images/deposit_logo_black.png" alt="deposit money">
        </div>
        <div class="col2">
            <h3> Total Withdraw: </h3>
            <h3 style="color: black;"> Rs<% out.println(totalWithdraw); %> </h3>
            <img src="../images/withdraw_logo_black.png" alt="deposit money">
        </div>
    </div>

        
    
     </section>

</body>
</html>
