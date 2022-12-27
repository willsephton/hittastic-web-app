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

/**
 *
 * @author thesu
 */
public class UserDao {
    
    private Connection conn;
    private String table; 

    public UserDao(Connection conn, String table) 
    {
        this.conn = conn;
        this.table = table;
    }
    
    
    public ArrayList<User> selectAllUsers() throws SQLException
    {
        ArrayList<User> users = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next())
        {
            // Create an Event object with each result and add it to the
            // ArrayList

            User user = new User(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getString("userType"),
                rs.getDouble("balance")
            );
            users.add(user);
        }
        return users;
    }
    
    /*
    public String login(String username, String password) throws SQLException
    {
        ArrayList<User> users = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table);
        ResultSet rs = pStmt.executeQuery();
        String currentUserType = "";
        
        while(rs.next()) 
        {
            String currentName = rs.getString("username");
            String currentPass = rs.getString("password");
            String currentUserType2 = rs.getString("userType");
            // if user inputted login details equal the current details, the current user is returned as the loogged in user; exiting the method
            if((username.equals(currentName)) && (password.equals(currentPass))){
                if (currentUserType2.equals("Admin")){
                    currentUserType = "Admin";
                    return currentUserType;
                }
                else if(currentUserType2.equals("User")){
                    currentUserType = "User";
                    return currentUserType;
                }
                else{
                    currentUserType = "Fail2";
                    return currentUserType;
                }
                              
            }
            else{
                currentUserType = "Fail";
            }
        }
        return currentUserType;
    }
*/
    
    public int deleteUser(User user) throws SQLException
    {
        PreparedStatement pStmt = conn.prepareStatement ("delete from " + table + " where id=?");
        pStmt.setInt(1, user.getID()); 
        return pStmt.executeUpdate();
    }
    
    public int updateUser(User user, String username, String password, String usertype, int newID, double balance) throws SQLException
    {
        int id = user.getID();
        PreparedStatement pStmt = conn.prepareStatement ("Update "+table+" set id=?, username=?,password=?,userType=?,balance=? where id="+id);
        pStmt.setInt (1, newID);
        pStmt.setString (2, username);
        pStmt.setString (3, password);
        pStmt.setString (4, usertype);
        pStmt.setDouble(5,balance);
        return pStmt.executeUpdate();
    }
    
    public int updateUserBalance(User user, double balance) throws SQLException
    {
        int id = user.getID();
        PreparedStatement pStmt = conn.prepareStatement ("Update "+table+" set balance=? where id="+id);
        pStmt.setDouble(1,balance);
        return pStmt.executeUpdate();
    }
     
}

   
