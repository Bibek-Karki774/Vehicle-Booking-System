package com.vehiclebooking.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {


    private static final int COST = 10;

    public static String getHashPassword(String inputPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(inputPassword, salt);
    }

    public static boolean checkPassword(String passwordTyped, String hashedPassword) {
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }

    // Main method just to hash password for admin
    public static void main(String[] args) {
        String password = "admin@123";
        String hashed = PasswordUtil.getHashPassword(password);
        System.out.println("Hashed Password for admin: " + hashed);
    }
}
