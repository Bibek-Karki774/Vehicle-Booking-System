<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>

    <%-- ADMIN --%>
    <c:when test="${sessionScope.user.role == 'Admin'}">
        <header class="top-navbar">
            <div class="hamburger" onclick="openSidebar()" id="menuBtn">☰</div>

            <div class="navbar-admin">

                <div class="profile-wrapper">

                    <div class="profile-trigger" id="profileIcon">
                        <i class="fas fa-user-circle profile-trigger"></i>
                    </div>

                    <div class="profile-dropdown" id="profilePanel">
                        <div class="profile-container">

                            <div class="profile-header">
                                <div class="profile-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="profile-title">${sessionScope.user.userName}</div>
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
                                <div class="profile-item">
                                    <i class="fas fa-location-dot"></i>
                                    <span>${sessionScope.user.address}</span>
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
    </c:when>

    <%-- MEMBER --%>
    <c:when test="${sessionScope.user.role == 'Member'}">
        <header>
            <div class="logo">VEHICLES<span>.NP</span></div>

            <div class="hamburger" onclick="toggleTopNav()" id="menuBtn">☰</div>

            <nav id="nav">
                <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </nav>
        </header>
    </c:when>

    <%-- VISITOR (not logged in) --%>
    <c:otherwise>
        <header>
            <div class="logo">VEHICLES<span>.NP</span></div>

            <div class="hamburger" onclick="toggleTopNav()" id="menuBtn">☰</div>

            <nav id="nav">
                <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/signup">Signup</a>
            </nav>
        </header>
    </c:otherwise>

</c:choose>