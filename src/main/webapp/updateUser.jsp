<%-- 
    Document   : addSong
    Created on : 15 Dec 2022, 08:04:40
    Author     : thesu
--%>

<%@page import="com.mycompany.hittasticwebapp.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.hittasticwebapp.UserDao"%>
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
        <title>updateUser.jsp</title>
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
            UserDao dao = new UserDao(conn, "user");
            // Find all events by the user's chosen band
            ArrayList<User> users = dao.selectAllUsers();
            int id = Integer.valueOf(request.getParameter("id"));
            String username = request.getParameter("newUsername");
            String password = request.getParameter("newPassword");
            String usertype = request.getParameter("newUsertype");
            Double balance = Double.parseDouble(request.getParameter("newBalance"));
            int newID = Integer.valueOf(request.getParameter("newid"));

            for(User u: users)
            {
                if(id == u.getID()){
                   dao.updateUser(u, username, password, usertype, newID, balance);
                   out.println("<div id=\"title2\"><h1>User Updated</h1></div>");
                }
            }

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
