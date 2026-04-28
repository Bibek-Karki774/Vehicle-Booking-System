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

    <div class="hamburger" onclick="toggleMenu()" id="menuBtn">☰</div>

    <nav id="nav">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/about" class="active">About Us</a>
        <a href="${pageContext.request.contextPath}/contact">Contact Us</a>

        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/signup">Signup</a>
    </nav>
</header>

<section class="hero small-hero">
    <div class="hero-content">
        <h1>About <span>Vehicles.NP</span></h1>
        <p class="about-text">Vehicles.NP is a simple and reliable vehicle booking platform built for the people of Pokhara, Nepal.
            We offer a wide range of everyday vehicles to suit your travel needs at affordable prices.
            Our platform makes it easy to browse, compare, and book vehicles in just a few clicks.
            Built with secure technology, we ensure every booking is safe and hassle-free.
            We are committed to making local transportation simple and accessible for everyone.
        </p>
    </div>
</section>

<main class="about-section">
    <div class="sec-header">
        <span class="sec-tag">Our Identity</span>
        <h2 class="sec-title">Modern Solutions for <br>Modern Travelers</h2>
        <p class="sec-desc">Vehicles.NP is a dedicated booking ecosystem designed to simplify how people in Pokhara access premium transportation. We focus on security, speed, and a seamless user experience.</p>
    </div>

    <div class="about-grid">

        <div class="about-card">
            <div class="about-card-body">
                <div class="about-icon">🎯</div>
                <h3>Our Mission</h3>
                <p>We aim to make vehicle booking simple and accessible for everyone in Pokhara. Our platform allows travelers to browse, compare, and book vehicles instantly in just a few clicks, eliminating manual paperwork and saving time.</p>
            </div>
        </div>

        <div class="about-card">
            <div class="about-card-body">
                <div class="about-icon">🤝</div>
                <h3>Why Choose Us</h3>
                <p>We are a trusted and reliable platform built by locals for locals. Our commitment to affordable pricing, verified providers, and a seamless booking experience makes us the first choice for travelers in Pokhara.</p>
            </div>
        </div>

        <div class="about-card">
            <div class="about-card-body">
                <div class="about-icon">🛡️</div>
                <h3>Safe & Reliable</h3>
                <p>Every booking on our platform is secure and verified. We carefully inspect and maintain all our vehicles to ensure they meet our safety standards. We are committed to providing a reliable service every time.</p>
            </div>
        </div>

    </div>
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