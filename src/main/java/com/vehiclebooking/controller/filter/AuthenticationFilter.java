package com.vehiclebooking.controller.filter;

import com.vehiclebooking.entity.User;
import com.vehiclebooking.utils.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Get actual page path from the URL
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path  = uri.substring(contextPath.length());

        if(path.startsWith("/static")){
            chain.doFilter(request,response);
            return;
        }

        // Redirect root URL to home
        if ("/".equals(path) || path.isEmpty()) {
            res.sendRedirect(contextPath + "/home");
            return;
        }

        /*Get the user from session and checks if the user is
         logged in, also checks if the user is an admin,
         and checks whether the current page is login or signup.*/
        User user = (User) SessionUtil.getAttribute(req, "user");
        boolean isLoggedIn = user != null;
        boolean isAdmin = isLoggedIn && "Admin".equals(user.getRole());
        boolean isAuthPage = "/login".equals(path) || "/signup".equals(path);

        boolean isPublicPage =  "/home".equals(path) ||
                                "/about".equals(path) ||
                                "/contact".equals(path) ||
                                "/vehicles".equals(path) ||
                                isAuthPage;

        boolean isAdminPage = "/adminDashboard".equals(path) ||
                "/adminBooking".equals(path)   ||
                "/adminReport".equals(path) ||
                "/admin-user".equals(path);



        // Block non-admin users from /admin pages
        if (isAdminPage) {
            if (!isLoggedIn) {
                res.sendRedirect(contextPath + "/login");
                return;
            }
            if (!isAdmin) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        if (isAdmin && isPublicPage && !"/vehicles".equals(path)) {
            res.sendRedirect(contextPath + "/adminDashboard");
            return;
        }


        // If not logged in and not a public page, show 404 error page
        if (!isLoggedIn && !isPublicPage) {
            res.sendError(404);
            return;
        }

        if (isLoggedIn && isAuthPage) {
            if (isAdmin) {
                res.sendRedirect(contextPath + "/adminDashboard");
            } else {
                res.sendRedirect(contextPath + "/home");
            }
            return;
        }

        // Pass the request to next page
        chain.doFilter(request, response);
    }
}
