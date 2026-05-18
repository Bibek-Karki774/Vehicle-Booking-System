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
    public Vehicle getVehicleById(int vehicleId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, vehicleId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_name"),
                        rs.getString("vehicle_type"),
                        rs.getInt("total_seats"),
                        rs.getString("vehicle_description"),
                        rs.getDouble("price_per_day"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error fetching vehicle by id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }



    @Override
    public ArrayList<Vehicle> getAllVehicles() {
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
    public boolean updateVehicle(int vehicleId, Vehicle vehicle) {
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
            statement.setInt(6, vehicleId);
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


    public ArrayList<Vehicle> searchVehicles(String keyword) {
        ArrayList<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM vehicles " +
                    "WHERE vehicle_name LIKE ? OR vehicle_type LIKE ? " +
                    "ORDER BY created_at DESC";
            PreparedStatement statement = conn.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            statement.setString(1, kw);
            statement.setString(2, kw);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                vehicles.add(new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_name"),
                        rs.getString("vehicle_type"),
                        rs.getInt("total_seats"),
                        rs.getString("vehicle_description"),
                        rs.getDouble("price_per_day"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error searching vehicles: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return vehicles;
    }

    // Get list of different types of vehicles
    public ArrayList<String> getDistinctVehicleTypes() {
        ArrayList<String> types = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT DISTINCT vehicle_type FROM vehicles ORDER BY vehicle_type ASC";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                types.add(rs.getString("vehicle_type"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching vehicle types: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return types;
    }

    // Show vehicles by type
    public ArrayList<Vehicle> filterByType(String type) {
        ArrayList<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM vehicles WHERE vehicle_type = ? ORDER BY created_at DESC";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, type);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                vehicles.add(new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_name"),
                        rs.getString("vehicle_type"),
                        rs.getInt("total_seats"),
                        rs.getString("vehicle_description"),
                        rs.getDouble("price_per_day"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error filtering by type: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return vehicles;
    }

}