package com.vehiclebooking.entity;

import java.sql.Timestamp;

/**
 * This class represents a vehicle in the vehicle booking system.
 * This class stores all vehicle-related information such as name, type,
 * seating capacity, descriptions etc.
 * It provides getter and setter methods to access and update vehicle details
 * such as name, type, seats, description, and price.
 */
public class Vehicle {

    private int vehicleId;
    private int wishlistId;
    private String vehicleName;
    private String vehicleType;
    private int totalSeats;
    private String vehicleDescription;
    private double pricePerDay;
    private String image;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor for inserting new vehicle
    public Vehicle(String vehicleName, String vehicleType, int totalSeats,
                   String vehicleDescription, double pricePerDay) {
        this.vehicleName = vehicleName;
        this.vehicleType = vehicleType;
        this.totalSeats = totalSeats;
        this.vehicleDescription = vehicleDescription;
        this.pricePerDay = pricePerDay;
    }


    // Constructor for reading data from database
    public Vehicle(int vehicleId, String vehicleName, String vehicleType,
                   int totalSeats, String vehicleDescription, double pricePerDay,
                   String image, Timestamp createdAt, Timestamp updatedAt) {
        this.vehicleId = vehicleId;
        this.vehicleName = vehicleName;
        this.vehicleType = vehicleType;
        this.totalSeats = totalSeats;
        this.vehicleDescription = vehicleDescription;
        this.pricePerDay = pricePerDay;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getVehicleName() {
        return vehicleName;
    }

    public void setVehicleName(String vehicleName) {
        this.vehicleName = vehicleName;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }

    public String getVehicleDescription() {
        return vehicleDescription;
    }

    public void setVehicleDescription(String vehicleDescription) {
        this.vehicleDescription = vehicleDescription;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public String getImage() { return image; }

    public void setImage(String image) { this.image = image; }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getWishlistId() { return wishlistId; }

    public void setWishlistId(int wishlistId) { this.wishlistId = wishlistId; }


    @Override
    public String toString() {
        return "Vehicle{" +
                "vehicleId=" + vehicleId +
                ", vehicleName='" + vehicleName + '\'' +
                ", vehicleType='" + vehicleType + '\'' +
                ", totalSeats=" + totalSeats +
                ", vehicleDescription='" + vehicleDescription + '\'' +
                ", pricePerDay=" + pricePerDay +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}