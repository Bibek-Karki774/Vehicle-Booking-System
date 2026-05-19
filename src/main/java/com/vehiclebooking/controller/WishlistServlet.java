package com.vehiclebooking.controller;

import com.vehiclebooking.dao.WishlistDaoImpl;
import com.vehiclebooking.dao.VehicleDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.entity.Vehicle;
import com.vehiclebooking.entity.Wishlist;
import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private final WishlistDaoImpl wishlistDao = new WishlistDaoImpl();
    private final VehicleDaoImpl vehicleDao = new VehicleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");


        ArrayList<Wishlist> wishlistItems = wishlistDao.fetchWishlistByUserId(user.getUserId());

        ArrayList<Vehicle> wishlistVehicles = new ArrayList<>();
        for (Wishlist item : wishlistItems) {
            Vehicle v = vehicleDao.getVehicleById(item.getVehicleId());
            if (v != null) {
                v.setWishlistId(item.getWishlistId());
                wishlistVehicles.add(v);
            }
        }

        request.setAttribute("wishlistVehicles", wishlistVehicles);
        request.setAttribute("wishlistCount", wishlistVehicles.size());

        // Read booking error from session and clearing it
        if (SessionUtil.getAttribute(request, "bookingError") != null) {

            request.setAttribute("bookingError",
                    SessionUtil.getAttribute(request, "bookingError"));

            request.setAttribute("availableDates",
                    SessionUtil.getAttribute(request, "availableDates"));

            request.setAttribute("bookedVehicleId",
                    SessionUtil.getAttribute(request, "bookedVehicleId"));

            SessionUtil.removeAttribute(request, "bookingError");
            SessionUtil.removeAttribute(request, "availableDates");
            SessionUtil.removeAttribute(request, "bookedVehicleId");
        }

        request.getRequestDispatcher("/WEB-INF/views/wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        String action = request.getParameter("action");

        // Perform wishlist operations according to action
        if ("toggle".equals(action)) {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            wishlistDao.toggleWishlist(user.getUserId(), vehicleId);
            response.sendRedirect(request.getContextPath() + "/vehicles");

        }  else if ("remove".equals(action)) {
            int wishlistId = Integer.parseInt(request.getParameter("wishlistId"));
            wishlistDao.deleteWishlist(wishlistId);
            response.sendRedirect(request.getContextPath() + "/wishlist");

        } else if ("clear".equals(action)) {
            wishlistDao.deleteAllByUserId(user.getUserId());
            response.sendRedirect(request.getContextPath() + "/wishlist");
        }
    }
}