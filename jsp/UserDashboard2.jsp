<%@ include file="DataRetrieve.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <script>
        function Logout() {
            window.location.href = "logout.jsp";
        }
    </script>
</head>
<body>
    
    <center>
        <h1>User Dashboard</h1>
        <form action="../jsp/Deposit.jsp" method="post">
            <input type="number" placeholder="Cash Deposit" name="deposit">
            <button type="submit">submit</button>
        </form>
        <br>
        <form action="../jsp/Withdraw.jsp" method="post">
            <input type="number" placeholder="Cash Withdrawal" name="withdraw">
            <button type="submit">submit</button>
        </form>
        <br>
        <br>
        <br>
        <button onclick="Logout()">Log Out</button>
        <%
            String depositMessage = request.getParameter("depositMessage");
            String WithdrawMessage = request.getParameter("WithdrawMessage");
            if (depositMessage != null) {
                out.print("<h2 style='color:green'>" + depositMessage + "</h2>");
                response.setHeader("Refresh", "5; URL=UserDashboard.jsp");
            }
            if (WithdrawMessage != null) {
                out.print("<h2 style='color:red'>" + WithdrawMessage + "</h2>");
                response.setHeader("Refresh", "5; URL=UserDashboard.jsp");
            }
        %>
        
        
    </center>
</body>
</html>

