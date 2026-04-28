<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>WHEELS Admin Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@600;700&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/profile.css" />
</head>
<body>

<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon">
      <i class="fas fa-car-side"></i>
    </div>
    <div>
      <span class="logo-brand">WHEELS</span>
      <span class="logo-sub">Admin</span>
    </div>
  </div>

  <nav class="sidebar-nav">
    <ul>
      <li class="nav-item active" data-page="overview">
        <a href="#">
          <i class="fa-regular fa-house"></i>
          <span class="nav-label">Dashboard</span>
        </a>
      </li>
      <li class="nav-item" data-page="users">
        <a href="${pageContext.request.contextPath}/admin-user">
          <i class="fas fa-users"></i>
          <span class="nav-label">Users</span>
        </a>
      </li>
      <li class="nav-item" data-page="vehicles">
        <a href="#">
          <i class="fas fa-truck"></i>
          <span class="nav-label">Vehicles</span>
        </a>
      </li>
      <li class="nav-item" data-page="bookings">
        <a href="#">
          <i class="fas fa-calendar-check"></i>
          <span class="nav-label">Bookings</span>
        </a>
      </li>
      <li class="nav-item" data-page="reports">
        <a href="#">
          <i class="fas fa-chart-bar"></i>
          <span class="nav-label">Reports</span>
        </a>
      </li>
    </ul>
  </nav>
</aside>

<main class="main-content">

  <header class="top-navbar">
    <div class="navbar-admin">


        <div class="profile-wrapper">

          <div class="profile-trigger" id="profileIcon">
            <i class="fas fa-user-circle profile-trigger"></i>
          </div>

          <div class="profile-dropdown" id="profilePanel">

            <div class="profile-container">

              <!-- header -->
              <div class="profile-header">
                <div class="profile-avatar">
                  <i class="fas fa-user"></i>
                </div>
                <div class="profile-title">${sessionScope.user.userName}</div>
              </div>

              <!-- details -->
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
                <i class="fas fa-pen"></i>
                Edit Profile
              </a>
              <a href="${pageContext.request.contextPath}/logout" class="profile-logout">
                <i class="fas fa-sign-out-alt"></i>
                Logout
              </a>
            </div>

          </div>

        </div>
      </div>



  </header>

  <div class="dashboard-overview" id="page-overview">

    <div class="stat-cards-row">

      <div class="stat-card">
        <div class="stat-card-top">
          <span class="stat-label">Total Users</span>
          <div class="stat-icon icon-orange">
            <i class="fas fa-users"></i>
          </div>
        </div>
        <div class="stat-value">${totalUsers}</div>
        <div class="stat-trend trend-warn">
          <i class="fas fa-circle-exclamation"></i> Needs action
        </div>
      </div>

      <div class="stat-card card-highlight">
        <div class="stat-card-top">
          <span class="stat-label">Total Revenue</span>
          <div class="stat-icon icon-green">
            <i class="fas fa-dollar-sign"></i>
          </div>
        </div>
        <div class="stat-value value-green">$${totalRevenue}</div>
        <div class="stat-trend trend-up">
          <i class="fas fa-arrow-trend-up"></i> +$40 this month
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-card-top">
          <span class="stat-label">Total Vehicles</span>
          <div class="stat-icon icon-blue">
            <i class="fas fa-truck"></i>
          </div>
        </div>
        <div class="stat-value">${totalVehicles}</div>
        <div class="stat-trend trend-up">
          <i class="fas fa-arrow-trend-up"></i> Fleet active
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-card-top">
          <span class="stat-label">Total Bookings</span>
          <div class="stat-icon icon-mint">
            <i class="fas fa-calendar-check"></i>
          </div>
        </div>
        <div class="stat-value">${totalBookings}</div>
        <div class="stat-trend trend-up">
          <i class="fas fa-arrow-trend-up"></i> +1 today
        </div>
      </div>

    </div>

    <div class="bottom-row bottom-row-single">
      <div class="dashboard-card">
        <div class="card-header">
          <h3 class="card-title">Pending Approvals</h3>
          <span class="pill pill-orange">${pendingUsers.size()} pending</span>
        </div>



        <c:forEach var="pendingUser" items="${pendingUsers}">
          <div class="approval-item">
            <div class="user-info">
              <span class="user-name">${pendingUser.userName}</span>
              <span class="user-email">${pendingUser.email}</span>
            </div>
            <div class="action-btns">
                <%-- Approve Button --%>
              <form method="post" action="${pageContext.request.contextPath}/adminDashboard" >
                <input type="hidden" name="userId" value="${pendingUser.userId}" />
                <button type="submit" name="action" value="approve" class="btn-approve">
                  Approve
                </button>
              </form>

                <%-- Reject Button  --%>
              <form method="post" action="${pageContext.request.contextPath}/adminDashboard">
                <input type="hidden" name="userId" value="${pendingUser.userId}" />
                <button type="submit" name="action" value="reject" class="btn-reject"
                        onclick="return confirm('Reject ${pendingUser.userName}? They will be asked to register again.');">
                  <i class="fas fa-circle-xmark"></i>
                </button>
              </form>

            </div>
          </div>
        </c:forEach>

      </div>
    </div>

  </div>

</main>
<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
</body>
</html>