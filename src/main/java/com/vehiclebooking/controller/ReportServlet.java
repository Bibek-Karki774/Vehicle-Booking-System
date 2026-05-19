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

@WebServlet("/adminReport")
public class ReportServlet extends HttpServlet {

    private final BookingDao bookingDAO = new BookingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Sets 7days by default if no range selected
        String range = request.getParameter("range");
        if (range == null || range.isEmpty()) range = "7d";

        // Get top5 most booked vehicles for selected time range
        ArrayList<Booking> top5Vehicles = bookingDAO.getTop5BookedVehicles(range);

        request.setAttribute("top5Vehicles", top5Vehicles);
        request.setAttribute("selectedRange", range);

        request.getRequestDispatcher("/WEB-INF/views/report.jsp")
                .forward(request, response);
    }
}