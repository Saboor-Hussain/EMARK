<%@ page import="java.util.*,java.text.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Receipt</title>
	<style>
		body{
			background-image: url(../images/bgg50.jpg);
			background-repeat: repeat;
		}
		section {
			margin: auto;
			margin-top: 6%;
			padding: 20px;
			width: 50%;
			box-shadow: 0px 0px 20px 2px rgba(0,0,0,0.75);
			border: 2px solid #FA9500;
			border-radius: 10px;
			background-color: #003939;
		}
		h1, h2 {
			font-family: Arial, sans-serif;
			text-align: center;
			margin: 10px 0px;
			color: white;
		}
		img{
			width: 15%;
			/* height: 100px; */
			text-align: center;
			margin: 10px 0px;
			justify-content: center;
			align-items: center;
		}
		p {
			font-size: 18px;
			font-family: Arial, sans-serif;
			line-height: 1.5;
			margin: 10px 0px;
			color: white;
		}
		hr {
			margin: 20px 0px;
			border: 0;
			border-top: 1px solid #ccc;
		}
	</style>
</head>
<body>
	<section>
		<!-- <h1>EMARK</h1> -->
		<center>
		<img src="../images/LogoColor.png" alt="emark">
		</center>
		<h2>Transaction Receipt</h2>
		<hr>

		<%
			String name = request.getParameter("name");

			int amount = Integer.parseInt(request.getParameter("amount")); 
			String type = request.getParameter("type");
			
			String dateTime = request.getParameter("dateAndTime");
			
			
			int tid = Integer.parseInt(request.getParameter("tid"));



			String message = "Dear " + name + ",<br><br>";
			message += "We are pleased to inform you that a " + type.toLowerCase() + " of Rs" + amount + " has been made from your account with EMARK on " + dateTime + ".<br>";
			message += "Thank you for choosing EMARK as your banking partner.<br><br>";
			message += "Sincerely,<br>Team EMARK.";


			String WithdrawMessage = "Transaction successful";
			out.println("<meta http-equiv='refresh' content='12;URL=UserDashboard.jsp?WithdrawMessage=" + WithdrawMessage + "'>");

		%>
		
		<p><%= message %></p>
		
		<hr>
		<p>Receipt Number: <%= tid %></p>
	</section>
</body>
</html>
