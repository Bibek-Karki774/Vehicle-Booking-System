<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="My Bookings" />
    <jsp:param name="cssFile" value="main" />
    <jsp:param name="cssFile2" value="member-booking" />
</jsp:include>
<body>

<main class="main-content">
    <jsp:include page="/WEB-INF/templates/header.jsp">
        <jsp:param name="activePage" value="bookings" />
    </jsp:include>

    <div id="page-my-bookings">

        <!-- Stats -->
        <div class="mb-stats">
            <div class="mb-stat-box">
                <div class="mb-stat-left">
                    <span class="mb-stat-label">Total Bookings</span>
                    <span class="mb-stat-value">${totalBookings}</span>
                </div>
                <div class="mb-stat-icon icon-blue">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
            </div>
            <div class="mb-stat-box">
                <div class="mb-stat-left">
                    <span class="mb-stat-label">Total Spent</span>
                    <span class="mb-stat-value green">
                        NPR ${totalSpent}
                    </span>
                </div>
                <div class="mb-stat-icon icon-green">
                    <i class="fa-solid fa-coins"></i>
                </div>
            </div>
        </div>

        <!-- Bookings Card -->
        <div class="mb-card">
            <div class="mb-card-header">
                <span class="mb-card-title">
                    <i class="fa-solid fa-list"></i> My Bookings
                </span>
                <span class="mb-count-pill">${totalBookings} total</span>
            </div>

            <div class="table-wrapper">
                <table class="mb-table">
                    <thead>
                    <tr>
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
                                <td colspan="4" class="mb-empty-cell">
                                    <i class="fa-solid fa-calendar-xmark"></i>
                                    <p>You have no bookings yet.</p>
                                    <a href="${pageContext.request.contextPath}/vehicles" class="mb-browse-btn">
                                        Browse Vehicles
                                    </a>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td>
                                        <span class="mb-vehicle-name">
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
                                        NPR ${totalSpent}
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
</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>