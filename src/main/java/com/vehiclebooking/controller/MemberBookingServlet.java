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
import java.util.List;

@WebServlet("/my-bookings")
public class MemberBookingServlet extends HttpServlet {

    private final BookingDao bookingDAO = new BookingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(req, "user");

        List<Booking> bookings = bookingDAO.getBookingsByUserId(user.getUserId());

        double totalSpent = bookings.stream()
                .mapToDouble(Booking::getTotalAmount)
                .sum();

        req.setAttribute("bookings", bookings);
        req.setAttribute("totalBookings", bookings.size());
        req.setAttribute("totalSpent", totalSpent);

        req.getRequestDispatcher("/WEB-INF/views/member-bookings.jsp")
                .forward(req, res);
    }
}