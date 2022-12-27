
package com.mycompany.hittasticwebapp;


public class Song {
    
    // initialises variables for song objects
    private String title, artist;
    private int id, stock;
    private double price;
    private static int totalSongs = 0;  // records total numer of objects created
    
    
    // method to create song objects from parameters passed to this method
    public Song (int id, String titleIn, String artistIn, float priceIn, int stockIn) {
        // assigns object attributes
        this.id = id;
        this.title = titleIn;
        this.artist = artistIn;
        this.price = priceIn;
        this.stock = stockIn;
    }
    
    
    // get methods used to retrieve object data 
    public String getTitle(){
        return this.title;
    }
    public String getArtist(){
        return this.artist;
    }
    public double getPrice(){
        return this.price;
    }
    public int getStock(){
        return this.stock;
    }
    public int getID(){
        return this.id;
    }
    
    
    // set methods used to retrieve object data 
    public void setTitle(String newTitle){
        this.title = newTitle;
    }   
    public void setArtist(String newArtist){
        this.artist = newArtist;
    }    
    public void setPrice(double newPrice){
        this.price = newPrice;
    }
    public void setStock(int newStock){
        this.stock = stock;
    }
    
    /*
    // WS
    public void printDetails(){
            System.out.println("ID: "+this.id+", Title: "+this.title+", Artist: " + this.artist+", Sales: " + this.copiesSold); // Prints all the details of a given song
        }

    public void printDetailsArtist(){
            System.out.println("ID: "+this.id+", Title: "+this.title); // Prints all the details of a song minus the artists name
        }   
    
    public int increaseSales(int increaseBy){ // The integer passed into this method is by how much the sales will go up
            this.copiesSold = this.copiesSold + increaseBy;// Increases the current sales of a song by a user determined amount
            return this.copiesSold; // Returns it to the method it was called from
        }
*/
}
