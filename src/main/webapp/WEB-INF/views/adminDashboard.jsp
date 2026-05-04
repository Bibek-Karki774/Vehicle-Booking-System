<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
  <jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="WHEELS Admin Dashboard" />
  </jsp:include>
<body>

<jsp:include page="/WEB-INF/templates/sidebar.jsp">
  <jsp:param name="activePage" value="overview" />
</jsp:include>

<main class="main-content">
  <jsp:include page="/WEB-INF/templates/header.jsp" />
  <div class="dashboard-overview" id="page-overview">

    <div class="stat-cards-row">

      <div class="stat-card card-highlight">
        <div class="stat-card-top">
          <span class="stat-label">Daily Revenue</span>
          <div class="stat-icon icon-green">
            <i class="fas fa-dollar-sign"></i>
          </div>
        </div>
        <div class="stat-value value-green">$${dailyRevenue}</div>
        <div class="stat-trend trend-up">
          <c:choose>
            <c:when test="${dailyRevenue == 0}">
              <i class="fa-solid fa-circle-xmark"></i> No revenue till now
            </c:when>
            <c:otherwise>
              <i class="fas fa-arrow-up"></i> $${revenueDiff} more than yesterday
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-card-top">
          <span class="stat-label">Monthly Revenue</span>
          <div class="stat-icon icon-mint">
            <i class="fas fa-calendar-check"></i>
          </div>
        </div>
        <div class="stat-value">${monthlyRevenue}</div>
        <div class="stat-trend trend-up">
          <i class="fa-solid fa-chart-line"></i> Avg/day: $${averageRevenuePerDay}
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-card-top">
          <span class="stat-label">Total Users</span>
          <div class="stat-icon icon-orange">
            <i class="fas fa-users"></i>
          </div>
        </div>
        <div class="stat-value">${totalUsers}</div>
        <div class="stat-trend trend-warn">
          <i class="fa-solid fa-user-plus"></i> ${newUsersThisMonth} new this month
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
          <i class="fa-solid fa-calendar-xmark"></i> ${bookedToday} booked today
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
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>