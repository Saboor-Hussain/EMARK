<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
<%
    String username = request.getParameter("username");
    String pass = request.getParameter("password");
    
    String type = null; // Initialize type to null
    
    session.setAttribute("username", username);
    session.setAttribute("password", pass);
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info WHERE UserName = ? AND Password = ?");
        pst.setString(1,username);
        pst.setString(2,pass);

        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            type = rs.getString("Type");

            if(type.equals("Admin")) {
                // Redirect to AdminDashboard.jsp
                response.sendRedirect("AdminDashboard.jsp");
            } else {
                // Redirect to UserDashboard.jsp
                response.sendRedirect("DataRetrieve.jsp");
            }
        } else {
            type = "Invalid";
        }

        con.close();
    } catch(Exception e) {
        out.println("<h3 style='color:red'>Error: "+e+"</h3>");
    }
%>
    
<script type="text/javascript">
    var type = '<%= type %>'
    window.location.href = '../htmlFiles/login.html?type=' + type;
</script>
</body>
</html>
