package com.vehiclebooking.controller;

import com.vehiclebooking.dao.UserDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.PasswordUtil;
import com.vehiclebooking.utils.SessionUtil;
import com.vehiclebooking.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get current password from the form input
        String currentPassword = request.getParameter("currentPassword");
        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        StringBuilder errors = new StringBuilder();

        // Validate the input fields
        if (ValidationUtil.isNullOrEmpty(currentPassword) ||
                ValidationUtil.isNullOrEmpty(newPassword) ||
                ValidationUtil.isNullOrEmpty(confirmPassword)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp")
                    .forward(request, response);
            return;
        }

        if (!PasswordUtil.checkPassword(currentPassword.trim(), user.getPassword())) {
            errors.append("Current password is incorrect. ");
        }

        if (currentPassword.trim().equals(newPassword.trim())) {
            errors.append("New password cannot be the same as current password. ");
        }

        if (!ValidationUtil.isValidPassword(newPassword)) {
            errors.append("New password must be at least 8 characters, include 1 uppercase, 1 number, and 1 special character. ");
        }

        if (!ValidationUtil.doPasswordsMatch(newPassword, confirmPassword)) {
            errors.append("New password and confirm password do not match. ");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("error", errors.toString().trim());
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp")
                    .forward(request, response);
            return;
        }

        UserDaoImpl userDao = new UserDaoImpl();
        String hashedNewPassword = PasswordUtil.getHashPassword(newPassword.trim());
        boolean updated = userDao.updatePassword(user.getUserId(), hashedNewPassword);

        if (updated) {
            SessionUtil.removeAttribute(request, "user");
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login?passwordChanged=true");
            return;
        }

        request.setAttribute("error", "Failed to update password. Please try again.");
        request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp")
                .forward(request, response);
    }
}