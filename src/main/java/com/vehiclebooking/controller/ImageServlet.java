package com.vehiclebooking.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

/**
 * Serves uploaded images from the external uploads folder.
 * <p>Maps to /uploads/* so that images stored in
 * external folder are accessible via URL.
 * For example: /uploads/2026-05-18_cat.jpg</p>
 */
@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        /* Get the file name from url and if no
        file name provided then return error */
        String filename = request.getPathInfo();
        if (filename == null || filename.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Remove leading slash
        filename = filename.substring(1);

        String uploadPath = System.getProperty("user.home") + File.separator + "vehicle-booking-system-uploads";
        File file = new File(uploadPath, filename);

        // Check if file exists
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Security check: ensure the file is inside the uploads folder
        if (!file.getCanonicalPath().startsWith(new File(uploadPath).getCanonicalPath())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Detect the file type and set content type for browser
        String contentType = Files.probeContentType(file.toPath());
        if (contentType != null) {
            response.setContentType(contentType);
        }

        response.setContentLengthLong(file.length());

        // Send the file to browser
        try (OutputStream out = response.getOutputStream()) {
            Files.copy(file.toPath(), out);
        }
    }
}
