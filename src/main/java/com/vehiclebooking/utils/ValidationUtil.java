package com.vehiclebooking.utils;

import java.util.regex.Pattern;

/**
 * Utility class provides common validation methods for user input.
 * <p>
 * This class includes methods for validating user inputs such as,
 * username, password, email, driving license.
 * </p>
 */

public class ValidationUtil {

    /**
     * This isNullOrEmpty() method checks if a value is null or empty.
     * @param value is the string to check
     * @return true if the value is null or empty, else false
     */
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }


    /**
     * It checks if a string starts with a letter and is alphanumeric.
     * @param value the string to check
     * @return true if email is valid, else false
     */
    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }


    /**
     * Checks if an email address is in valid format.
     * @param email is the email needed to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }


    /**
     * isValidPassword() checks if password meets the requirement or not.
     * The password should contain at least 8 characters, 1 uppercase,
     * 1 number, 1 special character.
     * @param password the password to validate
     * @return true if the password meets requirement, else false
     */
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }


    /**
     * doPasswordMatch() method checks if password and confirm password match.
     * @param password is the original password typed by the user.
     * @param retypePassword is the retyped password by the user.
     * @return true if both matches, else false
     */
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    /**
     * This method checks if a driving license matches the format: XX-XX-XXXXXXXX
     * @param drivingLicense is the license provided by user to validate.
     * @return true if license is in valid format, else false.
     */
    public static boolean isValidLicense(String drivingLicense) {
        String regex = "^\\d{2}-\\d{2}-\\d{8}$";
        return drivingLicense != null && drivingLicense.matches(regex);
    }
}
