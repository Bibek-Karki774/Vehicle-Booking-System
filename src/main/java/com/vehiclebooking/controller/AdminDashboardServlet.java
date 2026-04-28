package com.vehiclebooking.controller;

import com.vehiclebooking.dao.*;
import com.vehiclebooking.entity.Booking;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.entity.Vehicle;
import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDao userDAO = new UserDaoImpl();
    private final VehicleDao vehicleDAO = new VehicleDaoImpl();
    private final BookingDao bookingDAO = new BookingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        // Session check
        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get stats for admin dashboard
        ArrayList<User> users = userDAO.getAllUsers();
        ArrayList<Vehicle> vehicles = vehicleDAO.getAllVehicles();
        ArrayList<Booking> bookings = bookingDAO.getAllBookings();
        double revenue = bookingDAO.getTotalRevenue();

        request.setAttribute("totalUsers", users.size());
        request.setAttribute("totalVehicles", vehicles.size());
        request.setAttribute("totalBookings", bookings.size());
        request.setAttribute("totalRevenue", revenue);


        // Get pending users
        ArrayList<User> pendingUsers = userDAO.getPendingUsers();

        request.setAttribute("pendingUsers", pendingUsers);


        request.getRequestDispatcher("/WEB-INF/views/adminDashboard.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if ("approve".equals(action)) {
            userDAO.approveUser(userId);
        } else if ("reject".equals(action)) {
            userDAO.rejectUser(userId);
        }

        response.sendRedirect(request.getContextPath() + "/adminDashboard");

    }
}
