<%-- 
    Document   : addSong
    Created on : 15 Dec 2022, 08:04:40
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

<%@page import="com.mycompany.hittasticwebapp.Song"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.hittasticwebapp.SongDao"%>
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
        <title>addSong.jsp</title> <!-- Title of the webpage -->
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
            SongDao dao = new SongDao(conn, "song");
            
            // Insert Statements
            PreparedStatement pStmt = conn.prepareStatement ("insert into song(songName,songArtist,songPrice,songStock) values (?, ?, ?, ?)");
            pStmt.setString (1, request.getParameter("songName"));
            pStmt.setString (2, request.getParameter("songArtist"));
            pStmt.setString (3, request.getParameter("songPrice"));
            pStmt.setString (4, request.getParameter("songStock"));
            int rowsAdded = pStmt.executeUpdate();
            if(rowsAdded == 1) // Checks to see if the database has been updated.
            {
                %><div id="title2"><h1>Successfully added</h1></div><% // Prompts the user that it has been created
            }
            else
            {
                 %><div id="title2"><h1>Could not add</h1></div><% // Prompts the user that it hasn't been created
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
