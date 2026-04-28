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

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path  = uri.substring(contextPath.length());

        if(path.startsWith("/static")){
            chain.doFilter(request,response);
            return;
        }

        User user = (User) SessionUtil.getAttribute(req, "user");
        boolean isLoggedIn = user != null;
        boolean isAdmin = isLoggedIn && "Admin".equals(user.getRole());
        boolean isAuthPage = "/login".equals(path) || "/signup".equals(path);

        boolean isPublicPage =  "/home".equals(path) ||
                                "/about".equals(path) ||
                                "/contact".equals(path) ||
                                 isAuthPage;

        boolean isAdminPage = "/adminDashboard".equals(path);



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

        if (isAdmin && isPublicPage) {
            res.sendRedirect(contextPath + "/adminDashboard");
            return;
        }

        if (!isLoggedIn && !isPublicPage) {
            boolean isVisitor = req.getSession(false) == null;
            res.sendRedirect(contextPath + (isVisitor ? "/home" : "/login"));
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
        chain.doFilter(request, response);
    }
}
