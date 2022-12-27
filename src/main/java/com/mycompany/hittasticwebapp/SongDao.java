package com.mycompany.hittasticwebapp;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


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
public class SongDao 
{
    private Connection conn;
    private String table; 

    public SongDao(Connection conn, String table) 
    {
        this.conn = conn;
        this.table = table;
    }

    // find an event with a given ID

    public Song findSongByID(int id) throws SQLException
    {
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where id=?");
        pStmt.setInt(1, id);
        ResultSet rs = pStmt.executeQuery();
    
        // Is there a row? If so, next() will return true
        if(rs.next())
        {
            // Create an Event object with the result
            return new Song(
                rs.getInt("id"),
                rs.getString("songName"),
                rs.getString("songArtist"),
                rs.getFloat("songPrice"),
                rs.getInt("songStock")
            );
        }
        // return null if there were no matching rows
        return null;    
    }


    // find all events featuring a given band 
    // returns the events as an ArrayList

    public ArrayList<Song> findSongByName(String songName) throws SQLException
    {
        ArrayList<Song> songs = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where songName=?");
        pStmt.setString(1, songName);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next())
        {
            // Create an Event object with each result and add it to the
            // ArrayList

            Song song = new Song(
                rs.getInt("id"),
                rs.getString("songName"),
                rs.getString("songArtist"),
                rs.getFloat("songPrice"),
                rs.getInt("songStock")
            );
            songs.add(song);
        }
        return songs;
    }
    
        public ArrayList<Song> findSongByArtist(String songArtist) throws SQLException
    {
        ArrayList<Song> songs = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where songArtist=?");
        pStmt.setString(1, songArtist);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next())
        {
            // Create an Event object with each result and add it to the
            // ArrayList

            Song song = new Song(
                rs.getInt("id"),
                rs.getString("songName"),
                rs.getString("songArtist"),
                rs.getFloat("songPrice"),
                rs.getInt("songStock")
            );
            songs.add(song);
        }
        return songs;
    }

    // add a new event - takes an Event object (which will contain a name,
    // a course, but NOT yet an ID) as a parameter and fills
    // in the ID attribute of the Event object with the ID allocated by 
    // the database. Also returns the allocated ID.

    public boolean addSong(Song song) throws SQLException
    {
        PreparedStatement pStmt = conn.prepareStatement ("insert into " + table + "(songName,songArtist,songPrice,songStock) values (?, ?, ?, ?)");
        pStmt.setString (1, song.getTitle()); 
        pStmt.setString (2, song.getArtist()); 
        pStmt.setDouble (3, song.getPrice()); 
        pStmt.setInt (4, song.getStock()); 
        int rowsAdded = pStmt.executeUpdate();

        // Was a row added successfully?
            if(rowsAdded == 1) 
            {
                return true;
            }
            else
            {
                return false;
            }
    }


    // update an event - takes an Event object as a parameter and updates
    // the record in the table with the ID of that event object passed in

    public int updateEvent(Song song) throws SQLException
    {
        PreparedStatement pStmt = conn.prepareStatement ("update " + table + " set date=?,time=?,availability=? where id=?");
        pStmt.setString (1, song.getTitle()); 
        pStmt.setString (2, song.getArtist()); 
        pStmt.setDouble (3, song.getPrice()); 
        pStmt.setInt (4, song.getStock()); 
        return pStmt.executeUpdate();
    }


    // delete an event - takes an Event object as a parameter 
    // and deletes the record with the ID of the event object passed in

    public int deleteEvent(Song song) throws SQLException
    {
        PreparedStatement pStmt = conn.prepareStatement ("delete from " + table + " where id=?");
        pStmt.setInt (1, song.getID()); 
        return pStmt.executeUpdate();
    }

    // other methods would be present, only a sample is shown...
    
    public ArrayList<Song> selectAllSongs() throws SQLException
    {
        ArrayList<Song> songs = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next())
        {
            // Create an Event object with each result and add it to the
            // ArrayList

            Song song = new Song(
                rs.getInt("id"),
                rs.getString("songName"),
                rs.getString("songArtist"),
                rs.getFloat("songPrice"),
                rs.getInt("songStock")
            );
            songs.add(song);
        }
        return songs;
    }
    
    public int updateSongStock(Song song, int newStockNumber) throws SQLException
    {
        int id = song.getID();
        PreparedStatement pStmt = conn.prepareStatement ("Update "+table+" set songStock=? where id="+id);
        pStmt.setInt (1, newStockNumber);
        return pStmt.executeUpdate();
    }
}