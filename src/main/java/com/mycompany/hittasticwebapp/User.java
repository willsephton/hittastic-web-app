package com.mycompany.hittasticwebapp;

import java.util.ArrayList;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Quinn Toye
 */
public class User {
    
    // initialises variables for user objects
    private String uName, pWord;
    private String isAdmin;
    private int id;
    private double balance;
    private static int totalUsers = 0;  // records total numer of objects created
    
    // method to create user objects from parameters passed to this method
    public User (int id, String uNameIn, String pWordIn, String isAdminIn, Double balanceIn) {
        this.id = id;
        this.uName = uNameIn;
        this.pWord = pWordIn;
        this.isAdmin = isAdminIn;
        this.balance = balanceIn;
    }
    
    // get methods used to retrieve object data 
    public int getID(){
        return this.id;
    }
    public String getUName(){
        return this.uName;
    }
    public String getPWord(){
        return this.pWord;
    }
    public String getAdminStatus(){
        return this.isAdmin;
    }
    public double getBalance(){
        return this.balance;
    }

    
    // set methods used to retrieve object data 
    public void setUName(String newUName){
        this.uName = newUName;
    }   
    public void setPWord(String newPWord){
        this.pWord = newPWord;
    }    
    public void setStatus(String newStatus){
        this.isAdmin = newStatus;
    }
    public double setBalance(double newBalance){
        return this.balance = newBalance;
    }

}
