<%@ page import="java.sql.*" %>
<%
    int id,money;
    String name,email,password , phoneNo , image;

    String username,pass;
    username = (String) session.getAttribute("username");
    pass = (String) session.getAttribute("password");

    session.setAttribute("username", username);
    session.setAttribute("password", pass);

    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info WHERE UserName = ? AND Password = ?");
        pst.setString(1,username);
        pst.setString(2,pass);

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            id = rs.getInt("id");
            name = rs.getString("UserName");
            email = rs.getString("Email");
            password = rs.getString("Password");
            phoneNo = rs.getString("PhoneNo");
            money = rs.getInt("Money");
            
            image = rs.getString("Image");


            session.setAttribute("id", id);
            session.setAttribute("name", name);            

            // out.println(name);
            // out.println(id);

            if (image == null || image.isEmpty()) {
                response.sendRedirect("../htmlFiles/UploadImage.html");
            } 
            else {
                response.sendRedirect("UserDashboard.jsp");
            }
            



        
        }
        else{   
            out.print(" <h2 style='color:red'> Record is not found </h2>");
            response.sendRedirect("SessionExpired.jsp");

        }
        

    }

    catch(Exception e)
    {
        out.println("<h3 style='color:red'> Error: "+e+"<h3>");
    } 


%>