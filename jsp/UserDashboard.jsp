<%@ page import="java.sql.*, java.io.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%@ include file="UserRecord.jsp" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="shortcut icon"  href="../images/LogoColor.png" />
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/header.css">
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
        const options = document.querySelector('.options');
        const logoutBtn = document.getElementById('logout-btn');

        options.addEventListener('click', function() {
            logoutBtn.classList.toggle('hidden');
        });

        function Logout() {
            window.location.href = "logout.jsp";
        }
        });


    </script>
</head>
<body>

    <%
    int id2 = (int) session.getAttribute("id");
	Connection conn = null;
    PreparedStatement stmt = null;
	ResultSet rs = null;
	try {
		// establish database connection
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark", "root", "");

		// retrieve filename from database
		String fileName = "";
        String sql = "SELECT Image FROM user_info where id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id2);
        rs = stmt.executeQuery();
        if (rs.next()) {
            fileName = rs.getString("Image");
        }


		// close database connection
		if (rs != null) rs.close();
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
    <%
	} catch (Exception ex) {
		out.println(ex);
	}   
	%>
    

        <div class="row">
            <div class="col1">
                <h3> Total Deposit: </h3>
                <h3> Rs <% out.println(totalDeposit); %></h3>
                <img src="../images/deposit_logo_black.png" alt="Deposit money">
            </div>
            <div class="col2">
                <h3> Total Withdraw</h3>
                <h3> Rs <% out.println(totalWithdraw); %></h3>
                <img src="../images/withdraw_logo_black.png" alt="Withdraw money">
            </div>
            <div class="col3">
                <h3> Total Balance</h3>
                <h3> Rs <% out.println(totalMoney); %></h3>
                <img src="../images/total_balance.png" alt="Total money">
            </div>
        </div>
     </section>

     <center>
     <%
            String depositMessage = request.getParameter("depositMessage");
            String Message = request.getParameter("message");
            String WithdrawMessage = request.getParameter("WithdrawMessage");
            if (depositMessage != null) {
                out.print("<h2 style='color: green; font:Arial;'>" + depositMessage + "</h2>");
                response.setHeader("Refresh", "10; URL=UserDashboard.jsp");
            }
            if (WithdrawMessage != null) {
                out.print("<h2 style='color:red'>" + WithdrawMessage + "</h2>");
                response.setHeader("Refresh", "10; URL=UserDashboard.jsp");
            }
            if (Message != null) {
                out.print("<h2 style='color:#FA9500'>" + Message + "</h2>");
                response.setHeader("Refresh", "10; URL=UserDashboard.jsp");
            }

        %>
    </center>
        
</body>
</html>