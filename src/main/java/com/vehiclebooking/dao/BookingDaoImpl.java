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
        try {
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
        } catch (SQLException e) {
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
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT b.booking_id, b.user_id, b.vehicle_id, " +
                    "b.total_amount, b.start_date, b.end_date, " +
                    "u.username, v.vehicle_name " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                    "ORDER BY b.start_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("user_id"),
                        rs.getInt("vehicle_id"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date")
                );
                booking.setUserName(rs.getString("username"));
                booking.setVehicleName(rs.getString("vehicle_name"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.out.println("Error getting all bookings: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return bookings;
    }

    @Override
    public ArrayList<Booking> searchBookings(String keyword) {
        ArrayList<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT b.booking_id, b.user_id, b.vehicle_id, " +
                    "b.total_amount, b.start_date, b.end_date, " +
                    "u.username, v.vehicle_name " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                    "WHERE LOWER(u.username) LIKE LOWER(?) " +
                    "OR LOWER(v.vehicle_name) LIKE LOWER(?) " +
                    "ORDER BY b.start_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("user_id"),
                        rs.getInt("vehicle_id"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date")
                );
                booking.setUserName(rs.getString("username"));
                booking.setVehicleName(rs.getString("vehicle_name"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.out.println("Error searching bookings: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return bookings;
    }

    @Override
    public ArrayList<Booking> getBookingsByUserId(int userId) {
        ArrayList<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT b.booking_id, b.user_id, b.vehicle_id, " +
                    "b.total_amount, b.start_date, b.end_date, " +
                    "v.vehicle_name " +
                    "FROM bookings b " +
                    "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                    "WHERE b.user_id = ? " +
                    "ORDER BY b.start_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("user_id"),
                        rs.getInt("vehicle_id"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date")
                );
                booking.setVehicleName(rs.getString("vehicle_name"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.out.println("Error getting bookings by user id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return bookings;
    }


    @Override
    public ArrayList<Booking> getTop5BookedVehicles(String range) {
        ArrayList<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();

            String dateFilter;
            if ("7d".equals(range)) {
                dateFilter = "AND DATEDIFF(CURDATE(), b.start_date) <= 7";
            } else if ("6m".equals(range)) {
                dateFilter = "AND DATEDIFF(CURDATE(), b.start_date) <= 180";
            } else if ("1y".equals(range)) {
                dateFilter = "AND DATEDIFF(CURDATE(), b.start_date) <= 365";
            } else {
                dateFilter = "AND DATEDIFF(CURDATE(), b.start_date) <= 30";
            }

            String sql = "SELECT v.vehicle_name, v.vehicle_type, " +
                    "COUNT(b.booking_id) AS total_bookings, " +
                    "SUM(b.total_amount) AS total_revenue " +
                    "FROM bookings b " +
                    "JOIN vehicles v ON b.vehicle_id = v.vehicle_id WHERE 1=1 " + dateFilter +
                    " GROUP BY v.vehicle_id, v.vehicle_name, v.vehicle_type " +
                    "ORDER BY total_bookings DESC LIMIT 5";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setVehicleName(rs.getString("vehicle_name"));
                b.setVehicleType(rs.getString("vehicle_type"));
                b.setTotalBookings(rs.getInt("total_bookings"));
                b.setTotalAmount(rs.getDouble("total_revenue"));
                bookings.add(b);
            }
        } catch (SQLException e) {
            System.out.println("Error getting top 5 booked vehicles: " + e.getMessage());
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

    @Override
    public double getDailyRevenue() {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(total_amount) FROM bookings WHERE DATE(created_at) = CURDATE();";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            System.out.println("Error fetching data of daily revenue " +  e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    @Override
    public double getMonthlyRevenue() {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(total_amount) FROM bookings WHERE MONTH(created_at) = MONTH(CURDATE());";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            System.out.println("Error fetching data of monthly revenue " +  e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    @Override
    public double getYesterdayRevenue() {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(total_amount) FROM bookings WHERE DATE(created_at) = CURDATE() - 1";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            System.out.println("Error fetching yesterday revenue: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    public int getBookedToday() {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM bookings WHERE start_date <= CURDATE() AND end_date >= CURDATE()";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error fetching booked today: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    // Methods for dashboard js chart
    @Override
    public ArrayList<String> getLast7DaysRevenueDates() {
        ArrayList<String> dates = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT DATE(created_at) AS day FROM bookings " +
                    "WHERE created_at >= CURDATE() - INTERVAL 7 DAY " +
                    "GROUP BY DATE(created_at) " +
                    "ORDER BY day ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                dates.add(rs.getString("day"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching revenue dates: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return dates;
    }

    @Override
    public ArrayList<Double> getLast7DaysRevenueAmounts() {
        ArrayList<Double> amounts = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(total_amount) AS revenue FROM bookings " +
                    "WHERE created_at >= CURDATE() - INTERVAL 7 DAY " +
                    "GROUP BY DATE(created_at) " +
                    "ORDER BY DATE(created_at) ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                amounts.add(rs.getDouble("revenue"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching revenue amounts: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return amounts;
    }

}
