package com.vehiclebooking.utils;

import org.mindrot.jbcrypt.BCrypt;


/**
 * It is a utility class which hashes the password using BCrypt.
 * <p>
 * It provides the methods to securely hash plain-text passwords
 * and also verify a plain-text password against a hashed password.
 * </p>
 */
public class PasswordUtil {


    private static final int COST = 10;

    /**
     * It generates the secure hashed password using BCrypt.
     * @param inputPassword is the plain-text password to hash provided by user.
     * @return the hashed password
     */
    public static String getHashPassword(String inputPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(inputPassword, salt);
    }

    /**
     * It checks whether password provided by user matches the stored hashed password.
     * @param passwordTyped the password entered by the user
     * @param hashedPassword the stored hashed password
     * @return true if the password matches, else false
     */
    public static boolean checkPassword(String passwordTyped, String hashedPassword) {
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }

}
