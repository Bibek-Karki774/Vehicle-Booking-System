package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Wishlist;
import com.vehiclebooking.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class WishlistDaoImpl implements WishlistDao {

    @Override
    public boolean insertWishlist(Wishlist wishlist) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO wishlist (customer_id, vehicle_id) VALUES (?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, wishlist.getUserId());
            statement.setInt(2, wishlist.getVehicleId());
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Error inserting wishlist: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public ArrayList<Wishlist> fetchWishlistByCustomerId(int customerId) {
        ArrayList<Wishlist> wishlists = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM wishlist WHERE customer_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Wishlist wishlist = new Wishlist(
                        rs.getInt("wishlist_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("vehicle_id"),
                        rs.getTimestamp("added_date")
                );
                wishlists.add(wishlist);
            }
        } catch (Exception e) {
            System.out.println("Error fetching all wishlist items: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return wishlists;
    }

    @Override
    public boolean deleteWishlist(int wishlistId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM wishlist WHERE wishlist_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, wishlistId);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Error deleting wishlist: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
    
}