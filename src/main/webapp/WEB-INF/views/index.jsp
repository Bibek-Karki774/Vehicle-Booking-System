<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Premium Vehicle Booking</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
</head>
<body>

<header>
    <div class="logo">VEHICLES<span>.NP</span></div>

    <!-- Hamburger -->
    <div class="hamburger" onclick="toggleMenu()" id="menuBtn">☰</div>

    <nav id="nav">
        <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
        <a href="${pageContext.request.contextPath}/about">About Us</a>
        <a href="${pageContext.request.contextPath}/contact">Contact Us</a>

        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/signup">Signup</a>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/adminDashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>
<section class="hero">
  <div class="hero-box">
    <h1>Premium Rides for Your <span class="text-accent">Next Adventure</span></h1>
    <p>Experience the best vehicle rental service in Pokhara. Top vehicles, affordable prices, and 24/7 support.</p>
  </div>
</section>

<main>
  <section class="cars">
    <div class="title">
      <h2>Most Hired Vehicles</h2>
      <p>Our top-rated cars and bikes ready for your journey.</p>
    </div>

    <div class="grid">
        <c:forEach var="vehicle" items="${vehicles}" varStatus="status">
            <c:if test="${status.index < 8}">
                <div class="card">
                    <div class="img" >
                        <img src="${pageContext.request.contextPath}/static/images/Toyota_LandCrusier.jpg" alt="truck"  />
                    </div>
                    <div class="info">
                        <div class="vehicle-meta">
                            <span class="vehicle-type">${vehicle.vehicleType}</span>
                            <span class="vehicle-seats">👤 ${vehicle.totalSeats} Seats</span>
                        </div>
                        <h3>Executive Sedan</h3>
                        <p class="vehicle-desc">${vehicle.vehicleDescription}</p>
                        <div class="vehicle-footer">
                            <span class="vehicle-price">रू ${vehicle.pricePerDay}<small>/day</small></span>
                            <button class="btn">Book Now</button>
                        </div>
                    </div>
                </div>
            </c:if>

        </c:forEach>


    </div>
  </section>
</main>

<footer>
  <div class="foot">
    <div class="col brand">
      <div class="footer-logo">VEHICLES<span>.NP</span></div>
      <p>Providing safe and reliable transport solutions since 2026. Your journey is our priority.</p>
      <div class="social">
        <span class="icon">fb</span>
        <span class="icon">ig</span>
        <span class="icon">tw</span>
      </div>
    </div>

    <div class="col">
      <strong>Quick Links</strong>
      <ul>
        <li><a href="#">About Us</a></li>
        <li><a href="#">Our Fleet</a></li>
        <li><a href="#">Special Offers</a></li>
        <li><a href="#">Blog</a></li>
      </ul>
    </div>

    <div class="col">
      <strong>Support</strong>
      <ul>
        <li><a href="#">Help Center</a></li>
        <li><a href="#">Terms of Service</a></li>
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Contact Us</a></li>
      </ul>
    </div>

    <div class="col">
      <strong>Stay Updated</strong>
      <p>Subscribe to get the latest deals.</p>
      <form class="subscribe">
        <input type="email" placeholder="Email Address">
        <button type="submit">Join</button>
      </form>
    </div>
  </div>

  <div class="bottom">
    <p>2026 &copy; Vehicles.co.np. All rights reserved.</p>
  </div>
</footer>



<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>

</html>