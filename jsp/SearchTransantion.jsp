<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Search Transaction</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon"  href="../images/LogoColor.png" />
    <link rel="stylesheet" href="../css/AdminDashboard.css">
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
            <h2 class="whiteTextColor"> Search Transaction </h2>
            <form method="post" action="SearchTransantion.jsp">
                <select name="search">
                  <option value="TID">TID</option>
                  <option value="User_id">UserID</option>
                  <option value="Name">Name</option>
                  <option value="Type">Type</option>
                  <option value="DateAndTime">DateAndTime</option>
                  <option value="Amount">Amount</option>
                </select>
                <input type="text" name="searchValue" placeholder="Search Here" required>
                <button type="submit">Search</button>
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
                  String search,searchValue;
                  search = request.getParameter("search");
                  searchValue = request.getParameter("searchValue");
              
                  try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
                    PreparedStatement pst;
                    
                    if (search != null && searchValue != null) {
                      pst = con.prepareStatement("SELECT * FROM transaction WHERE " + search + "=?");
                      pst.setString(1, searchValue);
                    } else {
                      pst = con.prepareStatement("SELECT * FROM transaction ORDER BY DateAndTime DESC");
                    }
              
                    ResultSet rs = pst.executeQuery();
              
                    while (rs.next()) {
                      int tid = rs.getInt("TID");
                      int userId = rs.getInt("User_id");
                      String name = rs.getString("Name");
                      String type = rs.getString("Type");
                      String dateAndTime = rs.getString("DateAndTime");
                      int amount = rs.getInt("Amount");
              
                      out.println("<tr>");
                      out.println("<td>" + tid + "</td>");
                      out.println("<td>" + userId + "</td>");
                      out.println("<td>" + name + "</td>");
                      out.println("<td>" + type + "</td>");
                      out.println("<td>" + dateAndTime + "</td>");
                      out.println("<td>" + amount + "</td>");
                      out.println("</tr>");
                    }        
                  } 
              
                  catch(Exception e) {
                    out.println("<h3 style='color:red'>Error: "+e+"</h3>");
                  } 
                %>
              </table>
              
        </center>
    </section>

</body>
</html>
