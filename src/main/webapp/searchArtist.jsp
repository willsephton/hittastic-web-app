<%-- 
    Document   : searchTitle
    Created on : 15 Dec 2022, 08:26:58
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

<%@page import="com.mycompany.hittasticwebapp.Song"%>
<%@page import="com.mycompany.hittasticwebapp.SongDao"%>
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
        <title>searchArtist.jsp</title>  <!-- Title of the webpage -->
    </head>
    <body>
        <div id="title"><h1>Search Results for "<%=request.getParameter("songArtist")%>"</h1></div>  <!-- Prompts the user of the search results for their username -->
         <%
        Connection connection = null; // Create the connection object
        try // Run this code before the other block
        {
            // Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db");
        
             // Create the DAO
            SongDao dao = new SongDao(conn, "song");
 
            ArrayList<Song> songs = dao.findSongByArtist(request.getParameter("songArtist")); // Fills the array list with songs that have the user entered artist

          %>
            <table class="border"> <!-- The headings for the display table -->
                <tr>
                    <th>Song ID</th>
                    <th>Song Title</th>
                    <th>Song Artist</th>
                    <th>Song Price</th>
                    <th>Song Stock</th>
                </tr>
                
            <%
            for(Song s: songs) // For every song in the songs arraylist
            {
               %><tr><td><% out.println(s.getID());%></td><% // Display all the fields in the song database
               %><td><% out.println(s.getTitle());%></td><%
               %><td><% out.println(s.getArtist());%></td><%
               %><td><% out.println("£"+String.format("%.2f", s.getPrice()));%></td><%
               %><td><% out.println(s.getStock());%></td><%
            }
            %>       
            </table>
            <br>
            <div id="formInForm"> <!-- This form is to add a certain song to your cart and then runs addToCart.jsp -->
            <h2>Buy Song Form</h2>
            <form action="./addToCart.jsp" method="post">
            <p>Song ID:<input type="text" name="id" value="" /></p>
            <p>Amount of Copies:<input type="text" name="quantity" value="" /></p>
            <input type="submit" value="Add this song to cart!" />
            </form> 
            </div>
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
