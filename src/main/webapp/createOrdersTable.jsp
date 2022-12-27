<%-- 
    Document   : createOrdersTable
    Created on : 21 Dec 2022, 13:02:18
    Author     : thesu
--%>

<!-- Import all of the Java Libraries -->

<%@page import="com.mycompany.hittasticwebapp.User"%>
<%@page import="com.mycompany.hittasticwebapp.Order"%>
<%@page import="com.mycompany.hittasticwebapp.Song"%>
<%@page import="com.mycompany.hittasticwebapp.OrderDao"%>
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
        <title>createOrdersTable.jsp</title> <!-- Title of the webpage -->
    </head>
    <body>
        <div id="title2"><h1>Order Table Created</h1></div>
        <%
            //Connect to the database
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:HitTastic.db");
            
            //Create the table
            
            
           // Statement stmt = conn.createStatement();
            //stmt.executeUpdate("create table if not exists ordering(userID integer, userName string, songID integer, songTitle string, songArtist string, quantity integer, totalPrice double)");
out.println((User) session.getAttribute("loggedUser"));
%>
        
    </body>
</html>
