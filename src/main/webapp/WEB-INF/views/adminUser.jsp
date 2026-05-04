<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!doctype html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="title" value="User" />
  <jsp:param name="cssFile" value="admin-user" />
</jsp:include>
<body>

<jsp:include page="/WEB-INF/templates/sidebar.jsp">
  <jsp:param name="activePage" value="adminUser" />
</jsp:include>

<main class="main-content">
  <jsp:include page="/WEB-INF/templates/header.jsp" />

  <section class="page active" id="page-users">

    <!-- Search Bar -->
    <form method="get" action="${pageContext.request.contextPath}/admin-user">
      <div class="users-search-bar">
        <i class="fas fa-magnifying-glass"></i>
        <input type="text" name="search"
               placeholder="Search by name or email…"
               value="${keyword}"/>
        <c:if test="${not empty keyword}">
          <a href="${pageContext.request.contextPath}/admin-user" class="btn-clear">
            <i class="fas fa-xmark"></i>
          </a>
        </c:if>
      </div>
      <!-- ADDED: search hint -->
      <c:if test="${not empty keyword}">
        <p class="search-hint">
          Results for "<strong><c:out value="${keyword}"/></strong>" —
          <strong>${totalUsers}</strong> found
        </p>
      </c:if>
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
                  <button type="submit" class="btn-delete" title="Delete user">
                    <i class="fas fa-trash"></i>
                  </button>
                </form>
              </div>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

  </section>
</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
</body>
</html>