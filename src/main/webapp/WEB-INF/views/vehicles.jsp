<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Vehicles" />
    <jsp:param name="cssFile" value="vehicle" />
</jsp:include>
<body class="dashboard">
<jsp:include page="/WEB-INF/templates/sidebar.jsp">
    <jsp:param name="activePage" value="vehicles" />
</jsp:include>

<main class="main-content">
    <jsp:include page="/WEB-INF/templates/header.jsp" />

    <section class="page active" id="page-vehicles">

        <%--simple JS alert + redirect instead of alert div --%>
        <c:if test="${param.booked == 'true'}">
            <script>
                alert('Booking confirmed successfully!');
                window.location.href = '${pageContext.request.contextPath}/vehicles';
            </script>
        </c:if>

        <!-- Toolbar -->
        <div class="vehicles-toolbar">
            <div class="vehicles-toolbar">
                <form method="get" action="${pageContext.request.contextPath}/vehicles">
                    <div class="search-box">
                        <i class="fas fa-magnifying-glass"></i>
                        <input type="text" name="search" placeholder="Search by name or type..." value="${keyword}"/>
                        <c:if test="${not empty keyword}">
                            <a href="${pageContext.request.contextPath}/vehicles" class="btn-clear">
                                <i class="fas fa-xmark"></i>
                            </a>
                        </c:if>
                    </div>
                    <c:if test="${not empty keyword}">
                        <p class="search-hint">
                            Results for "<strong><c:out value="${keyword}"/></strong>" —
                            <strong>${totalVehicles}</strong> found
                        </p>
                    </c:if>
                    <button type="submit" style="display:none;"></button>
                </form>
            </div>

            <c:if test="${sessionScope.user.role == 'Admin'}">
                <a href="${pageContext.request.contextPath}/vehicles?action=add" class="btn-add-vehicle">
                    <i class="fas fa-plus"></i>
                    Add Vehicle
                </a>
            </c:if>
        </div>

        <!-- Vehicles Grid -->
        <c:choose>
            <c:when test="${empty vehicles}">
                <div style="text-align:center; padding:80px 20px; color:#999;">
                    <i class="fas fa-truck" style="font-size:3rem; margin-bottom:12px; display:block;"></i>
                    <p>No vehicles available.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="vehicles-grid">
                    <c:forEach var="v" items="${vehicles}">
                        <div class="vehicle-card">

                            <div class="vehicle-img" style="background: #eef2ff;">
                                <img src="" alt="${v.vehicleName}"/>
                            </div>

                            <div class="vehicle-card-header">
                                <div class="vehicle-title-row">
                                    <h3 class="vehicle-name">${v.vehicleName}</h3>
                                    <span class="vehicle-type-tag">${v.vehicleType}</span>
                                </div>
                                <span class="vehicle-desc">${v.vehicleDescription}</span>
                            </div>

                            <div class="vehicle-meta">
                                <div class="vehicle-plate">
                                    <i class="fas fa-chair"></i> ${v.totalSeats} Seats
                                </div>
                                <div class="vehicle-price">
                                    <span class="price-amount">Rs${v.pricePerDay}</span>
                                    <span class="price-unit">/day</span>
                                </div>
                            </div>

                            <div class="vehicle-actions">

                                <c:if test="${sessionScope.user.role == 'Member'}">

                                    <button class="book-btn"
                                            data-vehicleId="${v.vehicleId}"
                                            onclick="openModal(this)">
                                            Book Now
                                    </button>
                                </c:if>

                                <c:if test="${sessionScope.user.role == 'Admin'}">
                                    <a href="${pageContext.request.contextPath}/vehicles?action=edit&vehicleId=${v.vehicleId}"
                                       class="btn-edit" style="text-decoration:none; text-align:center;">
                                        <i class="fas fa-pen-to-square"></i> Edit
                                    </a>

                                    <form method="post" action="${pageContext.request.contextPath}/vehicles"
                                          onsubmit="return confirm('Delete this vehicle?');"
                                          style="margin:0;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="vehicleId" value="${v.vehicleId}"/>
                                        <button type="submit" class="btn-delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </c:if>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </section>

    <%-- modal now has form posting to booking servlet --%>
    <div id="modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <i class="fas fa-calendar-check modal-icon"></i>
                <h2>Confirm Booking</h2>
                <p>Select your booking dates</p>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/booking">
                <input type="hidden" name="action"    value="review"/>

                <input type="hidden" name="vehicleId" id="modal-vehicle-id" value=""/>

                <div class="modal-dates">
                    <div class="date-field">
                        <label for="fromDate">From Date</label>
                        <input type="date" id="fromDate" name="fromDate" class="date-input" required/>
                    </div>
                    <div class="date-field">
                        <label for="toDate">To Date</label>
                        <input type="date" id="toDate" name="toDate" class="date-input" required/>
                    </div>
                </div>

                <div class="modal-actions">
                    <button type="submit" class="btn-confirm">
                        <i class="fas fa-check"></i> Confirm
                    </button>
                    <button type="button" class="btn-cancel" onclick="closeModal()">
                        <i class="fas fa-xmark"></i> Cancel
                    </button>
                </div>
            </form>

        </div>
    </div>

</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/modal.js"></script>
</body>
</html>