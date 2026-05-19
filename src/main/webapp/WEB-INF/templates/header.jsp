<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>

    <%-- For Admin --%>
    <c:when test="${sessionScope.user.role == 'Admin'}">
        <header class="top-navbar">
            <div class="hamburger" id="menuBtn">☰</div>

            <div class="navbar-admin">
                <jsp:include page="/WEB-INF/templates/profilePanel.jsp" />
            </div>
        </header>
    </c:when>

    <%-- For member --%>
    <c:when test="${sessionScope.user.role == 'Member'}">
        <header>
            <div class="logo">VEHICLES<span>.NP</span></div>

            <div class="header-right">
                <div class="hamburger" id="menuBtn">☰</div>
                    <%-- Nav for Member --%>
                        <nav id="nav">
                            <a href="${pageContext.request.contextPath}/home"
                               class="${param.activePage == 'home' ? 'active' : ''}">Home</a>
                            <a href="${pageContext.request.contextPath}/vehicles"
                               class="${param.activePage == 'vehicles' ? 'active' : ''}">Vehicles</a>
                                    <a href="${pageContext.request.contextPath}/my-bookings"
                                       class="${param.activePage == 'bookings' ? 'active' : ''}">My Bookings</a>
                            <a href="${pageContext.request.contextPath}/about"
                               class="${param.activePage == 'about' ? 'active' : ''}">About Us</a>
                            <a href="${pageContext.request.contextPath}/contact"
                               class="${param.activePage == 'contact' ? 'active' : ''}">Contact Us</a>
                                    <a href="${pageContext.request.contextPath}/wishlist"
                                       style="border-bottom:none; "><i class="fa-regular fa-heart wishlist" ></i></a>
                        </nav>
            <jsp:include page="/WEB-INF/templates/profilePanel.jsp" />
            </div>
        </header>
    </c:when>

    <%-- For Visitor --%>
    <c:otherwise>
        <header>
            <div class="logo">VEHICLES<span>.NP</span></div>

            <div class="hamburger" id="menuBtn">☰</div>

                <%-- Nav for Visitor --%>
            <nav id="nav">
                <a href="${pageContext.request.contextPath}/home"
                   class="${param.activePage == 'home' ? 'active' : ''}">Home</a>
                        <a href="${pageContext.request.contextPath}/vehicles"
                           class="${param.activePage == 'vehicles' ? 'active' : ''}">Vehicles</a>
                <a href="${pageContext.request.contextPath}/about"
                   class="${param.activePage == 'about' ? 'active' : ''}">About Us</a>
                <a href="${pageContext.request.contextPath}/contact"
                   class="${param.activePage == 'contact' ? 'active' : ''}">Contact Us</a>
                <a href="${pageContext.request.contextPath}/login"
                   class="${param.activePage == 'login' ? 'active' : ''}">Login</a>
                <a href="${pageContext.request.contextPath}/signup"
                   class="${param.activePage == 'signup' ? 'active' : ''}">Signup</a>
            </nav>
        </header>
    </c:otherwise>

</c:choose>