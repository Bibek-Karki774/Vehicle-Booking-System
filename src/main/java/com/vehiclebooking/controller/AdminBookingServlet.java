package com.vehiclebooking.controller;

import com.vehiclebooking.dao.BookingDaoImpl;
import com.vehiclebooking.entity.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet for admin booking management.
 * This servlet handles the retrieval and display of all booking records
 * for the admin dashboard. It also supports search functionality and
 * calculates total revenue from bookings.
 */
@WebServlet("/adminBooking")
public class AdminBookingServlet extends HttpServlet {

    private final BookingDaoImpl bookingDao = new BookingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        ArrayList<Booking> bookings;

        // Show searched bookings, otherwise show all bookings
        if (search != null && !search.trim().isEmpty()) {
            bookings = bookingDao.searchBookings(search.trim());
            request.setAttribute("search", search.trim());
        } else {
            bookings = bookingDao.getAllBookings();
        }

        // Calculate total revenue
        double totalRevenue = 0;
        for (Booking booking : bookings) {
            totalRevenue += booking.getTotalAmount();
        }

        request.setAttribute("bookings", bookings);
        request.setAttribute("totalBookings", bookings.size());
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/WEB-INF/views/adminBooking.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}