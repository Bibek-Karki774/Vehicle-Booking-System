<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="sidebar">
    <div class="sidebar-close" onclick="closeSidebar()">✖</div>
    <div class="sidebar-logo">
        <div class="logo-icon">
            <i class="fas fa-car-side"></i>
        </div>
        <div>
            <span class="logo-brand">WHEELS</span>
            <span class="logo-sub">Admin</span>
        </div>
    </div>

    <nav class="sidebar-nav">
        <ul>
            <li class="nav-item ${param.activePage == 'overview' ? 'active' : ''}" data-page="overview">
                <a href="${pageContext.request.contextPath}/adminDashboard">
                    <i class="fa-regular fa-house"></i>
                    <span class="nav-label">Dashboard</span>
                </a>
            </li>
            <li class="nav-item ${param.activePage == 'adminUser' ? 'active' : ''}" data-page="users">
                <a href="${pageContext.request.contextPath}/admin-user">
                    <i class="fas fa-users"></i>
                    <span class="nav-label">Users</span>
                </a>
            </li>
            <li class="nav-item ${param.activePage == 'vehicles' ? 'active' : ''}" data-page="vehicles">
                <a href="${pageContext.request.contextPath}/vehicles">
                    <i class="fas fa-truck"></i>
                    <span class="nav-label">Vehicles</span>
                </a>
            </li>
            <li class="nav-item ${param.activePage == 'bookings' ? 'active' : ''}" data-page="bookings">
                <a href="${pageContext.request.contextPath}/adminBooking">
                    <i class="fas fa-calendar-check"></i>
                    <span class="nav-label">Bookings</span>
                </a>
            </li>
            <li class="nav-item ${param.activePage == 'reports' ? 'active' : ''}" data-page="reports">
                <a href="${pageContext.request.contextPath}/reports">
                    <i class="fas fa-chart-bar"></i>
                    <span class="nav-label">Reports</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>