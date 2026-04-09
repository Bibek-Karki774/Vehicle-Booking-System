package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Vehicle;
import com.vehiclebooking.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class VehicleDaoImpl implements VehicleDao {

    @Override
    public boolean insertVehicle(Vehicle vehicle) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO vehicles (vehicle_name, vehicle_type, total_seats, vehicle_description, price_per_day) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, vehicle.getVehicleName());
            statement.setString(2, vehicle.getVehicleType());
            statement.setInt(3, vehicle.getTotalSeats());
            statement.setString(4, vehicle.getVehicleDescription());
            statement.setDouble(5, vehicle.getPricePerDay());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error inserting vehicle: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }



    @Override
    public ArrayList<Vehicle> fetchAllVehicles() {
        ArrayList<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM vehicles";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_name"),
                        rs.getString("vehicle_type"),
                        rs.getInt("total_seats"),
                        rs.getString("vehicle_description"),
                        rs.getDouble("price_per_day"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching vehicles: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return vehicles;
    }


    @Override
    public boolean updateVehicle(Vehicle vehicle) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE vehicles SET vehicle_name = ?, vehicle_type = ?, total_seats = ?, vehicle_description = ?, price_per_day = ? WHERE vehicle_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, vehicle.getVehicleName());
            statement.setString(2, vehicle.getVehicleType());
            statement.setInt(3, vehicle.getTotalSeats());
            statement.setString(4, vehicle.getVehicleDescription());
            statement.setDouble(5, vehicle.getPricePerDay());
            statement.setInt(6, vehicle.getVehicleId());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating vehicle: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }


    @Override
    public boolean deleteVehicle(int vehicleId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, vehicleId);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error deleting vehicle: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }


    @Override
    public ArrayList<Vehicle> searchVehiclesByName(String keyword) {
        ArrayList<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM vehicles WHERE LOWER(vehicle_name) LIKE LOWER(?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_name"),
                        rs.getString("vehicle_type"),
                        rs.getInt("total_seats"),
                        rs.getString("vehicle_description"),
                        rs.getDouble("price_per_day"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            System.out.println("Error searching vehicles: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return vehicles;
    }


    @Override
    public ArrayList<Vehicle> filterVehiclesByType(String vehicleType) {
        ArrayList<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM vehicles WHERE vehicle_type = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, vehicleType);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_name"),
                        rs.getString("vehicle_type"),
                        rs.getInt("total_seats"),
                        rs.getString("vehicle_description"),
                        rs.getDouble("price_per_day"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            System.out.println("Error filtering vehicles: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return vehicles;
    }
}