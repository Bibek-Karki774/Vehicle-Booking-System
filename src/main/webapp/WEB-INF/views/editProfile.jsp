<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Edit Profile" />
</jsp:include>
<body>

<!-- ── SIDEBAR ── -->
<jsp:include page="/WEB-INF/templates/sidebar.jsp" />

<!-- ── MAIN ── -->
<main class="main-content">

    <!-- ── NAVBAR ── -->
    <jsp:include page="/WEB-INF/templates/header.jsp" />

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