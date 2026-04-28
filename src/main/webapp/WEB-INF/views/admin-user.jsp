<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>WHEELS Admin Dashboard</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@600;700&family=DM+Sans:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin-user.css" />
  </head>
  <body>
    <!-- ================================================
       SIDEBAR
  ================================================ -->
    <aside class="sidebar">
      <div class="sidebar-logo">
        <div class="logo-icon"><i class="fas fa-car-side"></i></div>
        <div>
          <span class="logo-brand">WHEELS</span>
          <span class="logo-sub">Admin Panel</span>
        </div>
      </div>

      <nav class="sidebar-nav">
        <ul>
          <li class="nav-item" data-page="overview">
            <a href="#">
              <i class="fas fa-chart-line"></i>
              <span class="nav-label">Overview</span>
            </a>
          </li>

          <li class="nav-item active" data-page="users">
            <a href="#">
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

    <!-- ================================================
       MAIN CONTENT
  ================================================ -->
    <main class="main-content">
      <header class="top-navbar">
        <div>
          <h1 class="page-title">Users</h1>
          <p class="page-subtitle">Manage user accounts and approvals</p>
        </div>
        <div class="navbar-admin">
          <div class="admin-info">
            <div class="admin-avatar"><i class="fas fa-user-shield"></i></div>
            <div>
              <span class="admin-name">Admin User</span>
              <span class="admin-email">admin@wheels.com</span>
            </div>
          </div>
          <button class="signout-btn">
            <i class="fas fa-right-from-bracket"></i> Sign Out
          </button>
        </div>
      </header>

      <!-- ============================================
         USERS PAGE
    ============================================ -->
      <section class="page active" id="page-users">
          <!-- Search Bar -->
        <form method="get" action="${pageContext.request.contextPath}/admin-user">
          <div class="users-search-bar">
            <i class="fas fa-magnifying-glass"></i>
            <input type="text" name="search" placeholder="Search by name or email…" value="${keyword}"/>
            <c:if test="${not empty keyword}">
              <a href="${pageContext.request.contextPath}/admin-user" class="btn-clear">
                <i class="fas fa-xmark"></i>
              </a>
            </c:if>
          </div>
        </form>

          <div class="table-wrapper">

            <table class="users-table">
              <thead>
                <tr>
                  <th>User</th>
                  <th>Email</th>
                  <th>Joined</th>
                  <th>Updated At</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach var="user" items="${users}">
                <tr>
                  <td>
                    <div class="table-user">
                      <span class="user-name">${user.userName}</span>
                    </div>
                  </td>

                  <td class="td-email">${user.email}</td>


                  <td class="td-date">
                    <fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/>
                  </td>

                  <td class="td-date">
                    <fmt:formatDate value="${user.updatedAt}" pattern="dd MMM yyyy"/>
                  </td>

                  <td>
                    <span class="status-badge
                        <c:choose>
                           <c:when test="${user.status == 'Active'}">status-approved</c:when>
                           <c:when test="${user.status == 'Pending'}">status-pending</c:when>
                           <c:otherwise>status-rejected</c:otherwise>
                        </c:choose>">
                        ${user.status}
                    </span>
                  </td>

                  <td>
                    <div class="action-btns">
                      <form method="post" action="${pageContext.request.contextPath}/admin-user"
                            onsubmit="return confirm('Are you sure you want to delete this user?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="${user.userId}">

                        <form method="post" action="${pageContext.request.contextPath}/admin-user"
                              onsubmit="return confirm('Are you sure you want to delete this user?')">
                          <input type="hidden" name="action" value="delete">
                          <input type="hidden" name="userId" value="${user.userId}">
                          <button type="submit" class="btn-delete" title="Delete user">
                            <i class="fas fa-trash"></i>
                          </button>
                        </form>
                      </form>
                    </div>
                  </td>
                </tr>
              </c:forEach>


      </section>


    </main>
  </body>
</html>
