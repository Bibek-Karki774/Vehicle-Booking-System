<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Vehicles" />
    <jsp:param name="cssFile" value="vehicle" />
</jsp:include>
  <body>
  <jsp:include page="/WEB-INF/templates/sidebar.jsp">
      <jsp:param name="activePage" value="vehicles" />
  </jsp:include>

    <main class="main-content">
      <!-- Top Navbar -->
        <c:if test="${sessionScope.user.role == 'Admin'}">
            <jsp:include page="/WEB-INF/templates/header.jsp" />
        </c:if>

      <!-- ============================================
           VEHICLES PAGE
      ============================================ -->
        <section class="page active" id="page-vehicles">

            <!-- Toolbar -->
            <div class="vehicles-toolbar">
                <div class="vehicles-toolbar">
                    <form method="get" action="${pageContext.request.contextPath}/vehicles" >
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

                <%-- Only admin sees Add Vehicle button --%>
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

                                <!-- Image placeholder -->
                                <div class="vehicle-img" style="background: #eef2ff;">
                                    <img src="" alt="${v.vehicleName}"/>
                                </div>

                                <!-- Name + type + description -->
                                <div class="vehicle-card-header">
                                    <div class="vehicle-title-row">
                                        <h3 class="vehicle-name">${v.vehicleName}</h3>
                                        <span class="vehicle-type-tag">${v.vehicleType}</span>
                                    </div>
                                    <span class="vehicle-desc">${v.vehicleDescription}</span>
                                </div>

                                <!-- Seats + price -->
                                <div class="vehicle-meta">
                                    <div class="vehicle-plate">
                                        <i class="fas fa-chair"></i> ${v.totalSeats} Seats
                                    </div>
                                    <div class="vehicle-price">
                                        <span class="price-amount">Rs${v.pricePerDay}</span>
                                        <span class="price-unit">/day</span>
                                    </div>
                                </div>

                                <!-- Buttons based on role -->
                                <div class="vehicle-actions">

                                        <%-- Member sees Book Now --%>
                                    <c:if test="${sessionScope.user.role == 'Member'}">
                                        <a href="${pageContext.request.contextPath}/booking?vehicleId=${v.vehicleId}"
                                           class="btn-edit" style="text-decoration:none; text-align:center; flex:1;">
                                            <i class="fas fa-calendar-check"></i> Book Now
                                        </a>
                                    </c:if>

                                        <%-- Admin sees Edit and Delete --%>
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
    </main>
  <script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
  </body>
</html>
