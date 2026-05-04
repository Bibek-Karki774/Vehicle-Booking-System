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

@WebServlet("/adminBooking")
public class AdminBookingServlet extends HttpServlet {

    private final BookingDaoImpl bookingDao = new BookingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        ArrayList<Booking> bookings;

        if (search != null && !search.trim().isEmpty()) {
            bookings = bookingDao.searchBookings(search.trim());
            request.setAttribute("search", search.trim());
        } else {
            bookings = bookingDao.getAllBookings();
        }

        double totalRevenue = bookings.stream()
                .mapToDouble(Booking::getTotalAmount)
                .sum();

        request.setAttribute("bookings", bookings);
        request.setAttribute("totalBookings", bookings.size());
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/WEB-INF/views/adminBooking.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDao.deleteBookingById(bookingId);
        }
        response.sendRedirect(request.getContextPath() + "/adminBooking");
    }
}