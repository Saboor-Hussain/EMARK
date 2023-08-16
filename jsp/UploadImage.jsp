<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="UserRecord.jsp" %>

<%
   int id2 = (int) session.getAttribute("id");
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String filePath = "c:/xampp/tomcat/webapps/emark.com/UserImages/";

   String contentType = request.getContentType();
  // out.print(contentType);
 
   if ( (contentType.indexOf("multipart/form-data") >= 0)) 
	{

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("c:\\temp"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
	     //out.print("<h2>"+fileItems+"</h2>");
         Iterator i = fileItems.iterator();

         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            
            if ( !fi.isFormField () )  
            {
                String fieldName = fi.getFieldName();
                String fileName = fi.getName();
                //out.print("<h1>"+fieldName+fileName+"</h1>");
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                file = new File( filePath + fileName);
                fi.write( file );
               // out.println("Uploaded Filename: " + filePath + fileName + "<br>");
                


                // Save the filename as a string in the database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
                PreparedStatement ps = conn.prepareStatement("UPDATE user_info SET Image=? where id = ?");
                ps.setString(1, fileName);
                ps.setInt(2, id2);

                ps.executeUpdate();
                ps.close();
                response.sendRedirect("UserDashboard.jsp");
            }
         }

        
      }catch(Exception ex) {
         out.println(ex);
      }
   }
	else{
     
      out.println("<h2>No file uploaded</h2>"); 
     
   }
	
%>