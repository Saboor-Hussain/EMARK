<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%
    int totalDeposit = 0;
    int totalWithdraw = 0;
    int totalMoney = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");
        PreparedStatement moneyPs = con.prepareStatement("SELECT Money FROM user_info");
        PreparedStatement ps = con.prepareStatement("SELECT Amount FROM transaction WHERE Type = 'Withdraw'");
        PreparedStatement pst = con.prepareStatement("SELECT Amount FROM transaction WHERE Type = 'Deposit'");
        
        ResultSet moneyRs = moneyPs.executeQuery();   // totalMoney
        ResultSet rs = ps.executeQuery();   // totalWithdraw
        ResultSet rst = pst.executeQuery();  // totalDeposit
    
        while (moneyRs.next()) {
            totalMoney += moneyRs.getInt("Money");
        } 

        while (rs.next()) {
            totalWithdraw += rs.getInt("Amount");
        } 

        while (rst.next()) {
            totalDeposit += rst.getInt("Amount");    
        }

    } catch(Exception e) {
        out.println("<h3 style='color:red'>Error: "+e+"</h3>");
    }
    
    
%>