package com.vehiclebooking.controller;

import com.vehiclebooking.dao.VehicleDao;
import com.vehiclebooking.dao.VehicleDaoImpl;
import com.vehiclebooking.dao.WishlistDao;
import com.vehiclebooking.dao.WishlistDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.entity.Vehicle;
import com.vehiclebooking.entity.Wishlist;
import com.vehiclebooking.utils.ImageUtil;
import com.vehiclebooking.utils.SessionUtil;
import com.vehiclebooking.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet for managing vehicle operations in the Vehicle Booking System.
 * This controller handles displaying, searching, filtering, adding, editing,
 * and deleting vehicle records. It also manages role-based access control,
 * allowing only admin users to perform vehicle management operations.
 * Additionally, it integrates wishlist data for members, handles booking
 * error messages via session, and manages vehicle image upload and deletion.
 * The servlet acts as the central controller for all vehicle-related features.
 */
@WebServlet("/vehicles")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize       = 1024 * 1024 * 10,
        maxRequestSize    = 1024 * 1024 * 50
)
public class VehicleServlet extends HttpServlet {

    private final VehicleDao vehicleDAO = new VehicleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        String action = request.getParameter("action");


        if ("add".equals(action)) {
            if (!"Admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/vehicles");
                return;
            }
            request.getRequestDispatcher("/WEB-INF/views/vehicle-add-edit.jsp")
                    .forward(request, response);
        }
        else if ("edit".equals(action)) {
            if (!"Admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/vehicles");
                return;
            }
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
            request.setAttribute("vehicle", vehicle);
            request.getRequestDispatcher("/WEB-INF/views/vehicle-add-edit.jsp")
                    .forward(request, response);
        }
        else {
            // Search or show all
            String keyword = request.getParameter("search");
            String type = request.getParameter("type");

            ArrayList<Vehicle> vehicles;

            // Search vehicles by given keyword, type, else show all vehicles.
            if (keyword != null && !keyword.trim().isEmpty()) {
                vehicles = vehicleDAO.searchVehicles(keyword.trim());
                request.setAttribute("keyword", keyword.trim());
            } else if (type != null && !type.trim().isEmpty()) {
                vehicles = vehicleDAO.filterByType(type.trim());
            } else {
                vehicles = vehicleDAO.getAllVehicles();
            }

            // Set request attributes to pass data
            request.setAttribute("vehicles", vehicles);
            request.setAttribute("totalVehicles", vehicles.size());
            request.setAttribute("vehicleTypes",vehicleDAO.getDistinctVehicleTypes());
            request.setAttribute("selectedType", type);


            // Fetch all the vehicles of logged-in user for wishlist
            if (user != null && "Member".equals(user.getRole())) {
                WishlistDao wishlistDao = new WishlistDaoImpl();
                ArrayList<Wishlist> items = wishlistDao.fetchWishlistByUserId(user.getUserId());
                ArrayList<Integer> wishlistVehicleIds = new ArrayList<>();
                for (Wishlist w : items) {
                    wishlistVehicleIds.add(w.getVehicleId());
                }
                request.setAttribute("wishlistVehicleIds", wishlistVehicleIds);
            }

            // Read booking error from session and clearing it
            if (SessionUtil.getAttribute(request, "bookingError") != null) {

                request.setAttribute("bookingError",
                        SessionUtil.getAttribute(request, "bookingError"));

                request.setAttribute("availableDates",
                        SessionUtil.getAttribute(request, "availableDates"));

                request.setAttribute("bookedVehicleId",
                        SessionUtil.getAttribute(request, "bookedVehicleId"));

                SessionUtil.removeAttribute(request, "bookingError");
                SessionUtil.removeAttribute(request, "availableDates");
                SessionUtil.removeAttribute(request, "bookedVehicleId");
            }

            request.getRequestDispatcher("/WEB-INF/views/vehicles.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        String action = request.getParameter("action");

        if ("Admin".equals(user.getRole())) {
            if ("add".equals(action)) {
                String name  = request.getParameter("vehicleName");
                String type  = request.getParameter("vehicleType");
                String seats = request.getParameter("totalSeats");
                String desc  = request.getParameter("vehicleDescription");
                String price = request.getParameter("pricePerDay");

                StringBuilder errors = new StringBuilder();

                // Validate fields
                if (ValidationUtil.isNullOrEmpty(name)) {
                    errors.append("Vehicle name is required. ");
                }
                if (ValidationUtil.isNullOrEmpty(type)) {
                    errors.append("Vehicle type is required. ");
                }
                if (ValidationUtil.isNullOrEmpty(seats)) {
                    errors.append("Total seats is required. ");
                } else {
                    try {
                        int seatsInt = Integer.parseInt(seats);
                        if (seatsInt <= 0) {
                            errors.append("Total seats must be greater than 0. ");
                        }
                    } catch (NumberFormatException e) {
                        errors.append("Total seats must be a valid number. ");
                    }
                }
                if (ValidationUtil.isNullOrEmpty(price)) {
                    errors.append("Price per day is required. ");
                } else {
                    try {
                        double priceDouble = Double.parseDouble(price);
                        if (priceDouble <= 0) {
                            errors.append("Price must be greater than 0. ");
                        }
                    } catch (NumberFormatException e) {
                        errors.append("Price must be a valid number. ");
                    }
                }

                if (ValidationUtil.isNullOrEmpty(desc)) {
                    errors.append("Vehicle description is required. ");
                }

                if (!errors.isEmpty()) {
                    request.setAttribute("error", errors.toString().trim());
                    request.getRequestDispatcher("/WEB-INF/views/vehicle-add-edit.jsp")
                            .forward(request, response);
                    return;
                }


                // Get uploaded image
                Part imagePart = request.getPart("image");
                String imageName = ImageUtil.uploadImage(imagePart);


                Vehicle vehicle = new Vehicle(name, type, Integer.parseInt(seats), desc, Double.parseDouble(price));
                vehicle.setImage(imageName);
                vehicleDAO.insertVehicle(vehicle);

            } else if ("edit".equals(action)) {
                int    id    = Integer.parseInt(request.getParameter("vehicleId"));
                String name  = request.getParameter("vehicleName");
                String type  = request.getParameter("vehicleType");
                String seats = request.getParameter("totalSeats");
                String desc  = request.getParameter("vehicleDescription");
                String price = request.getParameter("pricePerDay");

                StringBuilder errors = new StringBuilder();

                // Check if any fields are left empty
                if (ValidationUtil.isNullOrEmpty(name)) {
                    errors.append("Vehicle name is required. ");
                }
                if (ValidationUtil.isNullOrEmpty(type)) {
                    errors.append("Vehicle type is required. ");
                }
                if (ValidationUtil.isNullOrEmpty(seats)) {
                    errors.append("Total seats is required. ");
                } else {
                    try {
                        int seatsInt = Integer.parseInt(seats);
                        if (seatsInt <= 0) {
                            errors.append("Total seats must be greater than 0. ");
                        }
                    } catch (NumberFormatException e) {
                        errors.append("Total seats must be a valid number. ");
                    }
                }
                if (ValidationUtil.isNullOrEmpty(price)) {
                    errors.append("Price per day is required. ");
                } else {
                    try {
                        double priceDouble = Double.parseDouble(price);
                        if (priceDouble <= 0) {
                            errors.append("Price must be greater than 0. ");
                        }
                    } catch (NumberFormatException e) {
                        errors.append("Price must be a valid number. ");
                    }
                }

                if (ValidationUtil.isNullOrEmpty(desc)) {
                    errors.append("Vehicle description is required. ");
                }

                if (!errors.isEmpty()) {
                    Vehicle existing = vehicleDAO.getVehicleById(id);
                    request.setAttribute("vehicle", existing);
                    request.setAttribute("error", errors.toString().trim());
                    request.getRequestDispatcher("/WEB-INF/views/vehicle-add-edit.jsp")
                            .forward(request, response);
                    return;
                }

                Vehicle existing = vehicleDAO.getVehicleById(id);
                // Get uploaded image from request
                Part imagePart = request.getPart("image");
                String imageName = ImageUtil.uploadImage(imagePart);

                // Delete old image
                if (imageName != null) {
                    ImageUtil.deleteImage(existing.getImage());
                } else {
                    // No new image uploaded, then keep existing
                    imageName = existing.getImage();
                }

                Vehicle vehicle = new Vehicle(name, type, Integer.parseInt(seats), desc, Double.parseDouble(price));
                vehicle.setImage(imageName);
                vehicleDAO.updateVehicle(id, vehicle);

            } else if ("delete".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));

                // delete image from disk when vehicle is deleted
                Vehicle existing = vehicleDAO.getVehicleById(vehicleId);
                if (existing != null) {
                    ImageUtil.deleteImage(existing.getImage());
                }
                vehicleDAO.deleteVehicle(vehicleId);
            }

        }

        response.sendRedirect(request.getContextPath() + "/vehicles");
    }
}
