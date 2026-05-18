package com.vehiclebooking.entity;

import java.sql.Timestamp;

/**
 * This class represents wishlist in the vehicle booking system.
 * This class stores information about vehicles saved by users for future reference.
 * It links a user with a vehicle they are interested in and keeps track of
 * when the item was added to the wishlist.
 */
public class Wishlist {

    private int wishlistId;
    private int userId;
    private int vehicleId;
    private Timestamp addedDate;

    // Constructor for inserting new wishlist item
    public Wishlist(int userId, int vehicleId) {
        this.userId = userId;
        this.vehicleId = vehicleId;
    }


    // Constructor for reading data from database
    public Wishlist(int wishlistId, int customerId, int vehicleId, Timestamp addedDate) {
        this.wishlistId = wishlistId;
        this.userId = customerId;
        this.vehicleId = vehicleId;
        this.addedDate = addedDate;
    }


    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public Timestamp getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Timestamp addedDate) {
        this.addedDate = addedDate;
    }


    @Override
    public String toString() {
        return "Wishlist{" +
                "wishlistId=" + wishlistId +
                ", userId=" + userId +
                ", vehicleId=" + vehicleId +
                ", addedDate=" + addedDate +
                '}';
    }
}