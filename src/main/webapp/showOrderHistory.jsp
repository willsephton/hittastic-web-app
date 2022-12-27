<%-- 
    Document   : login
    Created on : 15 Dec 2022, 09:02:36
    Author     : thesu
--%>

<%@page import="com.mycompany.hittasticwebapp.User"%>
<%@page import="com.mycompany.hittasticwebapp.Order"%>
<%@page import="com.mycompany.hittasticwebapp.Song"%>
<%@page import="com.mycompany.hittasticwebapp.OrderDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="stylesheet.css"/>
        <title>showOrderHistory.jsp</title>
    </head>
    <body>
        <%
        Connection connection = null;
        try
        {
            // Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db");
        
             // Create the DAO
            OrderDao dao = new OrderDao(conn, "ordering");

            // Find all events by the user's chosen band
            ArrayList<Order> orders = dao.selectAllOrders();
            %>
            <div id="title2"><h1>Showing Orders History for <%out.println(session.getAttribute("username"));%>....</h1></div>
            <table class="border">
                <tr>
                    <th>UserID</th>
                    <th>Username</th>
                    <th>Song ID</th>
                    <th>Song Title</th>
                    <th>Song Artist</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
                
            <%
            // Display each event
            for(Order o: orders)
            {
            if( (int)session.getAttribute("userid") == o.getuserID()){
               %><tr><td><% out.println(o.getuserID());%></td><%
               %><td><% out.println(o.getUsername());%></td><%
               %><td><% out.println(o.getsongID());%></td><%
               %><td><% out.println(o.getTitle());%></td><%
               %><td><% out.println(o.getArtist());%></td><%
               %><td><% out.println(o.getorderSale());%></td><%
               %><td><% out.println("£"+String.format("%.2f", o.getTotalCost()));%></td><%
            }
            }
            %>
                
            </table>
        <%

        }
        catch(SQLException sqlException) // Catches any error allowing a custom error message to be created
        {
            out.println("Error: " + sqlException); // Error message
        }
        finally // Runs this code after the last two blocks
        {
            try
            {
                if(connection != null)
                {
                    connection.close(); // Closes the connection to the database to avoid it getting locked
                }
            }
            catch (SQLException closeException)
            {
                out.println("Close error: " + closeException);  // Closed error message
            }
        }

        // Return to the command list prompts

        if (session.getAttribute("userType").equals("Admin")){
        out.println("<a id=\"center\" href=\"commandListAdmin.jsp\">Return to the command list page</a>");
        }
        else if (session.getAttribute("userType").equals("User")){
        out.println("<a id=\"center\" href=\"commandListUser.jsp\">Return to the command list page</a>");
        }
        %>
    </body>
</html>
