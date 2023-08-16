<%@page import = "java.sql.*,util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Random" %>

<%
    int id, deposit;
    String name = (String) session.getAttribute("name");
    if(name==null || name.isEmpty()){
        response.sendRedirect("SessionExpired.jsp");
    }
    else{


    id = (Integer) session.getAttribute("id");

    Random rand = new Random();
    int tid = (int) (rand.nextDouble() * 90000) + 10000;


    int userId = id;
    String type = "Deposit";
    String depositAmount = request.getParameter("deposit");


    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
    Date now = new Date();
    String dateAndTime = dateFormat.format(now);


    if (depositAmount == null || depositAmount.isEmpty()) 
    {
        String depositMessage = "Please enter a valid deposit amount";
        response.sendRedirect("UserDashboard.jsp?depositMessage=" + depositMessage);
    }
    else {
        deposit = Integer.parseInt(depositAmount);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emark", "root", "");

            PreparedStatement pst = con.prepareStatement("SELECT * FROM user_info WHERE id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                int dbmoney = rs.getInt("Money");
                int amount = dbmoney + deposit;

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
                ins_pst.setInt(6, deposit);
                int y = ins_pst.executeUpdate();

                
                response.sendRedirect("DepositReceipt.jsp?tid=" + tid + "&name=" + name + "&amount=" + depositAmount + "&type=" + type + "&dateAndTime=" + dateAndTime );
            } 
            
            else {
                out.print("<h2 style='color:red'>Record is not found</h2>");
            }
        } 
        
        catch (Exception e) {
            out.println("Error: " + e);
        }
    }
}

%>
