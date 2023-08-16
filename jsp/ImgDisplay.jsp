<%@ page import="java.sql.*, java.io.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
	<title>Display Image</title>
</head>
<body>
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		// establish database connection
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark", "root", "");

		// retrieve filename from database
		String fileName = "";
		stmt = conn.createStatement();
		String sql = "SELECT Image FROM user_info where id = 1";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			fileName = rs.getString("Image");
		}

		// close database connection
		if (rs != null) rs.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();

		// display the image
	%>
		<!-- Assume `fileName` is retrieved from the database and contains the image name -->
		<img src="../userimages/<%=fileName%>" alt="profile_pic" width="80px" height="80px" style="border-radius: 70px; float: right;">
	<%
	} catch (Exception ex) {
		out.println(ex);
	}   
	%>
</body>
</html>
