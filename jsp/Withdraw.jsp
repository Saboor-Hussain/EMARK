<%@page import = "java.sql.*,util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Random" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdraw Money</title>
</head>
<body>
    <%
    String name = (String) session.getAttribute("name");

    if(name==null || name.isEmpty()){
        response.sendRedirect("SessionExpired.jsp");
    }
    else{


    int id, Withdraw;

    id = (Integer) session.getAttribute("id");

    
    Random rand = new Random();
    int tid = (int) (rand.nextDouble() * 90000) + 10000;
    
    
    int userId = id;
    String type = "Withdraw";
    String withdrawAmount = request.getParameter("withdraw");
    


    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
    Date now = new Date();
    String dateAndTime = dateFormat.format(now);

    if (withdrawAmount == null || withdrawAmount.isEmpty()) {
        String WithdrawMessage = "Please enter a valid Withdraw amount";
        response.sendRedirect("UserDashboard.jsp?WithdrawMessage=" + WithdrawMessage);
    } else {
        Withdraw = Integer.parseInt(withdrawAmount);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark", "root", "");

            PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info WHERE id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                int dbmoney = rs.getInt("Money");
                if (Withdraw > dbmoney) {
                    String WithdrawMessage = "Withdraw amount exceeds available balance";
                    response.sendRedirect("UserDashboard.jsp?WithdrawMessage=" + WithdrawMessage);
                } else {
                    int amount = dbmoney - Withdraw;

                    PreparedStatement ps = con.prepareStatement("UPDATE user_info SET Money = ? WHERE id = ?");
                    ps.setInt(1, amount);
                    ps.setInt(2, id);

                    int x = ps.executeUpdate();


                    PreparedStatement ins_pst = con.prepareStatement("INSERT INTO transaction (TID, User_id, Name, Type,DateAndTime, Amount) VALUES (?, ?, ?, ?, ? , ?)");
                    ins_pst.setInt(1, tid); 
                    ins_pst.setInt(2, userId);
                    ins_pst.setString(3, name);
                    ins_pst.setString(4, type);
                    ins_pst.setString(5, dateAndTime);
                    ins_pst.setInt(6, Withdraw);


                    int y = ins_pst.executeUpdate();


                    String WithdrawMessage = "Transaction successful";
                    response.sendRedirect("WithdrawReceipt.jsp?tid=" + tid + "&name=" + name + "&amount=" + withdrawAmount + "&type=" + type + "&dateAndTime=" + dateAndTime );
                    response.sendRedirect("UserDashboard.jsp?WithdrawMessage=" + WithdrawMessage);
                }
            } else {
                out.print("<h2 style='color:red'>Record is not found</h2>");
            }
        } 
        
        catch (Exception e) {
            out.println("Error: " + e);
        }
    }
}

%>

    
</body>
</html>
