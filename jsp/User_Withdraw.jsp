<%@ page import="java.sql.*, java.io.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>


<%@ page import="java.sql.*" %>
<%@ include file="UserRecord.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Withdraw Money</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon"  href="../images/LogoColor.png" />
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/table.css">
    <link rel="stylesheet" href="../css/SearchUser.css">
    <link rel="stylesheet" href="../css/header.css">
    <script>
        function Logout() {
            window.location.href = "logout.jsp";
        }
    </script>
</head>
<body>

    
    <%
    int id2 = (int) session.getAttribute("id");
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
    <%
	} catch (Exception ex) {
		out.println(ex);
	}   
	%>
    

        <center>
            <h2 class="whiteTextColor" style="color: white;font-family: Arial, Helvetica, sans-serif;"> Withdraw Money </h2>
            <form action="../jsp/Withdraw.jsp" method="post">
                <input type="number" placeholder="Cash Withdrawal" name="withdraw">
                <button type="submit">submit</button>
            </form>
              
              <table border="1">
                <tr>
                  <th>TID</th>
                  <th>UserID</th>
                  <th>Name</th>
                  <th>Type</th>
                  <th>DateAndTime</th>
                  <th>Amount</th>
                </tr>
              
                <%
    String username1 = (String) session.getAttribute("username");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM transaction WHERE Name = ? And Type = 'Withdraw' ORDER BY DateAndTime DESC");
        pst.setString(1, username1);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            int tid = rs.getInt("TID");
            int userId = rs.getInt("User_id");
            String name2 = rs.getString("Name");
            String type = rs.getString("Type");
            String dateAndTime = rs.getString("DateAndTime");
            int amount = rs.getInt("Amount");

            out.println("<tr>");
            out.println("<td>" + tid + "</td>");
            out.println("<td>" + userId + "</td>");
            out.println("<td>" + name2 + "</td>");
            out.println("<td>" + type + "</td>");
            out.println("<td>" + dateAndTime + "</td>");
            out.println("<td>" + amount + "</td>");
            out.println("</tr>");
        }

    } catch (Exception e) {
        out.println("<h3 style='color:red'>Error: " + e + "</h3>");
    }
%>

              </table>
              
        </center>
    </section>

</body>
</html>
