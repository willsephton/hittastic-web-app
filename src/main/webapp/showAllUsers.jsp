<%-- 
    Document   : login
    Created on : 15 Dec 2022, 09:02:36
    Author     : thesu
--%>

<%@page import="com.mycompany.hittasticwebapp.User"%>
<%@page import="com.mycompany.hittasticwebapp.UserDao"%>
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
        <title>showAllUsers.jsp</title>
    </head>
    <body>
        <div id="title2"><h1>Showing All Users....</h1></div>
        <%
        Connection connection = null;
        try
        {
            // Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db");
        
             // Create the DAO
            UserDao dao = new UserDao(conn, "user");

            // Find all events by the user's chosen band
            ArrayList<User> users = dao.selectAllUsers();

            %>
            <table class="border">
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Usertype</th>
                    <th>ID</th>
                    <th>Balance</th>
                </tr>
                
            <%
            // Display each event
            for(User u: users)
            {
               %><tr><td><% out.println(u.getUName());%></td><%
               %><td><% out.println(u.getPWord());%></td><%
               %><td><% out.println(u.getAdminStatus());%></td><%
               %><td><% out.println(u.getID());%></td><%
               %><td><% out.println("£"+String.format("%.2f", u.getBalance()));%></td><%
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
