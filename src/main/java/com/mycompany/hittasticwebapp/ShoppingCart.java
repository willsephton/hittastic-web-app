/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebapp;

/**
 *
 * @author thesu
 */

public class ShoppingCart{
    
        private int quantity, songID;
        
        public ShoppingCart (int songIDIn, int quantityIn){ // Creates the object
            this.songID = songIDIn;
            this.quantity = quantityIn;
        }
        
        public int getQuantity(){ // Used to get the username of a user on an order
            return quantity;
        }
        public int getsongID(){ // Used to get the username of a user on an order
            return songID;
        }

        
}
