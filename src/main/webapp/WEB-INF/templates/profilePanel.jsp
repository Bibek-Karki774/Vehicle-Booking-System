<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="profile-wrapper">
    <div class="profile-trigger" id="profileIcon">

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
    <div class="profile-dropdown" id="profilePanel">
        <div class="profile-container">
            <div class="profile-header">
                <div class="profile-avatar">
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
                    <i class="fa-solid fa-id-card"></i>
                    <span>${sessionScope.user.drivingLicense}</span>
                </div>

                <div class="profile-item">
                    <i class="fas fa-location-dot"></i>
                    <span>${sessionScope.user.address}</span>
                </div>
            </div>
            <a class="profile-edit" href="${pageContext.request.contextPath}/editProfile">
                <i class="fas fa-pen"></i> Edit Profile
            </a>
            <a class="profile-change-password" href="${pageContext.request.contextPath}/changePassword">
                <i class="fas fa-key"></i> Change Password
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="profile-logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</div>