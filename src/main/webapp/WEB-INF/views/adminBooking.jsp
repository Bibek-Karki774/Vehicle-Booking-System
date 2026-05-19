<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Bookings" />
    <jsp:param name="cssFile" value="admin-bookings" />
</jsp:include>
<body>

<jsp:include page="/WEB-INF/templates/sidebar.jsp">
    <jsp:param name="activePage" value="bookings" />
</jsp:include>

<div class="main-content">
    <jsp:include page="/WEB-INF/templates/header.jsp" />

    <div id="page-bookings">

        <!-- Booking stats section -->
        <div class="booking-stats">
            <div class="stat-box">
                <div class="stat-box-left">
                    <span class="stat-box-label">Total Bookings</span>
                    <span class="stat-box-value">${totalBookings}</span>
                </div>
                <div class="stat-box-icon icon-blue">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-box-left">
                    <span class="stat-box-label">Total Revenue</span>
                    <span class="stat-box-value green">
                        NPR <fmt:formatNumber value="${totalRevenue}" type="number"
                                              minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
                <div class="stat-box-icon icon-green">
                    <i class="fa-solid fa-coins"></i>
                </div>
            </div>
        </div>

        <form method="get" action="${pageContext.request.contextPath}/adminBooking">
            <!-- Search bar for searching bookings -->
            <div class="users-search-bar">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text"
                       name="search"
                       placeholder="Search by username or vehicle name..."
                       value="<c:out value='${search}'/>"/>
                <c:if test="${not empty search}">
                    <a href="${pageContext.request.contextPath}/adminBooking" class="btn-clear">
                        <i class="fa-solid fa-xmark"></i>
                    </a>
                </c:if>
            </div>

            <!-- Shows the result of searching -->
            <c:if test="${not empty search}">
                <p class="search-hint">
                    Results for "<strong><c:out value="${search}"/></strong>" —
                    <strong>${totalBookings}</strong> found
                </p>
            </c:if>
        </form>

        <!-- Show total bookings -->
        <div class="booking-card">
            <div class="booking-card-header">
                <span class="booking-card-title">
                    <i class="fa-solid fa-list"></i> All Bookings
                </span>
                <span class="booking-count-pill">${totalBookings} total</span>
            </div>

            <!-- Display all booking in table format -->
            <div class="table-wrapper">
                <table class="users-table">
                    <thead>
                    <tr>
                        <th>User</th>
                        <th>Vehicle</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Amount</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty bookings}">
                            <tr>
                                <td colspan="6" class="empty-cell">
                                    <i class="fa-solid fa-inbox"></i> No bookings found.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td>
                                        <span class="user-name">
                                            <c:out value="${b.userName}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="user-name">
                                            <c:out value="${b.vehicleName}"/>
                                        </span>
                                    </td>
                                    <td class="td-date">
                                        <fmt:formatDate value="${b.startDate}" pattern="MMM dd, yyyy"/>
                                    </td>
                                    <td class="td-date">
                                        <fmt:formatDate value="${b.endDate}" pattern="MMM dd, yyyy"/>
                                    </td>
                                    <td class="td-amount">
                                        NPR <fmt:formatNumber value="${b.totalAmount}"
                                                              type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>

                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>