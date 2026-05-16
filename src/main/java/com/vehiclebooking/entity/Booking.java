package com.vehiclebooking.entity;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int userId;
    private int vehicleId;
    private int totalDays;
    private Timestamp startDate;
    private Timestamp endDate;
    private double totalAmount;
    private String vehicleType;
    private int totalBookings;
    private String userName;
    private String vehicleName;

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

    public Booking() {}

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
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    public int getTotalDays() { return totalDays; }
    public void setTotalDays(int totalDays) { this.totalDays = totalDays; }
    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    public int getTotalBookings() { return totalBookings; }
    public void setTotalBookings(int totalBookings) { this.totalBookings = totalBookings; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getVehicleName() { return vehicleName; }
    public void setVehicleName(String vehicleName) { this.vehicleName = vehicleName; }

    @Override
    public String toString() {
        return "[" + bookingId + "] UserID: " + userId + ", VehicleID: " + vehicleId +
                ", " + startDate + " to " + endDate + ", Total Amount: " + totalAmount;
    }
}
