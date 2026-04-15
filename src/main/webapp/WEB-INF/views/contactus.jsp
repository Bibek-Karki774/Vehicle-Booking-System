<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us | Vehicles.NP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
</head>
<body>

<header>
    <div class="logo">VEHICLES<span>.NP</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/about">About Us</a>
        <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
        <a href="${pageContext.request.contextPath}/login" class="login">Login</a>
        <a href="${pageContext.request.contextPath}/signup" class="signup">Signup</a>
    </nav>
</header>

<section class="hero contact-hero">
    <div class="hero-content">
        <h1>Get in <span>Touch</span></h1>
        <p>Have questions about our fleet or the booking process? Our team is here to help you 24/7.</p>
    </div>
</section>

<main class="contact-section">
    <div class="contact-layout">

        <div class="contact-info">
            <h2>Contact Details</h2>

            <div class="info-card">
                <div class="info-card-body">
                    <strong>📍 Location</strong>
                    <p>Informatic College, Matepani<br>Pokhara, Nepal</p>
                </div>
            </div>

            <div class="info-card">
                <div class="info-card-body">
                    <strong>📧 Email Us</strong>
                    <p>support@vehicles.np</p>
                </div>
            </div>

            <div class="info-card">
                <div class="info-card-body">
                    <strong>📞 Call Us</strong>
                    <p>+977 9800000000</p>
                </div>
            </div>
        </div>

        <div class="contact-form-card">
            <div class="form-head">
                <h3>Send a Message</h3>
                <p>Fill out the form below and we will get back to you shortly.</p>
            </div>

            <form action="ContactServlet" method="POST" class="contact-form">
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="name" placeholder="Enter your name" required>
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="Enter your email" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" name="subject" placeholder="What is this regarding?">
                </div>

                <div class="form-group">
                    <label>Message</label>
                    <textarea name="message" rows="5" class="msg-box" placeholder="How can we help you?"></textarea>
                </div>

                <button type="submit" class="btn-submit">Send Message</button>
            </form>
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

</body>
</html>