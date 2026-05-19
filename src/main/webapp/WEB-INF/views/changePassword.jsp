<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Change Password" />
    <jsp:param name="cssFile" value="${sessionScope.user.role == 'Member' ? 'main' : ''}" />
</jsp:include>
<body class="${sessionScope.user.role == 'Admin' ? 'dashboard' : ''}">

<c:if test="${sessionScope.user.role == 'Admin'}">
    <jsp:include page="/WEB-INF/templates/sidebar.jsp">
        <jsp:param name="activePage" value="" />
    </jsp:include>
</c:if>

<main class="main-content">
    <jsp:include page="/WEB-INF/templates/header.jsp" />

    <div class="profile-page">
        <div class="profile-card">

            <h2 class="password-title">Change Password</h2>

            <form action="${pageContext.request.contextPath}/changePassword" method="post">

                <c:if test="${not empty error}">
                    <p class="error"><c:out value="${error}" /></p>
                </c:if>

                <c:if test="${not empty success}">
                    <p class="success"><c:out value="${success}" /></p>
                </c:if>

                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword"
                           placeholder="Enter current password" required />
                </div>

                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword"
                           placeholder="Min 8 chars, 1 uppercase, 1 number, 1 special" required />
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Confirm new password" required />
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/home" class="profile-form-cancel">Cancel</a>
                    <button type="submit" class="profile-form-submit">Update Password</button>
                </div>

            </form>
        </div>
    </div>
</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>