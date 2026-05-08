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
            String sql = "INSERT INTO wishlist (user_id, vehicle_id) VALUES (?, ?)";
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
    public ArrayList<Wishlist> fetchWishlistByUserId(int customerId) {
        ArrayList<Wishlist> wishlists = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM wishlist WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Wishlist wishlist = new Wishlist(
                        rs.getInt("wishlist_id"),
                        rs.getInt("user_id"),
                        rs.getInt("vehicle_id"),
                        rs.getTimestamp("added_at")
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

    public boolean deleteAllByUserId(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM wishlist WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Error clearing wishlist: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    public void toggleWishlist(int userId, int vehicleId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String check = "SELECT wishlist_id FROM wishlist WHERE user_id=? AND vehicle_id=?";
            PreparedStatement ps = conn.prepareStatement(check);
            ps.setInt(1, userId);
            ps.setInt(2, vehicleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String delete = "DELETE FROM wishlist WHERE user_id=? AND vehicle_id=?";
                PreparedStatement del = conn.prepareStatement(delete);
                del.setInt(1, userId);
                del.setInt(2, vehicleId);
                del.executeUpdate();
            } else {
                String insert = "INSERT INTO wishlist (user_id, vehicle_id) VALUES (?,?)";
                PreparedStatement ins = conn.prepareStatement(insert);
                ins.setInt(1, userId);
                ins.setInt(2, vehicleId);
                ins.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Toggle wishlist error: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
    
}