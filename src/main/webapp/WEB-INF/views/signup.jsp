<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Signup" />
    <jsp:param name="cssFile" value="main" />
    <jsp:param name="cssFile2" value="auth" />
</jsp:include>

<body class="auth-page">

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="activePage" value="signup" />
</jsp:include>

<main class="auth-main">
    <div class="auth-card wide">
        <div class="auth-header">
            <h1>Join Us</h1>
            <p>Create an account to start booking your next ride.</p>
        </div>

        <form action="${pageContext.request.contextPath}/signup" method="POST" class="auth-form">

            <c:if test="${not empty error}">
                <p class="error"><c:out value="${error}" /></p>
            </c:if>

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" value="<c:out value='${param.username}' default='' />" placeholder="e.g. ram739" required>
            </div>
            <div class="form-group full-width">
                <label>Email Address</label>
                <input type="email" name="email" value="<c:out value='${param.email}' default='' />" placeholder="name@example.com" required>
            </div>
            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" name="phone" value="<c:out value='${param.phone}' default='' />" placeholder="+977-98XXXXXXXX" required>
            </div>
            <div class="form-group">
                <label>Address</label>
                <input type="text" name="address" value="<c:out value='${param.address}' default='' />" placeholder="Kathmandu, Nepal" required>
            </div>
            <div class="form-group">
                <label>Driver License</label>
                <input type="text" name="drivingLicense" value="<c:out value='${param.drivingLicense}' default='' />" placeholder="01-90-48392068" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="•••••••••" required>
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" placeholder="•••••••••" required>
            </div>

            <button type="submit" class="btn-login full-width">Create Account</button>
        </form>

        <div class="auth-divider">
            <span>OR</span>
        </div>

        <p class="switch-auth">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in instead</a>
        </p>
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