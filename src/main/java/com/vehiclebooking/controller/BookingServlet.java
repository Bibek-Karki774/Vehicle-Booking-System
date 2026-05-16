package com.vehiclebooking.controller;

import com.vehiclebooking.dao.BookingDaoImpl;
import com.vehiclebooking.dao.VehicleDaoImpl;
import com.vehiclebooking.dao.WishlistDaoImpl;
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
import java.sql.Timestamp;
import java.util.ArrayList;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private BookingDaoImpl bookingDAO = new BookingDaoImpl();
    private VehicleDaoImpl vehicleDAO = new VehicleDaoImpl();
    private WishlistDaoImpl wishlistDAO = new WishlistDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/vehicles");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Modal submitted and then go to payment page
        if (action == null || action.equals("review")) {
            int vehicleId   = Integer.parseInt(request.getParameter("vehicleId"));
            String fromDate = request.getParameter("fromDate");
            String toDate   = request.getParameter("toDate");

            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
            Timestamp start = Timestamp.valueOf(fromDate + " 00:00:00");
            Timestamp end   = Timestamp.valueOf(toDate   + " 00:00:00");

            // Calculate number of days
            long days = (end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24);
            if (days <= 0) days = 1;
            double totalAmount = days * vehicle.getPricePerDay();

            // Validate that date must be between 1 and 7 days
            if (days < 1 || days > 7) {
                response.sendRedirect(request.getContextPath() + "/vehicles?error=invalid_dates");
                return;
            }


            // ── CHANGED: use session + redirect instead of forward ──
            boolean isBooked = bookingDAO.isVehicleBooked(vehicleId, start, end);
            if (isBooked) {
                ArrayList<String> availableDates = bookingDAO.getAvailableDatesThisWeek(vehicleId);
                String origin = request.getParameter("origin");

                SessionUtil.setAttribute(request, "availableDates", availableDates);
                SessionUtil.setAttribute(request, "bookingError", "already_booked");
                SessionUtil.setAttribute(request, "bookedVehicleId", vehicleId);

                // Redirect back to origin page
                if ("wishlist".equals(origin)) {
                    response.sendRedirect(request.getContextPath() + "/wishlist");
                } else {
                    response.sendRedirect(request.getContextPath() + "/vehicles");
                }
                return;
            }
// ── END CHANGED ──


            request.setAttribute("vehicleId",   vehicleId);
            request.setAttribute("fromDate",    fromDate);
            request.setAttribute("toDate",      toDate);
            request.setAttribute("days",        days);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);

            // Payment Successful
        } else if (action.equals("confirm")) {
            int vehicleId      = Integer.parseInt(request.getParameter("vehicleId"));
            String fromDate    = request.getParameter("fromDate");
            String toDate      = request.getParameter("toDate");
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

            User user  = (User) request.getSession().getAttribute("user");
            int userId = user.getUserId();

            Timestamp startDate = Timestamp.valueOf(fromDate + " 00:00:00");
            Timestamp endDate   = Timestamp.valueOf(toDate   + " 00:00:00");

            Booking booking = new Booking(userId, vehicleId, totalAmount, startDate, endDate);
            bookingDAO.addBooking(booking);

            wishlistDAO.deleteByUserIdAndVehicleId(userId, vehicleId);
            response.sendRedirect(request.getContextPath() + "/vehicles?booked=true");

        }
    }
}