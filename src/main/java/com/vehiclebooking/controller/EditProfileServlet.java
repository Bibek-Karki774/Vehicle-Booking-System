package com.vehiclebooking.controller;

import com.vehiclebooking.dao.UserDao;
import com.vehiclebooking.dao.UserDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.SessionUtil;
import com.vehiclebooking.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {
    UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String success = (String) SessionUtil.getAttribute(request, "success");
        if (success != null) {
            request.setAttribute("success", success);
            SessionUtil.removeAttribute(request, "success");
        }

        request.getRequestDispatcher("/WEB-INF/views/editProfile.jsp")
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

        String userName = request.getParameter("userName");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String address    = request.getParameter("address");



        StringBuilder errors = new StringBuilder();

        // Check if user's previous data and new data are same
        boolean sameUserName = user.getUserName().equals(userName.trim());
        boolean samePhone    = user.getPhone().equals(phone.trim());
        boolean sameEmail    = user.getEmail().equals(email.trim());
        boolean sameAddress  = user.getAddress().equals(address.trim());

        if (sameUserName && samePhone && sameEmail && sameAddress) {
            errors.append("No changes detected. Please update at least one field.");
        }

        if (ValidationUtil.isNullOrEmpty(userName) ||
                ValidationUtil.isNullOrEmpty(email) ||
                ValidationUtil.isNullOrEmpty(phone) ||
                ValidationUtil.isNullOrEmpty(address)) {

            errors.append("All fields are required. ");
        }

        if (!ValidationUtil.isAlphanumericStartingWithLetter(userName)
                || userName.length() < 5) {
            errors.append("Username must be alphanumeric, start with a letter, and be at least 5 characters. ");
        }




        if (!ValidationUtil.isValidEmail(email)) {
            errors.append("Invalid email format. ");
        }



        if (!errors.isEmpty()) {
            request.setAttribute("error", errors.toString().trim());
            request.getRequestDispatcher("/WEB-INF/views/editProfile.jsp")
                    .forward(request, response);
            return;
        }


        user.setUserName(userName.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        user.setAddress(address.trim());

        // update in database
        boolean updated = userDao.updateUser(user);

        if (updated) {
            //Update session
            SessionUtil.setAttribute(request, "user", user);
            SessionUtil.setAttribute(request, "success", "Profile updated successfully");
            response.sendRedirect(request.getContextPath() + "/editProfile");
            return;
        }

            request.setAttribute("error", "Failed to update profile. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/editProfile.jsp").forward(request, response);
    }
}
