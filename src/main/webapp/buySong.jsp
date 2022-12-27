<%-- 
    Document   : searchTitle
    Created on : 15 Dec 2022, 08:26:58
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

<%@page import="com.mycompany.hittasticwebapp.OrderDao"%>
<%@page import="com.mycompany.hittasticwebapp.UserDao"%>
<%@page import="com.mycompany.hittasticwebapp.User"%>
<%@page import="com.mycompany.hittasticwebapp.Song"%>
<%@page import="com.mycompany.hittasticwebapp.SongDao"%>
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
        <title>buySong.jsp</title> <!-- Title of the webpage -->
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
            UserDao dao2 = new UserDao(conn, "user");
            OrderDao dao3 = new OrderDao(conn, "ordering");

            // Select all the songs users and the current cart
            ArrayList<Song> songs = dao.selectAllSongs();
            ArrayList<User> users = dao2.selectAllUsers();
            ArrayList<ShoppingCart> currentCart = (ArrayList<ShoppingCart>) session.getAttribute("currentCart");
            int userid = (int) session.getAttribute("userid"); // Get the current users ID
            for(ShoppingCart c: currentCart){ // For every order in the currentCart list
            int id = c.getsongID(); // gets the song id
            int quantity = c.getQuantity(); // gets the songs quantity
            for(User u: users){ // for every user in the user list
            if(userid == u.getID()){ // if the id is the same as the current users id
            for(Song s: songs) // for every song in the song list
            {
                if(id == s.getID()){ // if the songs ID matches the ordered songs ID
                
                   double totalPrice = dao3.createNewOrder(s, u, quantity); // creates a new order and returns the total price
                   double newBalance = u.getBalance() - totalPrice; // calculates a new balanace
                   dao2.updateUserBalance(u, newBalance); // updates the current users balance
                   session.setAttribute("balance", newBalance); // sets that new balance as a session variable
                   int newStockNumber = s.getStock() - quantity; // Calculates a new stock number
                   dao.updateSongStock(s, newStockNumber); // Updates that songs stock

                }
            }
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
                out.println("Close error: " + closeException);
            }
        }
        %><div id="title2"><h1>You have been successfully checked out!</h1></div><% // Prompts the user that they have been checked out
        ArrayList<ShoppingCart> currentCart = (ArrayList<ShoppingCart>)session.getAttribute("currentCart"); // Gets the current cart
        currentCart.clear(); // Clears the current cart list using the ArrayList clear() method
        session.setAttribute("currentCart", currentCart); // sets the new empty cart as the current cart
        
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
