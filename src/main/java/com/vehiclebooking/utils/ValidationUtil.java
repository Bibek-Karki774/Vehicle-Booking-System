package com.vehiclebooking.utils;

import java.util.regex.Pattern;

public class ValidationUtil {


     // Check if a value is null or empty.

    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }


     /*
        Check if a string starts with a letter and contains only
        letters and numbers (alphanumeric).
      */

    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }



      // Check if a string is a valid email format.

    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }


    /*
        Check if a password meets strength requirements:
        At least 8 characters
        At least 1 uppercase letter
        At least 1 number
        At least 1 symbol (@$!%*?&)
     */
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }



      // Check if password and confirm password match.

    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    // Check if driving license format is correct
    public static boolean isValidLicense(String drivingLicense) {
        String regex = "^\\d{2}-\\d{2}-\\d{8}$";
        return drivingLicense != null && drivingLicense.matches(regex);
    }
}
