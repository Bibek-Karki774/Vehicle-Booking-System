<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="title" value="My Wishlist" />
  <jsp:param name="cssFile" value="main" />
  <jsp:param name="cssFile2" value="wishlist" />
  <jsp:param name="cssFile3" value="vehicle" />
</jsp:include>

<body>
<main>
  <jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="activePage" value="wishlist" />
  </jsp:include>

  <div class="page-wrapper">

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
              <div class="wl-vehicle-name"><c:out value="${v.vehicleName}"/></div>
              <div class="wl-vehicle-meta">
                <span class="wl-vehicle-type-tag"><c:out value="${v.vehicleType}"/></span>
                <span class="meta-pill">
                                    <i class="fa-solid fa-users"></i> ${v.totalSeats} Seats
                                </span>
              </div>
              <div class="wl-vehicle-desc"><c:out value="${v.vehicleDescription}"/></div>
            </div>

            <div class="price-block">
              <div class="price-current">Rs.${v.pricePerDay}</div>
              <div class="price-label">per day</div>
            </div>

              <%-- Book Now --%>
            <div class="card-actions">
              <form method="post" action="${pageContext.request.contextPath}/booking">
                <input type="hidden" name="action" value="review" />
                <input type="hidden" name="vehicleId" value="${v.vehicleId}" />
                <button type="button" class="action-btn book"
                        data-vehicleId="${v.vehicleId}"
                        onclick="openModal(this)">
                  Book Now
                </button>
              </form>

                <%-- Remove from wishlist --%>
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


  <%-- Booking Modal for selecting dates --%>
  <div id="modal" class="modal">
    <div class="modal-content" style="max-height: 90vh; overflow-y: auto;">
      <div class="modal-header">
        <h2>Confirm Booking</h2>
        <p>Select your booking dates</p>
      </div>

      <%-- Show available dates section --%>
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
        <input type="hidden" name="action" value="review"/>
        <input type="hidden" name="origin" value="wishlist"/>
        <input type="hidden" name="vehicleId" id="modal-vehicle-id"
               value="${not empty bookedVehicleId ? bookedVehicleId : ''}"/>
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
          <button type="submit" class="btn-confirm">Confirm</button>
          <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
        </div>
      </form>
    </div>
  </div>


</main>

<%@ include file="/WEB-INF/templates/footer.html" %>

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