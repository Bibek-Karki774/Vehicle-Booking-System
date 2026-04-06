package com.vehiclebooking.entity;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int userId;
    private int vehicleId;
    private Timestamp startDate;
    private Timestamp endDate;
    private double totalAmount;

    // Constructor for inserting booking record
    public Booking(int userId, int vehicleId, double totalAmount, Timestamp startDate, Timestamp endDate
                    ) {
            this.userId = userId;
            this.vehicleId = vehicleId;
            this.startDate = startDate;
            this.endDate = endDate;
            this.totalAmount = totalAmount;
    }

    // Constructor for reading data from database
    public Booking(int bookingId,int userId, int vehicleId, double totalAmount, Timestamp startDate, Timestamp endDate) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.vehicleId = vehicleId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalAmount = totalAmount;
    }

    // Getters
    public int getBookingId() {
        return bookingId;
    }
    public int getUserId() {
        return userId;
    }
    public int getVehicleId() {
        return vehicleId;
    }
    public Timestamp getStartDate() {
        return startDate;
    }
    public Timestamp getEndDate() {
        return endDate;
    }
    public double getTotalAmount() {
        return totalAmount;
    }

    @Override
    public String toString() {
        return "[" + bookingId + "] UserID: " + userId + ", VehicleID: " + vehicleId +
                ", " + startDate + " to " + endDate + ", Total Amount: " + totalAmount;
    }
}
