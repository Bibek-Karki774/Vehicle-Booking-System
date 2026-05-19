package com.vehiclebooking.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

/**
 * This utility class is for handling image file uploads.
 * <p>Provides methods to upload image files to an external
 * folder and delete previously uploaded images.
 * Supported formats: JPG, JPEG, PNG.</p>
 * <p>Files are stored in outside the project.
 * Because they persist across {@code mvn clean} rebuilds.</p>
 */
public class ImageUtil {

    /**
     * Saves an uploaded image file to the external uploads folder.
     * @param imagePart the file part from the multipart form submission
     * @return the filename (e.g., "2026-05-18_user.jpg"),
     * and returns null if the file is invalid or the upload fails
     */
    public static String uploadImage(Part imagePart) {
        // Get the name of the image uploeded by user
        String fileName = imagePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Check if user have uploaded image with correct extension
        String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".png")) {
            return null;
        }

        // Create unique name of image using date and time, and also filename
        String uniqueName = LocalDateTime.now().toString().replace(":", "-") + "_" + fileName;

        //Create a folder path to store images
        String uploadPath = System.getProperty("user.home") + File.separator + "vehicle-booking-system-uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Upload the image file to the folder
        try {
            // Return full relative path
            imagePart.write(uploadPath + File.separator + uniqueName);
            return "uploads/" + uniqueName;
        } catch (IOException e) {
            System.out.println("Error uploading image: " + e.getMessage());
            return null;
        }
    }

    /**
     * Deletes a previously uploaded image file from the external folder.
     *
     * <p>Safely skips deletion if the path is null, empty, or points
     * to the default fallback image (static/image/book.png).</p>
     *
     * @param imagePath the filename of the image to delete
     */
    public static void deleteImage(String imagePath){
        if(imagePath == null || imagePath.isEmpty()){
            return;
        }
        if (imagePath.startsWith("static/")) {
            return;
        }
        // Get the file name and set the folder where the image will be saved
        String fileName = imagePath.replace("uploads/", "");
        String uploadPath = System.getProperty("user.home") + File.separator + "vehicle-booking-system-uploads";
        File file = new File(uploadPath + File.separator + fileName);
        if (file.exists()) {
            file.delete();
        }
    }
}
