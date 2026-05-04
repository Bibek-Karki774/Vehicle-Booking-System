package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Booking;

import java.util.ArrayList;

public interface BookingDao{
    boolean addBooking(Booking booking);
    Booking getBookingById(int bookingId);
    ArrayList<Booking> getAllBookings();
    boolean deleteBookingById(int bookingId);
    double getDailyRevenue();
    double getMonthlyRevenue();
    double getYesterdayRevenue();
    int getBookedToday();
    ArrayList<Booking> searchBookings(String keyword);
}
