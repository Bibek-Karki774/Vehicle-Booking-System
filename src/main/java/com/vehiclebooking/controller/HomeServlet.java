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


@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private final VehicleDao vehicleDao = new VehicleDaoImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Vehicle> vehicles = vehicleDao.getAllVehicles();
        System.out.println("Vehicles size: " + vehicles.size());
        request.setAttribute("vehicles", vehicles);
            request.getRequestDispatcher("/WEB-INF/views/index.jsp")
                    .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
