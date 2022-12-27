<%-- 
    Document   : login
    Created on : 15 Dec 2022, 09:02:36
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

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
        <link rel="stylesheet" href="stylesheet.css"/> <!-- Link to stylesheet -->
        <title>login.jsp</title> <!-- Defines the title of the webpage -->
    </head>
    <body>
        <h1>Logging In....</h1> <!-- Tells the user what is happening -->
        <%
        Connection connection = null; // Creates the connection object.
        try // Runs this block of code first but doesn't crash the webpage if it can't
        {
            // Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db"); // Define the database file
        
             // Create the DAO
            UserDao dao = new UserDao(conn, "user");

            ArrayList<User> users = dao.selectAllUsers(); // Fills a local ArrayList with all of the Users from the User table.

           
            for(User u: users) // Loops through all users
            {
            if(request.getParameter("username").equals(u.getUName()) && (request.getParameter("password").equals(u.getPWord()))){ // If the inputted username and password are the same as the current users credentials then run this code
                User loggedUser = u; // Creates a user object for the current user
                session.setAttribute("loggedUser", loggedUser); // Sets each element of the user object as a session attribute for use throughout the web app
                session.setAttribute("username", loggedUser.getUName());
                session.setAttribute("password", loggedUser.getPWord());
                session.setAttribute("userid", loggedUser.getID());
                session.setAttribute("balance", loggedUser.getBalance());
                session.setAttribute("userType", loggedUser.getAdminStatus());
                if (loggedUser.getAdminStatus().equals("Admin")){ // Checks the users usertype and sends them to the appropriate control panel
                out.println("Logged in as admin");
                String redirectURL = "commandListAdmin.jsp";
                response.sendRedirect(redirectURL);
                }
                else if (loggedUser.getAdminStatus().equals("User")){
                out.println("Logged in as User");
                String redirectURL = "commandListUser.jsp";
                response.sendRedirect(redirectURL);
                }
                else{ // If something goes wrong it sends the user back to the login screen
                out.println("Something went wrong");
                String redirectURL = "index.html";
                response.sendRedirect(redirectURL);
        }
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
                out.println("Close error: " + closeException); // Closed error message
            }
        }
        %>

    </body>
</html>