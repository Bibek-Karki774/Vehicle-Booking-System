<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Aboutus" />
    <jsp:param name="cssFile" value="main" />
</jsp:include>
<body>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="activePage" value="about" />
</jsp:include>

<section class="about-hero">
    <div class="about-hero-top">

        <h1>Built for <span>Pokhara's</span> Roads</h1>
        <p class="about-hero-sub">
            A platform designed to make vehicle rental simple, safe,
            and accessible for everyone in the Gandaki region.
        </p>

    </div>
</section>

<!-- STATS STRIP — separate from hero -->
<section class="about-stats-strip">
    <div class="about-stat">
        <span class="about-stat-num">50+</span>
        <span class="about-stat-lbl">Vehicles Available</span>
    </div>
    <div class="about-stat-divider"></div>
    <div class="about-stat">
        <span class="about-stat-num">2,000+</span>
        <span class="about-stat-lbl">Happy Customers</span>
    </div>
    <div class="about-stat-divider"></div>
    <div class="about-stat">
        <span class="about-stat-num">4.9 <i class="fas fa-star"></i></span>
        <span class="about-stat-lbl">Average Rating</span>
    </div>
    <div class="about-stat-divider"></div>
    <div class="about-stat">
        <span class="about-stat-num">24/7</span>
        <span class="about-stat-lbl">Customer Support</span>
    </div>
</section>

<main>

    <!-- WHY CHOOSE US -->
    <section class="why-choose-section">
        <div class="sec-header">
            <span class="sec-tag">Who We Are ?</span>
            <h2 class="sec-title">Pokhara's Smartest Way to Rent a Vehicle</h2>
            <p class="sec-desc">Vehicles.NP is a fully managed vehicle rental platform built for the people of Pokhara. Whether you need a quick city ride or a rugged SUV for mountain roads, we connect you with the right vehicle — instantly, safely, and affordably.</p>
        </div>

        <div class="why-features">
            <div class="why-feature">
                <div class="why-feature-icon"> <i class="fas fa-bolt"></i></div>
                <h3>Quick & Easy Booking</h3>
                <p>Browse available vehicles, pick your dates, and confirm your booking in just a few clicks — no phone calls, no paperwork.</p>
            </div>
            <div class="why-feature">
                <div class="why-feature-icon"><i class="fas fa-shield-alt"></i></div>
                <h3>Verified & Safe</h3>
                <p>Every member account is reviewed and approved by our admin team. All vehicles are inspected and maintained to meet our safety standards.</p>
            </div>
            <div class="why-feature">
                <div class="why-feature-icon"> <i class="fas fa-headset"></i></div>
                <h3>24/7 Support</h3>
                <p>Our support team is available around the clock to help you with bookings, cancellations, or any issue on the road.</p>
            </div>
        </div>
    </section>

    <!-- OUR SERVICES -->
    <section class="services-section">
        <div class="sec-header">
            <h2 class="sec-title">Our Services</h2>
            <p class="sec-desc">Everything you need for a smooth rental experience — from browsing to drop-off.</p>
        </div>
        <div class="services-grid">
            <div class="service-card">
                <div class="service-card-head">
                    <span class="service-icon"> <i class="fas fa-car"></i></span>
                    <h3>Vehicle Rentals</h3>
                </div>
                <p>Choose from a wide fleet of cars, vans, SUVs, and bikes available for daily, weekly, or monthly rental. Every vehicle is GPS-equipped and fully insured.</p>
            </div>
            <div class="service-card">
                <div class="service-card-head">
                    <span class="service-icon"><i class="fas fa-clipboard-list"></i></span>
                    <h3>Easy Booking Management</h3>
                </div>
                <p>View, track, and manage all your bookings from your personal dashboard. Get real-time status updates from confirmation to completion.</p>
            </div>
            <div class="service-card">
                <div class="service-card-head">
                    <span class="service-icon">   <i class="fas fa-heart"></i></span>
                    <h3>Wishlist & Favourites</h3>
                </div>
                <p>Save vehicles you love to your wishlist and come back to book them anytime. Never lose track of the perfect ride for your next trip.</p>
            </div>
            <div class="service-card">
                <div class="service-card-head">
                    <span class="service-icon">    <i class="fas fa-map-marker-alt"></i></span>
                    <h3>Drop-off & Pickup</h3>
                </div>
                <p>Flexible pickup and drop-off options across Pokhara and the Gandaki region. We make sure getting your vehicle is as easy as booking it.</p>
            </div>
        </div>
    </section>

</main>
<footer>
    <div class="foot">
        <div class="col brand">
            <div class="footer-logo">VEHICLES<span>.NP</span></div>
            <p>Providing safe and reliable transport solutions since 2026. Your journey is our priority.</p>
            <div class="social">
                <i class="fab fa-facebook-f icon"></i>
                <i class="fab fa-instagram icon"></i>
                <i class="fab fa-twitter icon"></i>
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
<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
</body>
</html>