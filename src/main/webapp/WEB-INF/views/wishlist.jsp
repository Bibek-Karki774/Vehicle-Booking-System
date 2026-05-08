<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="title" value="My Wishlist" />
  <jsp:param name="cssFile" value="main" />
  <jsp:param name="cssFile2" value="wishlist" />
</jsp:include>

<body>
<main>
  <jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="activePage" value="wishlist" />
  </jsp:include>

  <div class="page-wrapper">

    <%-- Page Title --%>
    <div class="page-header">
      <div>
        <div class="page-title">
          <i class="fa-regular fa-heart" style="color: #000000;"></i> My Wishlist
        </div>
        <div class="page-sub">Vehicles you've saved for later</div>
      </div>
    </div>

    <%-- Summary Bar --%>
    <div class="summary-bar">
      <div class="summary-info">
        <strong>${wishlistCount} vehicles</strong> saved in your wishlist
      </div>
      <c:if test="${wishlistCount > 0}">
        <form method="post" action="${pageContext.request.contextPath}/wishlist">
          <input type="hidden" name="action" value="clear" />
          <button type="submit" class="btn-clear"
                  onclick="return confirm('Clear all wishlist items?')">
            <i class="fa-regular fa-trash-can"></i> Clear All
          </button>
        </form>
      </c:if>
    </div>

    <%-- Wishlist Items --%>
    <c:choose>
      <c:when test="${empty wishlistVehicles}">
        <div style="text-align:center; padding:80px 20px; color:#9aa0bc;">
          <p>Your wishlist is empty. Browse vehicles and save your favourites!</p>
          <a href="${pageContext.request.contextPath}/vehicles"
             style="display:inline-block; margin-top:16px; padding:10px 24px;
                              background:#6c63ff; color:white; border-radius:8px;
                              text-decoration:none; font-weight:600;">
            Browse Vehicles
          </a>
        </div>
      </c:when>
      <c:otherwise>

        <%-- Section header --%>
        <div class="section-header">
          <div class="section-title">
            <i class="fa-solid fa-circle-check"></i> Ready to Roll
          </div>
        </div>

        <%-- Cards --%>
        <c:forEach var="v" items="${wishlistVehicles}">
          <div class="wishlist-card">

            <div class="vehicle-thumb">
              <img src="" alt="${v.vehicleName}" />
            </div>

            <div class="vehicle-info">
              <div class="vehicle-name">${v.vehicleName}</div>
              <div class="vehicle-meta">
                <span class="vehicle-type-tag">${v.vehicleType}</span>
                <span class="meta-pill">
                                    <i class="fa-solid fa-users"></i> ${v.totalSeats} Seats
                                </span>
              </div>
              <div class="vehicle-desc">${v.vehicleDescription}</div>
            </div>

            <div class="price-block">
              <div class="price-current">Rs.${v.pricePerDay}</div>
              <div class="price-label">per day</div>
            </div>

            <div class="card-actions">
                <%-- Book Now --%>
              <form method="post" action="${pageContext.request.contextPath}/booking">
                <input type="hidden" name="action" value="review" />
                <input type="hidden" name="vehicleId" value="${v.vehicleId}" />
                <button type="submit" class="action-btn book">Book Now</button>
              </form>

                <%-- Remove --%>
              <form method="post" action="${pageContext.request.contextPath}/wishlist">
                <input type="hidden" name="action" value="remove" />
                <input type="hidden" name="wishlistId" value="${v.wishlistId}" />
                <button type="submit" class="action-btn remove" title="Remove">
                  <i class="fa-regular fa-trash-can"></i>
                </button>
              </form>
            </div>

          </div>
        </c:forEach>

      </c:otherwise>
    </c:choose>

  </div>



</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>