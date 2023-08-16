
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Expired</title>
    <link rel="stylesheet" href="../css/development.css">

</head>
<body>
    <center>
    <nav>
        <div class="logo">
           <a href="../index.html"> <img src="../images/LogoColor.png" alt="Emark_logo"></a>
        </div>
    </nav>

    <section>
        <h2> Session Expired</h2>
    
        <%
        out.println("<meta http-equiv='refresh' content='5;URL=logout.jsp'>");
        
        %>
    
     </section>
    </center>
</body>
</html>