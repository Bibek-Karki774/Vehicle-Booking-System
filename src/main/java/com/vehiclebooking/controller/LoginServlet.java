package com.vehiclebooking.controller;

import com.vehiclebooking.dao.UserDaoImpl;
import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.PasswordUtil;
import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDaoImpl userDao = new UserDaoImpl();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDao.findByUsername(username);

        if (user == null) {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        if ("Pending".equalsIgnoreCase(user.getStatus())) {
            request.setAttribute("error", "Your account is pending approval from admin.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        if ("Rejected".equalsIgnoreCase(user.getStatus())) {
            request.setAttribute("error", "Your registration was rejected by the admin.");
            request.setAttribute("rejected", true);
            request.setAttribute("rejectedUsername", user.getUserName());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        SessionUtil.setAttribute(request, "user", user);


        // Redirect based on role
        if ("Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/adminDashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }


    }
}
