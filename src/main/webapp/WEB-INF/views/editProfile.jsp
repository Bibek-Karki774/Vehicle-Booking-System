<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Edit Profile" />
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

    <!-- Edit profile contents -->
    <div class="profile-page">
        <div class="profile-card">

            <h2 class="edit-profile-title">Edit Profile</h2>

            <form action="${pageContext.request.contextPath}/editProfile" method="post" enctype="multipart/form-data">

                <!-- Display error or success message -->
                <c:if test="${not empty error}">
                    <p class="error"><c:out value="${error}" /></p>
                </c:if>

                <c:if test="${not empty success}">
                    <p class="success"><c:out value="${success}" /></p>
                </c:if>

                <!-- Display user uploaded pic or default pic -->
                <div class="profile-avatar-wrapper">
                    <div class="edit-avatar">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.image}">
                                <img src="${pageContext.request.contextPath}/${sessionScope.user.image}"
                                     alt="Profile Picture"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/static/images/Default_Profile.jpg"
                                     alt="Default Profile"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <label for="photoInput" class="change-photo-btn">
                        Change Picture
                    </label>
                    <input type="file" id="photoInput" name="image" accept=".jpg,.jpeg,.png" style="display:none" />
                </div>

                <!-- Input filed to update the personal details -->
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
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="profile-form-cancel">Cancel</a>
                    <button type="submit" class="profile-form-submit">Save Changes</button>
                </div>

            </form>
        </div>
    </div>

</main>


<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>


</body>
</html>