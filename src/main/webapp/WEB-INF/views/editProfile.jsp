<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Profile – WHEELS Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@600;700&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/profile.css" />
</head>
<body>

<!-- ── SIDEBAR ── -->
<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-icon"><i class="fas fa-car-side"></i></div>
        <div>
            <span class="logo-brand">WHEELS</span>
            <span class="logo-sub">Admin</span>
        </div>
    </div>
    <nav class="sidebar-nav">
        <ul>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminDashboard">
                    <i class="fa-regular fa-house"></i>
                    <span class="nav-label">Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#"><i class="fas fa-users"></i><span class="nav-label">Users</span></a>
            </li>
            <li class="nav-item">
                <a href="#"><i class="fas fa-truck"></i><span class="nav-label">Vehicles</span></a>
            </li>
            <li class="nav-item">
                <a href="#"><i class="fas fa-calendar-check"></i><span class="nav-label">Bookings</span></a>
            </li>
            <li class="nav-item">
                <a href="#"><i class="fas fa-chart-bar"></i><span class="nav-label">Reports</span></a>
            </li>
        </ul>
    </nav>
</aside>

<!-- ── MAIN ── -->
<main class="main-content">

    <!-- ── NAVBAR ── -->
    <header class="top-navbar">
        <div class="navbar-admin">
            <div class="profile-wrapper">
                <div class="profile-trigger" id="profileIcon">
                    <i class="fas fa-user-circle profile-trigger"></i>
                </div>
                <div class="profile-dropdown" id="profilePanel">
                    <div class="profile-container">
                        <div class="profile-header">
                            <div class="profile-avatar"><i class="fas fa-user"></i></div>
                            <div class="profile-title">${sessionScope.user.userName}</div>
                            <div class="profile-role">${sessionScope.user.role}</div>
                        </div>
                        <div class="profile-details">
                            <div class="profile-item">
                                <i class="fas fa-envelope"></i>
                                <span>${sessionScope.user.email}</span>
                            </div>
                            <div class="profile-item">
                                <i class="fas fa-phone"></i>
                                <span>${sessionScope.user.phone}</span>
                            </div>
                        </div>
                        <a class="profile-edit" href="${pageContext.request.contextPath}/editProfile">
                            <i class="fas fa-pen"></i> Edit Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="profile-logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- ── EDIT PROFILE CONTENT ── -->
    <div class="profile-page">
        <div class="profile-card">

            <h2 class="profile-title">Edit Profile</h2>

            <div class="profile-avatar">
                <i class="fas fa-user"></i>
            </div>


            <form action="${pageContext.request.contextPath}/editProfile" method="post">

                <c:if test="${not empty error}">
                    <p class="error"><c:out value="${error}" /></p>
                </c:if>

                <c:if test="${not empty success}">
                    <p class="success"><c:out value="${success}" /></p>
                </c:if>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="userName"
                           value="<c:out value='${sessionScope.user.userName}' default='' />" required />
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email"
                           value="<c:out value='${sessionScope.user.email}' default='' />" required />
                </div>

                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone"
                           value="<c:out value='${sessionScope.user.phone}' default='' />" required />
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text"
                           id="address"
                           name="address"
                           value="<c:out value='${sessionScope.user.address}' default='' />"
                           required />
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>

            </form>
        </div>
    </div>

</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
</body>
</html>