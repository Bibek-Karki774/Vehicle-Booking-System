<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Wheels.NP" />
    <jsp:param name="cssFile" value="main" />
    <jsp:param name="cssFile2" value="vehicle" />
</jsp:include>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="activePage" value="home" />
</jsp:include>
<section class="hero">
    <c:choose>

        <%-- MEMBER HERO --%>
        <c:when test="${not empty sessionScope.user}">
            <section class="hero" style="min-height: 150px; padding: 20px 0;">
                <div class="hero-box">
                    <h1>Welcome back, ${sessionScope.user.userName}</h1>
                    <p>Ready for your next ride? Book a vehicle or manage your trips.</p>

                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/vehicles" class="btn-primary">
                            Book a Vehicle
                        </a>
                        <a href="${pageContext.request.contextPath}/my-bookings" class="btn-secondary">
                            My Bookings
                        </a>
                    </div>
                </div>
            </section>
        </c:when>

        <%-- VISITOR HERO --%>
        <c:otherwise>
            <section class="hero">
                <div class="hero-box">
                    <h1>Premium Rides for Your <span class="text-accent">Next Adventure</span></h1>
                    <p>Experience the best vehicle rental service in Pokhara.</p>

                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/login" class="btn-primary">
                            Get Started
                        </a>
                        <a href="${pageContext.request.contextPath}/about" class="btn-secondary">
                            Learn More
                        </a>
                    </div>
                </div>
            </section>
        </c:otherwise>

    </c:choose>
</section>

<main>
  <section class="cars">
    <div class="title">
        <c:choose>

            <c:when test="${not empty sessionScope.user}">
                <h2>Recommended Vehicles</h2>
                <p>Quick access to vehicles based on your activity</p>
            </c:when>


            <c:otherwise>
                <h2>Featured Vehicles</h2>
                <p>Most trusted and frequently chosen vehicles by our users</p>
            </c:otherwise>

        </c:choose>

    </div>

      <div class="vehicles-grid index-grid">
          <c:forEach var="v" items="${vehicles}" varStatus="status">
              <c:if test="${status.index < 6}">

                  <div class="vehicle-card">

                      <!-- Image -->
                      <div class="vehicle-img">
                          <img src="" alt="${v.vehicleName}"/>
                      </div>

                      <!-- Header -->
                      <div class="vehicle-card-header">
                          <div class="vehicle-title-row">
                              <h3 class="vehicle-name">${v.vehicleName}</h3>
                              <span class="vehicle-type-tag">${v.vehicleType}</span>
                          </div>
                          <span class="vehicle-desc">${v.vehicleDescription}</span>
                      </div>

                      <!-- Meta -->
                      <div class="vehicle-meta">
                          <div class="vehicle-plate">
                              <i class="fa-solid fa-users"></i> ${v.totalSeats} Seats
                          </div>
                          <div class="vehicle-price">
                              <span class="price-amount">Rs${v.pricePerDay}</span>
                              <span class="price-unit">/day</span>
                          </div>
                      </div>

                          <%-- Actions --%>
                      <div class="vehicle-actions">

                              <%-- Member --%>
                          <c:if test="${sessionScope.user.role == 'Member'}">
                              <a href="${pageContext.request.contextPath}/booking?vehicleId=${v.vehicleId}"
                                 class="book-btn" >
                                   Book Now
                              </a>
                          </c:if>



                              <%-- Visitor --%>
                          <c:if test="${empty sessionScope.user}">
                              <a href="${pageContext.request.contextPath}/login"
                                 class="book-btn">
                                  Book Now
                              </a>
                          </c:if>

                      </div>

                  </div>

              </c:if>
          </c:forEach>

    </div>
  </section>
</main>

<%@ include file="/WEB-INF/templates/footer.html" %>



<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
</body>

</html>