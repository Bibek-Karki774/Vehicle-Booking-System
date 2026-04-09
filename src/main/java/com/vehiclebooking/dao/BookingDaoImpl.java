package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Booking;
import com.vehiclebooking.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookingDaoImpl implements  BookingDao {

    @Override
    public boolean addBooking(Booking booking) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO bookings(user_id, vehicle_id, start_date, end_date, total_amount) VALUES (?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getVehicleId());
            ps.setTimestamp(3, booking.getStartDate());
            ps.setTimestamp(4, booking.getEndDate());
            ps.setDouble(5, booking.getTotalAmount());
            ps.executeUpdate();
            return true;
        } catch (SQLException e){
            System.out.println("Error adding booking: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public Booking getBookingById(int bookingId) {
        Connection conn = null;
        try {
            conn =  DatabaseConnection.getConnection();
            String sql = "SELECT * FROM bookings WHERE booking_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, bookingId);
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                return new Booking(
                    rs.getInt("booking_id"),
                        rs.getInt("user_id"),
                        rs.getInt("vehicle_id"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date")
                );
            }
        }
        catch (SQLException e){
            System.out.println("Error getting booking details by id: " + e.getMessage());
        }

        return null;
    }

    @Override
    public ArrayList<Booking> getAllBookings() {
        ArrayList<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM bookings";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("user_id"),
                        rs.getInt("vehicle_id"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date")
                );
                bookings.add(booking);
            }

        } catch(SQLException e){
            System.out.println("Error getting all bookings: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return bookings;
    }

    @Override
    public boolean deleteBookingById(int bookingId) {
        Connection conn = null;
        try{
            String sql = "DELETE FROM bookings WHERE booking_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, bookingId);
            statement.executeUpdate();
            return true;
        } catch (SQLException e){
            System.out.println("Error deleting booking by id: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
}
