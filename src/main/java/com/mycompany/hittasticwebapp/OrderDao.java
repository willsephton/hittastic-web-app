/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebapp;


import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Connection; 
import java.sql.DriverManager;
import java.util.ArrayList;
import com.mycompany.hittasticwebapp.Song;
import com.mycompany.hittasticwebapp.Order;
import com.mycompany.hittasticwebapp.User;




/**
 *
 * @author thesu
 */
public class OrderDao {
    
    private Connection conn;
    private String table; 

    public OrderDao(Connection conn, String table) 
    {
        this.conn = conn;
        this.table = table;
    }
    
    public ArrayList<Order> selectAllOrders() throws SQLException
    {
        ArrayList<Order> orders = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next())
        {
            // Create an Event object with each result and add it to the
            // ArrayList

            Order order = new Order(
                rs.getInt("userID"),
                rs.getString("userName"),
                rs.getInt("songID"),
                rs.getString("songTitle"),
                rs.getString("songArtist"),
                rs.getInt("quantity"),
                rs.getDouble("totalPrice")
            );
            orders.add(order);
        }
        return orders;
    }
    
    public double createNewOrder(Song song, User user, int quantity) throws SQLException
    {
        double songCost = song.getPrice();
        double totalPrice = songCost * quantity;
        PreparedStatement pStmt = conn.prepareStatement ("insert into "+table+"(userID,userName,songID,songTitle,songArtist,quantity,totalPrice) values (?, ?, ?, ?, ?, ?, ?)");
        pStmt.setInt (1, user.getID());
        pStmt.setString (2, user.getUName());
        pStmt.setInt (3, (song.getID()));
        pStmt.setString (4, song.getTitle());
        pStmt.setString (5, song.getArtist());
        pStmt.setInt (6, quantity);
        pStmt.setDouble (7, totalPrice);
        pStmt.executeUpdate();
        return totalPrice;
            
    }
    
}
