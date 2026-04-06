package com.vehiclebooking.entity;

import java.sql.Timestamp;

public class User {
    // Private attributes of users
    private int userId;
    private String userName;
    private String password;
    private String phone;
    private String address;
    private String drivingLicense;
    private String email;
    private String role;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor for registration
    public User(String userName, String password, String phone, String address,
                String drivingLicense, String email) {
        this.userName = userName;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.drivingLicense = drivingLicense;
        this.email = email;
        this.role = "Member";
    }

    // Constructor for reading database
    public User(int userId, String userName, String password, String phone,
                String address, String drivingLicense, String email,
                Timestamp createdAt, Timestamp updatedAt) {

        this.userId = userId;
        this.userName = userName;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.drivingLicense = drivingLicense;
        this.email = email;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;

    }

    // Getter and Setter methods
    public int getUserId() {
        return userId;
    }
    public String getUserName(){
        return userName;
    }
    public String getPassword(){
        return password;
    }
    public String getPhone(){
        return phone;
    }
    public String getAddress(){
        return address;
    }
    public String getDrivingLicense(){
        return drivingLicense;
    }
    public String getEmail(){
        return email;
    }
    public String getRole(){
        return role;
    }
    public Timestamp getCreatedAt(){
        return createdAt;
    }
    public Timestamp getUpdatedAt(){
        return updatedAt;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString(){
        return "[" + userId + "] " + userName + " (" + email + ") - " + phone + ", " + address + ", Driving License: " + drivingLicense;
    }
}
