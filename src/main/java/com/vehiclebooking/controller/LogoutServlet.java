package com.vehiclebooking.controller;

import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet for handling user logout functionality in the Vehicle Booking System.
 * This controller invalidates the current user session, effectively logging
 * the user out of the system. After session destruction, the user is redirected
 * to the login page to ensure re-authentication for further access.
 * It helps maintain application security by clearing all session data.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Clears the session and redirects to login page
        SessionUtil.invalidateSession(request);
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
