package com.vehiclebooking.dao;

import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDaoImpl implements UserDao {

    @Override
    public boolean insertUser(User user) {
        if(findByUsername(user.getUserName()) != null) return false;
        if(findByEmail(user.getEmail()) != null) return false;

        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql ="INSERT INTO users (username, password, phone, address, driving_license, email) VALUES (?,?,?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, user.getUserName());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getPhone());
            statement.setString(4, user.getAddress());
            statement.setString(5, user.getDrivingLicense());
            statement.setString(6, user.getEmail());
            statement.executeUpdate();
            return true;
        } catch (SQLException e){
            System.out.println("Error inserting user: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public User findByUsername(String username) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE LOWER(username) = LOWER(?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet rs =statement.executeQuery();
            if(rs.next()){
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("driving_license"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e){
            System.out.println("Error finding user by username: " + e.getMessage());
        } finally{
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs =statement.executeQuery();
            if(rs.next()){
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("driving_license"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e){
            System.out.println("Error finding user by email: " + e.getMessage());
        } finally{
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    // Get all pending users
    @Override
    public ArrayList<User> getPendingUsers() {
        Connection conn = null;
        ArrayList<User> pendingUsers = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE status = 'Pending' ORDER BY created_at DESC";

        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("driving_license"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("status")
                );
                pendingUsers.add(user);
            }

        } catch (SQLException e) {
            System.out.println("Error getting pending users: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return pendingUsers;
    }

    @Override
    public ArrayList<User> getAllUsers() {
        ArrayList<User> users = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("driving_license"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("status")
                );
            users.add(user);

            }

        } catch (SQLException e) {
            System.out.println("Error getting all users: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return users;
    }

    @Override
    public boolean approveUser(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET status = 'Active' WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error approving user: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }


    @Override
    public boolean rejectUser(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET status = 'Rejected' WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error rejecting user: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
}

