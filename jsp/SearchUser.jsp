<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Search Records</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon"  href="../images/LogoColor.png" />
    <link rel="stylesheet" href="../css/AdminDashboard.css">
    <link rel="stylesheet" href="../css/table.css">
    <link rel="stylesheet" href="../css/SearchUser.css">
    <link rel="stylesheet" href="../css/header.css">
    <script>
        function InsertUser() {
            window.location.href = "InsertUserForm.jsp";
        }
        function Logout() {
            window.location.href = "logout.jsp";
        }
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

        <center>
            <h2 class="whiteTextColor"> Search User </h2>
            <form method="post" action="SearchUser.jsp">
                <select name="search">
                    <option value="id">ID</option>
                    <option value="FullName">FullName</option>
                    <option value="UserName">Username</option>
                    <option value="email">Email</option>
                    <option value="password">Password</option>
                    <option value="phoneNo">Phone Number</option>
                </select>
                <input type="text" name="searchValue" placeholder="Search Here" required>
                <button type="submit">Search</button>
            </form>

            <table border="1">
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
                    String search,searchValue;
                    search = request.getParameter("search");
                    searchValue = request.getParameter("searchValue");

                    
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
                        PreparedStatement pst;

                        if(search == null || searchValue == null) {
                            pst = con.prepareStatement("SELECT * FROM user_info");
                        } else {
                            // Display records based on search parameters
                            pst = con.prepareStatement("SELECT * FROM user_info WHERE " + search + "=?");
                            pst.setString(1, searchValue);
                        }
                        ResultSet rs = pst.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String fname = rs.getString("FullName");
                            String name = rs.getString("UserName");
                            String email = rs.getString("Email");
                            String password = rs.getString("Password");
                            String phoneNo = rs.getString("PhoneNo");
                            String dob = rs.getString("DateOfBirth");
                            int money = rs.getInt("Money");

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
                    } 
                    
                    catch(Exception e) {
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
    </section>

</body>
</html>
