<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<head>
  <title>${param.title}</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@600;700&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />

  <%-- Load admin.css only for Admin so css doesn't conflict--%>
  <c:if test="${sessionScope.user.role == 'Admin'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin.css" />
  </c:if>

  <%-- Load profile.css only for logged in users --%>
  <c:if test="${not empty sessionScope.user}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/profile.css" />
  </c:if>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/${param.cssFile}.css" />
  </head>