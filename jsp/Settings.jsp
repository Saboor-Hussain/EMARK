<%@ page import="java.sql.*, java.io.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%@ page import="java.sql.*" %>
<%@ include file="UserRecord.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Settings</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon"  href="../images/LogoColor.png" />
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/settings.css">
    <link rel="stylesheet" href="../css/header.css">
    

</head>
<body>
    <%
    int id2 = (int) session.getAttribute("id");
    String fname, name, email , password, phoneNo ,dob;
    int  money;
    
    

    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info WHERE id = ?");
        pst.setInt(1, id2);
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

    
    <%
	Connection conn = null;
    PreparedStatement stmt = null;
	ResultSet rs1 = null;
	try {
		// establish database connection
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark", "root", "");

		// retrieve filename from database
		String fileName = "";
        String sql = "SELECT Image FROM user_info where id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id2);
        rs1 = stmt.executeQuery();
        if (rs1.next()) {
            fileName = rs1.getString("Image");
        }


		// close database connection
		if (rs1 != null) rs1.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();

		// display the image
	%>
    <nav class="nav">
        <div class="logo">
            <img src="../images/LogoColor.png" alt="Emark_logo">
        </div>
        <div class="icons">
            <a href="UserDashboard.jsp"><img src="../images/dashboard_logo2.png" alt="Dashboard" title="Dashboard"></a>
            <a href="User_deposit.jsp"><img src="../images/deposit_logo1.png" alt="Deposit" title="Deposit Cash"></a>
            <a href="User_Withdraw.jsp"><img src="../images/withdraw_logo2.png" alt="Withdraw" title="Withdraw Cash"></a>
            <a href="Settings.jsp"><img src="../images/settings_logo.png" alt="Settings" title="Settings"></a>
        </div>
    </nav>

    <section>

        <div class="header">
            <h2>Dashboard</h2>
            <h3>Total money: <% out.println(totalMoney); %></h3>
            <div class="logout">
                <div class="profile-picture" id="profile-pic">
                    <img src="../UserImages/<%=fileName%>" alt="Profile Picture">
                    <div class="options">
                        <ul>
                            <li><a href="../jsp/logout.jsp">Log Out</a></li>
                        </ul>
                    </div>
                </div>
                <label><a><% out.println(name1); %></a></label>
            </div>
            </div>
          </div>
        </section>

        <center>
    
            <h2 style="color: white; font-family: Arial, Helvetica, sans-serif; font-size: 35px;">Settings</h2>
            <div class="settings">
        
                <div class="sidebar">
                    <div class="sidebar-head">
                        <img src="../UserImages/<%=fileName%>">
                        <br>
                        <h4><%=fname%></h4>
                        <br>
                    </div>
                    <div class="sidebar-body">
                        <label for="Personal-info">Personal-Info</label>
                        <br>
                        <!-- <label for="Password">Password</label> -->
                    </div>
                </div>

                
    <%
	} catch (Exception ex) {
		out.println(ex);
	}   
	%>
    
   
    
        <div class="section">
            <form action="UpdateUser_UserDB.jsp" method="post">
            <input type="hidden" name="id" value="<%=id2%>">
            <label for="Fullname">FullName:</label>
            <input type="text" name="fullName" value="<%=fname%>">
            <label for="Username">UserName:</label>
            <input type="text" name="userName" value="<%=name%>">
            <label for="email">Email:</label>
            <input type="email" name="email" value="<%=email%>">
            <label for="password">Password:</label>
            <input type="text" name="password" value="<%=password%>">
            <label for="phoneNo">Phone Number:</label>
            <input type="tel" name="phoneNo" value="<%=phoneNo%>">
            <label for="DOB">Date Of Birth:</label>
            <input type="date" name="DOB" value="<%=dob%>"><br><br>
            <input type="hidden" name="money" value="<%=money%>" hidden><br>
            <input type="submit" value="Save"><br><br>
            <a href="UserDashboard.jsp"> Back </a>
        </form>
        </div>
    </div>

     
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
