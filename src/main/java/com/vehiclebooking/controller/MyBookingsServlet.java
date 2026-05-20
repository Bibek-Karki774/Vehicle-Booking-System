package com.vehiclebooking.controller;

import com.vehiclebooking.dao.BookingDao;
import com.vehiclebooking.dao.BookingDaoImpl;
import com.vehiclebooking.entity.Booking;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet for displaying logged-in user's booking history in the Vehicle Booking System.
 * This controller retrieves all bookings made by the current user and calculates
 * summary information such as total bookings and total amount spent. The data is
 * then forwarded to the user bookings page for display.
 * It allows users to view their past and active bookings in a consolidated view.
 */
@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

    private final BookingDao bookingDAO = new BookingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        ArrayList<Booking> bookings = bookingDAO.getBookingsByUserId(user.getUserId());

        //Calculate total amount of booking
        double totalSpent = 0;
        for (Booking b : bookings) {
            totalSpent += b.getTotalAmount();
        }

        totalSpent = Math.round(totalSpent * 100.0) / 100.0;

        request.setAttribute("totalSpent", totalSpent);
        request.setAttribute("bookings", bookings);
        request.setAttribute("totalBookings", bookings.size());

        request.getRequestDispatcher("/WEB-INF/views/member-bookings.jsp")
                .forward(request, res);
    }
}