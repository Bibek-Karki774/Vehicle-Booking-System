package com.vehiclebooking.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * The Utility class manages all HTTP session operations.
 * <p>
 * This class provides helper methods to set, get, remove attributes
 * and invalidate user sessions.
 * </p>
 */
public class SessionUtil {

    /**
     * This method sets the session attribute and defines session timeout to 1 hour.
     * @param request the HTTP request object
     * @param key the attribute name to store in session
     * @param value the value to store in session
     */
    public static void setAttribute(HttpServletRequest request,
                                    String key, Object value) {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(60 * 60);
        session.setAttribute(key, value);
    }

    /**
     * It gets the session attribute by key.
     * @param request the HTTP request object
     * @param key the attribute name to retrieve
     * @return the attribute value and return null if session doesn't exist.
     */
    public static Object getAttribute(HttpServletRequest request,
                                      String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(key);
        }
        return null;
    }

    /**
     * Invalidates the current session, mainly used for logout.
     * @param request the HTTP request object
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * It removes a specific attribute from the session if it exists.
     * @param request the HTTP request object
     * @param key the attribute name to remove
     */
    public static void removeAttribute(HttpServletRequest request, String key){
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }
}
