<%-- 
    Document   : commandListAdmin
    Created on : 21 Dec 2022, 19:41:01
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

<%@page import="com.mycompany.hittasticwebapp.ShoppingCart"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HitTastic Landing Page</title> <!-- Title of the webpage -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="stylesheet.css"/> <!-- Link to stylesheet -->
    </head>
    <body>
        
        <!-- Sets the username and balance box up -->
        
        <div id="header" class="box">
        <h1>Welcome <%= session.getAttribute("username") %>!</h1>
        <h2>Balance: £<%= String.format("%.2f", (double) session.getAttribute("balance"))%> </h2>
        </div>
        
        <!-- Sets the title page box up -->
        
        <div id="title">
        <h1>List of Commands for the HitTastic App</h1>
        </div>
        
        <div class="controlpanel1">  <!-- Sets the container for the first row of boxes up -->
            
        <!-- Sets the Search Song by Title Form up -->
        
        <div class="box">
        <h2>Search Song Title Form</h2>
        <form action="./searchTitle.jsp" method="post">
            <p>Song name:<input type="text" name="songName" value="" /></p>
            <input type="hidden" name="userid" value="<%=(int) session.getAttribute("userid")%>" />
            <input type="submit" value="Search for the Song!" />
        </form> 
        </div>
            
        <!-- Sets the Search Song by Artist Form up --> 
            
        <div class="box">
        <h2>Search Song Artist Form</h2>
        <form action="./searchArtist.jsp" method="post">
            <p>Song name:<input type="text" name="songArtist" value="" /></p>
            <input type="hidden" name="userid" value="<%=(int) session.getAttribute("userid")%>" />
            <input type="submit" value="Search for the Song!" />
        </form> 
        </div>
            
        <!-- Sets the Check users order history form up -->   
            
        <div class="box">
        <h2>Check your order history</h2>
        <form action="./showOrderHistory.jsp" method="post">
            <input type="submit" value="Check the history!" />
        </form> 
        </div>
               
        <!-- As soon as a shoppingcart is created the option to see the shopping cart will be available -->
        <%
            if ((ArrayList<ShoppingCart>)session.getAttribute("currentCart") != null){
            out.println("<div class=\"box\"><h2>Shopping cart</h2><form action=\"./shoppingcart.jsp\" method=\"post\"><input type=\"submit\" value=\"Show shopping cart!\" /></form></div"); 
            }
            
        %>
       
        </div>
    </body>
</html>
