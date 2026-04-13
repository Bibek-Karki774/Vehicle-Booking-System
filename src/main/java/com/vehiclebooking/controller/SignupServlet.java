package com.vehiclebooking.controller;

import com.vehiclebooking.dao.UserDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.PasswordUtil;
import com.vehiclebooking.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private UserDaoImpl userDao = new UserDaoImpl();

    //show signup page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/signup.jsp")
                .forward(request, response);
    }

    // Handle form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    // Get the form data
        String userName = request.getParameter("username");
        String email= request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String drivingLicense = request.getParameter("drivingLicense");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        StringBuilder errors = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(userName)
                || !ValidationUtil.isAlphanumericStartingWithLetter(userName)
                || userName.length() < 5) {
            errors.append("Username must be alphanumeric, start with a letter, and be at least 5 characters. ");
        }
        if (!ValidationUtil.isValidEmail(email)) {
            errors.append("Invalid email format. ");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            errors.append("Password must be 8+ characters with uppercase, number, and symbol. ");
        }
        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            errors.append("Passwords do not match. ");
        }
        if(!ValidationUtil.isValidLicense(drivingLicense)) {
            errors.append("Invalid driving license format. ");
        }


        if (!errors.isEmpty()) {
            request.setAttribute("error", errors.toString().trim());
            request.getRequestDispatcher("/WEB-INF/views/signup.jsp")
                    .forward(request, response);
            return;
        }

        String hashedPassword = PasswordUtil.getHashPassword(password);
        User user = new User(userName, hashedPassword, phone, address, drivingLicense, email);

        boolean success = userDao.insertUser(user);

        if (!success) {
            request.setAttribute("error", "Username or email already exists.");
            request.getRequestDispatcher("/WEB-INF/views/signup.jsp")
                    .forward(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
    }
