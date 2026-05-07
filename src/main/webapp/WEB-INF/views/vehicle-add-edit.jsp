<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Edit Profile" />
    <jsp:param name="cssFile" value="vehicle-add-edit" />
</jsp:include>
<body>

<!-- Sidebar -->
<jsp:include page="/WEB-INF/templates/sidebar.jsp" />

<!-- Main Content -->
<main class="main-content">

    <!-- Top Navbar -->
    <jsp:include page="/WEB-INF/templates/header.jsp" />

    <!-- Form Section -->
    <section class="form-section">

        <div class="form-card">

            <!-- Header -->
            <div class="form-header">
                <h2>${vehicle == null ? 'Add Vehicle' : 'Edit Vehicle'}</h2>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/vehicles">

                <input type="hidden" name="action" value="${vehicle == null ? 'add' : 'edit'}"/>

                <c:if test="${vehicle != null}">
                    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}"/>
                </c:if>

                <!-- IMAGE -->
                <div class="image-box">
                    <img src="${pageContext.request.contextPath}/static/images/Tyota_Corolla.png"
                         alt="Vehicle Image"/>

                    <label class="upload-btn">
                        <i class="fas fa-upload"></i> Choose Image
                        <input type="file" name="image"/>
                    </label>
                </div>

                <!-- FORM INPUTS -->
                <div class="form-row">

                    <div class="form-group">
                        <label>Vehicle Name</label>
                        <input type="text" name="vehicleName"
                               placeholder="Vehicle Name"
                               value="${vehicle != null ? vehicle.vehicleName : ''}" required/>
                    </div>

                    <div class="form-group">
                        <label>Vehicle Type</label>
                        <input type="text" name="vehicleType"
                               placeholder="Vehicle Type"
                               value="${vehicle != null ? vehicle.vehicleType : ''}" required/>
                    </div>

                </div>

                <div class="form-row">

                    <div class="form-group">
                        <label>Total Seats</label>
                        <input type="number" name="totalSeats"
                               placeholder="Total Seats"
                               value="${vehicle != null ? vehicle.totalSeats : ''}" required/>
                    </div>

                    <div class="form-group">
                        <label>Price Per Day</label>
                        <input type="number" step="0.01" name="pricePerDay"
                               placeholder="Price Per Day"
                               value="${vehicle != null ? vehicle.pricePerDay : ''}" required/>
                    </div>

                </div>

                <div class="form-group">
                    <label>Vehicle Description</label>
                    <textarea name="vehicleDescription"
                              placeholder="Description">${vehicle != null ? vehicle.vehicleDescription : ''}</textarea>
                </div>

                <!-- ACTION BUTTONS -->
                <div class="form-actions">

                    <a href="${pageContext.request.contextPath}/vehicles" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>

                    <button type="submit" class="btn-submit">
                        ${vehicle == null ? 'Add Vehicle' : 'Save Changes'}
                    </button>

                </div>

            </form>

        </div>

    </section>
</main>
<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>