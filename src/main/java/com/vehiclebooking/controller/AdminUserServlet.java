package com.vehiclebooking.controller;

import com.vehiclebooking.dao.UserDao;
import com.vehiclebooking.dao.UserDaoImpl;
import com.vehiclebooking.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/admin-user")
public class AdminUserServlet extends HttpServlet {
    private final UserDao userDAO = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("search");

        ArrayList<User> users;

        if (keyword != null && !keyword.trim().isEmpty()) {
            users = userDAO.searchUsers(keyword.trim());
            request.setAttribute("keyword", keyword.trim());
        } else {
            users = userDAO.getAllUsers();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/admin-user.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean deleted = userDAO.deleteUser(userId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/admin-user?msg=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-user?msg=error");
            }
        }
    }
}
