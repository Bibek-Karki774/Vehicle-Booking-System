package com.vehiclebooking.entity;

import java.sql.Timestamp;

public class Vehicle {

    private int vehicleId;
    private String vehicleName;
    private String vehicleType;
    private int totalSeats;
    private String vehicleDescription;
    private double pricePerDay;
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
        // vehicleId, createdAt, updatedAt will be set by database
    }


    // Constructor for reading data from database
    public Vehicle(int vehicleId, String vehicleName, String vehicleType,
                   int totalSeats, String vehicleDescription, double pricePerDay,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.vehicleId = vehicleId;
        this.vehicleName = vehicleName;
        this.vehicleType = vehicleType;
        this.totalSeats = totalSeats;
        this.vehicleDescription = vehicleDescription;
        this.pricePerDay = pricePerDay;
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