<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<c:choose>
    <%-- ADMIN: load vehicle.css first, then admin.css overrides conflicts --%>
    <c:when test="${sessionScope.user.role == 'Admin'}">
        <jsp:include page="/WEB-INF/templates/head.jsp">
            <jsp:param name="title" value="Vehicles" />
            <jsp:param name="cssFile" value="vehicle" />
        </jsp:include>
    </c:when>

    <%-- MEMBER / VISITOR: main.css + vehicle.css --%>
    <c:otherwise>
        <jsp:include page="/WEB-INF/templates/head.jsp">
            <jsp:param name="title" value="Vehicles" />
            <jsp:param name="cssFile" value="main" />
            <jsp:param name="cssFile2" value="vehicle" />
        </jsp:include>
    </c:otherwise>
</c:choose>
<body class="${sessionScope.user.role == 'Admin' ? 'dashboard' : ''}">
<c:if test="${sessionScope.user.role == 'Admin'}">
    <jsp:include page="/WEB-INF/templates/sidebar.jsp">
        <jsp:param name="activePage" value="vehicles" />
    </jsp:include>
</c:if>

<main class="main-content">
    <jsp:include page="/WEB-INF/templates/header.jsp">
        <jsp:param name="activePage" value="vehicles" />
    </jsp:include>

    <section class="page active" id="page-vehicles">

            <c:if test="${param.booked == 'true'}">
                <div class="alert-success">
                    <i class="fas fa-circle-check"></i>
                    Booking confirmed successfully!
                </div>
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

                            <div class="vehicle-img">
                                <img src="" alt="${v.vehicleName}"/>

                                <c:if test="${sessionScope.user.role == 'Member'}">
                                    <form method="post" action="${pageContext.request.contextPath}/wishlist"
                                          class="wishlist-form">
                                            <%-- CHANGED: action is now toggle instead of add --%>
                                        <input type="hidden" name="action" value="toggle"/>
                                        <input type="hidden" name="vehicleId" value="${v.vehicleId}"/>
                                        <button type="submit" class="wishlist-btn">
                                                <%-- CHANGED: red filled if wishlisted, black outline if not --%>
                                            <c:choose>
                                                <c:when test="${wishlistVehicleIds.contains(v.vehicleId)}">
                                                    <i class="fa-solid fa-heart" style="color:#ef4444;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa-regular fa-heart" style="color:#111827;"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </form>
                                </c:if>
                            </div>

                            <div class="vehicle-card-header">
                                <div class="vehicle-title-row">
                                    <h3 class="vehicle-name"><c:out value="${v.vehicleName}"/></h3>
                                    <span class="vehicle-type-tag"><c:out value="${v.vehicleType}"/></span>
                                </div>
                                <span class="vehicle-desc"><c:out value="${v.vehicleDescription}"/></span>
                            </div>

                            <div class="vehicle-meta">
                                <div class="vehicle-plate">
                                    <i class="fa-solid fa-users"></i> ${v.totalSeats} Seats
                                </div>
                                <div class="vehicle-price">
                                    <span class="price-amount">Rs${v.pricePerDay}</span>
                                    <span class="price-unit">/day</span>
                                </div>
                            </div>

                            <div class="vehicle-actions">

                                <c:choose>
                                    <c:when test="${sessionScope.user.role == 'Member'}">
                                        <button class="book-btn"
                                                data-vehicleId="${v.vehicleId}"
                                                onclick="openModal(this)">
                                            Book Now
                                        </button>
                                    </c:when>
                                    <c:when test="${empty sessionScope.user}">
                                        <%-- Visitor: redirect to login --%>
                                        <a href="${pageContext.request.contextPath}/login"
                                           class="book-btn" style="text-align:center; text-decoration:none;">
                                            Book Now
                                        </a>
                                    </c:when>
                                </c:choose>

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
        <div class="modal-content" style="max-height: 90vh; overflow-y: auto;">
            <div class="modal-header">
                <h2>Confirm Booking</h2>
                <p>Select your booking dates</p>
            </div>

            <%-- Show available dates only when selected already booked dates --%>
            <div id="available-dates-section" style="display:none; margin-bottom: 14px;
        background: rgba(239,68,68,0.08);
        border: 1px solid rgba(239,68,68,0.3);
        border-radius: 8px; padding: 12px;">
                <p style="font-size: 13px; font-weight: 600;
              color: #ef4444; margin-bottom: 8px;">
                    This vehicle is already booked. Please select from these available dates:
                </p>
                <div style="display:flex; flex-wrap:wrap; gap:6px;">
                    <c:forEach var="d" items="${availableDates}">
            <span style="background:rgba(239,68,68,0.15);
                         border:1px solid rgba(239,68,68,0.3);
                         color:#ef4444;
                         padding:3px 10px;
                         border-radius:6px;
                         font-size:12px;
                         font-weight:600;">
                    ${d}
            </span>
                    </c:forEach>
                </div>
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
                        Confirm
                    </button>
                    <button type="button" class="btn-cancel" onclick="closeModal()">
                      Cancel
                    </button>
                </div>
            </form>

        </div>
    </div>


</main>


<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/modal.js"></script>

<%-- Auto open modal if booking error --%>
<c:if test="${bookingError == 'already_booked'}">
    <script>
        document.getElementById('available-dates-section').style.display = 'block';
        openModal(document.querySelector('[data-vehicleId="${bookedVehicleId}"]'));
    </script>
</c:if>
</body>
</html>