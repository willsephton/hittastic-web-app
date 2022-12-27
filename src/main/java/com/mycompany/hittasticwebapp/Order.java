
package com.mycompany.hittasticwebapp;

// WS - Creates the order class
public class Order {
    
        private String title, artist, username; // Defines the attributes of an order
        private int userID, songID, orderSale;
        private double totalCost;
        
        public Order (int userIDIn, String usernameIn, int songIDIn, String titleIn, String artistIn, int orderSaleIn, double totalCostIn){ // Creates the object
            this.userID = userIDIn;
            this.username = usernameIn;
            this.songID = songIDIn;
            this.title = titleIn;
            this.artist = artistIn;
            this.orderSale = orderSaleIn;
            this.totalCost = totalCostIn;
        }
        
        public String getUsername(){ // Used to get the username of a user on an order
            return username;
        }
        public int getuserID(){ // Used to get the username of a user on an order
            return userID;
        }
        public int getsongID(){ // Used to get the username of a user on an order
            return songID;
        }
        public String getTitle(){ // Used to get the username of a user on an order
            return title;
        }
        public String getArtist(){ // Used to get the username of a user on an order
            return artist;
        }
        public int getorderSale(){ // Used to get the username of a user on an order
            return orderSale;
        }
        public double getTotalCost(){ // Used to get the username of a user on an order
            return totalCost;
        }
        
        
        
        public void printDetails(){ // Prints all the information on an order
            System.out.println("Song Title- "+this.title+", Artist- " + this.artist+", Number Of Copies- " + this.orderSale);
        }
}
