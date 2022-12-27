<%-- 
    Document   : shoppingcart
    Created on : 22 Dec 2022, 16:33:20
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

<%@page import="com.mycompany.hittasticwebapp.SongDao"%>
<%@page import="com.mycompany.hittasticwebapp.User"%>
<%@page import="com.mycompany.hittasticwebapp.Order"%>
<%@page import="com.mycompany.hittasticwebapp.Song"%>
<%@page import="com.mycompany.hittasticwebapp.OrderDao"%>
<%@page import="com.mycompany.hittasticwebapp.ShoppingCart"%>
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
        <title>shoppingcart.jsp</title>  <!-- Title of the webpage -->
    </head>
    <body>
        <div id="title2"><h1><%=session.getAttribute("username")%> Shopping Cart....</h1></div> <!-- Prompts the user of their shopping cart for their username -->
        <%
        Connection connection = null; // Create the connection object
        try // Run this code before the other block
        {
            // Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db");
        
             // Create the DAO
            SongDao dao = new SongDao(conn, "song");
            %>
            <table class="border">  <!-- The headings for the display table -->
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
            
            ArrayList<ShoppingCart> currentCart = (ArrayList<ShoppingCart>) session.getAttribute("currentCart"); // Brings the currentCart object out of the session and into a local ArrayList to be manipulated
            ArrayList<Song> songs = dao.selectAllSongs(); // Selects all songs in the database and placing them in an ArrayList
            // Define some variables
            String title = ""; 
            String artist = "";
            Double totalCost = 0.0;
            for(ShoppingCart c: currentCart) // For each order in the shopping cart
            {
            int id = c.getsongID(); // Get the requested songs ID
            for(Song s: songs) // For every song in the songs ArrayList
            {
               if(id == s.getID()){ // If the songs ID matches the user inputted ID then
               title = s.getTitle(); // Get the songs title and artist
               artist = s.getArtist();
               totalCost = s.getPrice() * c.getQuantity(); // Calculate the total cost
            }
            }

               %><tr><td><% out.println(session.getAttribute("userid"));%></td><% // Display all the information into a table
               %><td><% out.println(session.getAttribute("username"));%></td><%
               %><td><% out.println(c.getsongID());%></td><%
               %><td><% out.println(title);%></td><%
               %><td><% out.println(artist);%></td><%
               %><td><% out.println(c.getQuantity());%></td><%
               %><td><% out.println("£"+String.format("%.2f", totalCost));%></td><%
            }
            
            %>
                
            </table> <!-- Gives the option to checkout or empty the cart -->
            <div class="center">
            <form action="./buySong.jsp" method="post">
            <input type="submit" value="Checkout!" />
            </form> 
            <form action=".center/clearCart.jsp" method="post">
            <input type="submit" value="Empty Cart!" />
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
