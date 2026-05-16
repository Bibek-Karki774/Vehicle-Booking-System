<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Contactus" />
    <jsp:param name="cssFile" value="main" />
</jsp:include>
<body>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="activePage" value="contact" />
</jsp:include>

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
                    <strong><i class="fa-solid fa-location-dot" style="color: #f59e0b;"></i> Location</strong>
                    <p>Informatic College, Matepani<br>Pokhara, Nepal</p>
                </div>
            </div>

            <div class="info-card">
                <div class="info-card-body">
                    <strong><i class="fa-solid fa-envelope" style="color:#3b82f6;"></i> Email Us</strong>
                    <p>support@vehicles.np</p>
                </div>
            </div>

            <div class="info-card">
                <div class="info-card-body">
                    <strong><i class="fa-solid fa-phone" style="color:#10b981;"></i> Call Us</strong>
                    <p>+977 9800000000</p>
                </div>
            </div>
        </div>

        <div class="contact-form-card">
            <div class="form-head">
                <h3>Send a Message</h3>
                <p>Fill out the form below and we will get back to you shortly.</p>
            </div>

            <form class="contact-form" onsubmit="handleSubmit(event)">
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

<%@ include file="/WEB-INF/templates/footer.html" %>

<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>

<script>
    function handleSubmit(e) {
        e.preventDefault();
        alert('Thank you for contacting us!');
        e.target.reset();
    }
</script>
</body>
</html>