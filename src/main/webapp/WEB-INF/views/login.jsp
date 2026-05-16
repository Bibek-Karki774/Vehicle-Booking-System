<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="title" value="Login" />
  <jsp:param name="cssFile" value="main" />
  <jsp:param name="cssFile2" value="auth" />
</jsp:include>
<body class="auth-page">

<jsp:include page="/WEB-INF/templates/header.jsp">
  <jsp:param name="activePage" value="login" />
</jsp:include>

<main class="auth-main">
  <div class="auth-card">
    <div class="auth-header">
      <h1>Welcome Back</h1>
      <p>Enter your details to access your bookings.</p>
    </div>


    <form action="${pageContext.request.contextPath}/login" method="POST" class="auth-form">
      <div class="form-group">


        <c:if test="${not empty error}">
          <p class="error">
          <c:out value="${error}" />
          <c:if test="${rejected}">
            <form action="${pageContext.request.contextPath}/reapply" method="POST" style="display:inline;">
              <input type="hidden" name="username" value="${rejectedUsername}" />
              <button type="submit" class="reapply-link">Re-apply</button>
            </form>
          </c:if>
          </p>
        </c:if>

        <label>Username</label>
        <input type="text" name="username" value="<c:out value='${param.username}' default='' />" placeholder="e.g. ram739" required>
      </div>

      <div class="form-group">
        <label>Password</label>
        <input type="password" name="password" placeholder="•••••••••" required>

      </div>

      <button type="submit" class="btn-login">Sign In</button>
    </form>

    <div class="auth-divider">
      <span>OR</span>
    </div>

    <p class="switch-auth">
      Don't have an account? <a href="${pageContext.request.contextPath}/signup">Create an account</a>
    </p>
  </div>
</main>

<%@ include file="/WEB-INF/templates/footer.html" %>

<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>
</body>
</html>