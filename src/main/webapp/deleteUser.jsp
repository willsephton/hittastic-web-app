<%-- 
    Document   : addSong
    Created on : 15 Dec 2022, 08:04:40
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

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
        <link rel="stylesheet" href="stylesheet.css"/> <!-- Link to stylesheet -->
        <title>deleteUser.jsp</title> <!-- Title of the webpage -->
    </head>
    <body>
        <%
        Connection connection = null; // Create the connection object
        try // Run this code before the other block
        {
            // Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db");
        
             // Create the DAO
            UserDao dao = new UserDao(conn, "user");

            ArrayList<User> users = dao.selectAllUsers(); // Place all the users from the user database into an Arraylist
            int id = Integer.valueOf(request.getParameter("id")); // Get the user inputted value "id" and turning it into an integer
            for(User u: users) // For every user in the arraylist users
            {
                if(id == u.getID()){ // If the user entered id matches the current user in the loops id then...
                   dao.deleteUser(u); // Delete the current user
                   out.println("<div id=\"title2\"><h1>User Deleted</h1></div>"); // Prompts the user the selected user has been deleted
                }
            }

        }
        catch(SQLException sqlException) // Catches any error allowing a custom error message to be created
        {
            out.println("Error: " + sqlException); // Error message
        }
        finally
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
                out.println("Close error: " + closeException); // Closed error message
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
