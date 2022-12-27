<%-- 
    Document   : clearCart
    Created on : 22 Dec 2022, 17:42:36
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
        <title>clearCart.jsp</title> <!-- Title of the webpage -->
    </head>
    <body>
        <h1>Clearing Cart...</h1> <!-- Prompts the user that it hasn't been created -->
        <%
        ArrayList<ShoppingCart> currentCart = (ArrayList<ShoppingCart>)session.getAttribute("currentCart"); // Gets the currentCart list
        currentCart.clear(); // Clears the current cart list
        session.setAttribute("currentCart", currentCart); // sets the new empty cart as the current cart
        out.println("Cart Cleared!"); // Prompts the user that the cart was cleared
        String redirectURL = "shoppingcart.jsp"; // Sends them back to the shoppingcart.jsp
        response.sendRedirect(redirectURL);
        %>
    </body>
</html>
