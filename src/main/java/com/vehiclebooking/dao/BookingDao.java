package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Booking;

import java.sql.Timestamp;
import java.util.ArrayList;

public interface BookingDao{
    boolean addBooking(Booking booking);
    ArrayList<Booking> getAllBookings();
    ArrayList<String> getAvailableDatesThisWeek(int vehicleId);
    boolean isVehicleBooked(int vehicleId, Timestamp start, Timestamp end);
    boolean deleteBookingById(int bookingId);
    double getDailyRevenue();
    double getMonthlyRevenue();
    double getYesterdayRevenue();
    int getBookedToday();
    ArrayList<Booking> searchBookings(String keyword);
    ArrayList<Booking> getBookingsByUserId(int userId);
    ArrayList<Booking> getTop5BookedVehicles(String range);

    // For admin dashboard chart
    ArrayList<String> getLast7DaysRevenueDates();
    ArrayList<Double> getLast7DaysRevenueAmounts();
}
