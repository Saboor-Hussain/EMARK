<%@page import = "java.sql.*,util.*" %>
<html>
<body>
<%
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        //out.println("<p style='color: Green;' >Database is Connected Successfully! </p>");
    }
    catch(Exception e)
    {
        out.println("<p style='color: red;' >MySQL Database Not Connected Error: "+e+"</p>");
    }
%>
</body>
</html>