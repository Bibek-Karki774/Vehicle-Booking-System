<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>

    <%-- ADMIN --%>
    <c:when test="${sessionScope.user.role == 'Admin'}">
        <header class="top-navbar">
            <div class="hamburger" id="menuBtn">☰</div>

            <div class="navbar-admin">
                <jsp:include page="/WEB-INF/templates/profilePanel.jsp" />
            </div>
        </header>
    </c:when>

    <%-- MEMBER --%>
    <c:when test="${sessionScope.user.role == 'Member'}">
        <header>
            <div class="logo">VEHICLES<span>.NP</span></div>

            <div class="hamburger" id="menuBtn">☰</div>
            <div class="header-right">
            <nav id="nav">
                <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
                <a href="${pageContext.request.contextPath}/vehicles">Vehicles</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
            </nav>
            <jsp:include page="/WEB-INF/templates/profilePanel.jsp" />
            </div>
        </header>
    </c:when>

    <%-- VISITOR (not logged in) --%>
    <c:otherwise>
        <header>
            <div class="logo">VEHICLES<span>.NP</span></div>

            <div class="hamburger" id="menuBtn">☰</div>

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