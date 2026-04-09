package com.vehiclebooking.dao;

import com.vehiclebooking.entity.User;

public interface UserDao {
    boolean insertUser(User user);
    User findByUsername(String username);
    User findByEmail(String email);
}
