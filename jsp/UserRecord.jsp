<%@ page import="java.sql.*" %>
<%
    int totalDeposit = 0;
    int totalWithdraw = 0;
    int totalMoney = 0;

    int id1 = (session.getAttribute("id") != null) ? (int) session.getAttribute("id") : -1;
    if (id1 == -1) {
        response.sendRedirect("SessionExpired.jsp");
    }
    

    String name1 = (String) session.getAttribute("name");

    out.println(name1);
    out.println(id1);
    
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark","root","");

        PreparedStatement moneyPs = con.prepareStatement("SELECT Money FROM user_info WHERE id = ?");
        moneyPs.setInt(1,id1);
        PreparedStatement ps = con.prepareStatement("SELECT Amount FROM transaction WHERE user_id = ? AND Type = 'Withdraw'");
        ps.setInt(1,id1);
        PreparedStatement pst = con.prepareStatement("SELECT Amount FROM transaction WHERE user_id = ? AND  Type = 'Deposit'");
        pst.setInt(1,id1);
        
        ResultSet moneyRs = moneyPs.executeQuery();   // totalMoney
        ResultSet rs = ps.executeQuery();   
        ResultSet rst = pst.executeQuery();
        
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