package com.vehiclebooking.controller;

import com.vehiclebooking.dao.VehicleDao;
import com.vehiclebooking.dao.VehicleDaoImpl;
import com.vehiclebooking.entity.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet for handling the Home page of the Vehicle Booking System.
 * This controller retrieves all available vehicle data from the database
 * and forwards it to the home page for display. It serves as the entry
 * point of the application where users can view available vehicles.
 * It does not handle any form submissions or business operations, only
 * data retrieval and page navigation.
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private final VehicleDao vehicleDao = new VehicleDaoImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch vehicles and display in home page
        ArrayList<Vehicle> vehicles = vehicleDao.getAllVehicles();
        request.setAttribute("vehicles", vehicles);
            request.getRequestDispatcher("/WEB-INF/views/index.jsp")
                    .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
