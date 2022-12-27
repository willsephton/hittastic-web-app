<%-- 
    Document   : shoppingcart
    Created on : 22 Dec 2022, 16:10:43
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
        <title>addToCart.jsp</title> <!-- Title of the webpage -->
    </head>
    <body>
        <%
            do{ // Initialise the do while loop
            if ((ArrayList<ShoppingCart>)session.getAttribute("currentCart") != null){ // Checks if the shopping cart is empty or even exists
            ArrayList<ShoppingCart> currentCart = (ArrayList<ShoppingCart>) session.getAttribute("currentCart"); // finds the current cart arraylist
            currentCart.add( new ShoppingCart (Integer.parseInt(request.getParameter("id")), Integer.parseInt(request.getParameter("quantity")))); // adds the song and quantity to a shoppingcart object and stores it in the current cart list
            session.setAttribute("currentCart", currentCart); // sets the shopping cart object to the session to be used else where
            %><div id="title2"><h1>Added To Cart!</h1></div><% // Prompts the user that it has been added to cart
            }
            else if (session.getAttribute("currentCart") == null){ // if the cart is empty or doesnt exist run this code
               ArrayList<ShoppingCart> currentCart = new ArrayList<ShoppingCart> (); // creates the shopping cart object (Current cart)
               currentCart.add( new ShoppingCart (Integer.parseInt(request.getParameter("id")), Integer.parseInt(request.getParameter("quantity")))); // Adds the song and quantity to the currentCart list
               session.setAttribute("currentCart", currentCart); // sets the shopping cart object to the session to be used else where
               %><div id="title2"><h1>Added To Cart!</h1></div><% // Prompts the user that it has been added to cart
            }
            } while((ArrayList<ShoppingCart>)session.getAttribute("currentCart") == null); // While loop conditions

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
