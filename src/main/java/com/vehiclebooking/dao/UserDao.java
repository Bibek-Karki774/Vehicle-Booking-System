package com.vehiclebooking.dao;

import com.vehiclebooking.entity.User;

import java.util.ArrayList;

public interface UserDao {
    boolean insertUser(User user);
    User findByUsername(String username);
    User findByEmail(String email);
    ArrayList<User> getPendingUsers();
    boolean approveUser(int userId);
    boolean rejectUser(int userId);
    ArrayList<User> getAllUsers();
}
