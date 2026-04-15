package com.vehiclebooking.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/about", "/contact"})
public class AboutContactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if (path.equals("/about")) {
            request.getRequestDispatcher("/WEB-INF/views/aboutus.jsp").forward(request, response);
        } else if (path.equals("/contact")) {
            request.getRequestDispatcher("/WEB-INF/views/contactus.jsp").forward(request, response);
        }
    }
}