package com.vehiclebooking.controller;

import com.vehiclebooking.dao.VehicleDao;
import com.vehiclebooking.dao.VehicleDaoImpl;
import com.vehiclebooking.dao.WishlistDao;
import com.vehiclebooking.dao.WishlistDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.entity.Vehicle;
import com.vehiclebooking.entity.Wishlist;
import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/vehicles")
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

            ArrayList<Vehicle> vehicles;

            if (keyword != null && !keyword.trim().isEmpty()) {
                vehicles = vehicleDAO.searchVehicles(keyword.trim());
                request.setAttribute("keyword", keyword.trim());
            } else {
                vehicles = vehicleDAO.getAllVehicles();
            }

            request.setAttribute("vehicles", vehicles);
            request.setAttribute("totalVehicles", vehicles.size());



            if (user != null && "Member".equals(user.getRole())) {
                WishlistDao wishlistDao = new WishlistDaoImpl();
                ArrayList<Wishlist> items = wishlistDao.fetchWishlistByUserId(user.getUserId());
                ArrayList<Integer> wishlistVehicleIds = new ArrayList<>();
                for (Wishlist w : items) {
                    wishlistVehicleIds.add(w.getVehicleId());
                }
                request.setAttribute("wishlistVehicleIds", wishlistVehicleIds);
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

        // Admin actions
        if ("Admin".equals(user.getRole())) {
            if ("add".equals(action)) {
                String name  = request.getParameter("vehicleName");
                String type  = request.getParameter("vehicleType");
                int    seats = Integer.parseInt(request.getParameter("totalSeats"));
                String desc  = request.getParameter("vehicleDescription");
                double price = Double.parseDouble(request.getParameter("pricePerDay"));

                Vehicle vehicle = new Vehicle(name, type, seats, desc, price);
                vehicleDAO.insertVehicle(vehicle);

            } else if ("edit".equals(action)) {
                int    id    = Integer.parseInt(request.getParameter("vehicleId"));
                String name  = request.getParameter("vehicleName");
                String type  = request.getParameter("vehicleType");
                int    seats = Integer.parseInt(request.getParameter("totalSeats"));
                String desc  = request.getParameter("vehicleDescription");
                double price = Double.parseDouble(request.getParameter("pricePerDay"));

                Vehicle vehicle = new Vehicle(name, type, seats, desc, price);
                vehicleDAO.updateVehicle(id, vehicle);

            } else if ("delete".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                vehicleDAO.deleteVehicle(vehicleId);
            }


        }

        response.sendRedirect(request.getContextPath() + "/vehicles");
    }
}
