<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="title" value="Reports" />
    <jsp:param name="cssFile" value="report" />
</jsp:include>
<body class="dashboard">

<jsp:include page="/WEB-INF/templates/sidebar.jsp">
    <jsp:param name="activePage" value="reports" />
</jsp:include>

<main class="main-content">
    <jsp:include page="/WEB-INF/templates/header.jsp" />

    <section class="page active" id="page-reports">

        <div class="report-card">
            <div class="report-card-header">
                <div>
                    <h2 class="report-card-title">Most Booked Vehicles</h2>
                    <p class="report-card-sub">Top 5 vehicles by number of bookings</p>
                </div>
                <div class="time-range-group">
                    <a href="${pageContext.request.contextPath}/adminReport?range=7d"
                       class="time-btn ${selectedRange == '7d' ? 'active' : ''}">7D</a>
                    <a href="${pageContext.request.contextPath}/adminReport?range=30d"
                       class="time-btn ${selectedRange == '30d' ? 'active' : ''}">30D</a>
                    <a href="${pageContext.request.contextPath}/adminReport?range=6m"
                       class="time-btn ${selectedRange == '6m' ? 'active' : ''}">6M</a>
                    <a href="${pageContext.request.contextPath}/adminReport?range=1y"
                       class="time-btn ${selectedRange == '1y' ? 'active' : ''}">1Y</a>
                </div>
            </div>

            <div class="report-list">
                <c:choose>
                    <c:when test="${empty top5Vehicles}">
                        <div class="report-empty">
                            <i class="fa-solid fa-inbox"></i>
                            <p>No booking data for this period.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="v" items="${top5Vehicles}" varStatus="s">
                            <div class="report-item">
                                <div class="rank-badge">${s.index + 1}</div>
                                <div class="report-item-info">
                                    <span class="report-vehicle-name">
                                        <c:out value="${v.vehicleName}"/>
                                    </span>
                                    <span class="report-vehicle-meta">
                                        <c:out value="${v.vehicleType}"/>
                                    </span>
                                </div>
                                <div class="report-item-stat">
                                    <span class="stat-bookings">${v.totalBookings} bookings</span>
                                    <span class="stat-revenue">
                                        NPR <fmt:formatNumber value="${v.totalAmount}"
                                                              type="number"
                                                              minFractionDigits="2"
                                                              maxFractionDigits="2"/>
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- ── Chart Card ── --%>
        <c:if test="${not empty top5Vehicles}">
            <div class="report-card">
                <div class="report-card-header">
                    <div>
                        <h2 class="report-card-title">Bookings & Revenue Chart</h2>
                        <p class="report-card-sub">Visual breakdown of top 5 vehicles</p>
                    </div>
                </div>
                <div style="height: 300px;">
                    <canvas id="reportChart"></canvas>
                </div>
            </div>
        </c:if>

    </section>
</main>

<script src="${pageContext.request.contextPath}/static/js/profile-toggle.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nav-toggle.js"></script>

<%-- ── Chart.js ── --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById("reportChart");
    if (ctx) {
        const labels = [
            <c:forEach var="v" items="${top5Vehicles}" varStatus="s">
            "<c:out value="${v.vehicleName}"/>"${!s.last ? ',' : ''}
            </c:forEach>
        ];

        const bookings = [
            <c:forEach var="v" items="${top5Vehicles}" varStatus="s">
            ${v.totalBookings}${!s.last ? ',' : ''}
            </c:forEach>
        ];

        const revenue = [
            <c:forEach var="v" items="${top5Vehicles}" varStatus="s">
            ${v.totalAmount}${!s.last ? ',' : ''}
            </c:forEach>
        ];

        new Chart(ctx, {
            type: "bar",
            data: {
                labels: labels,
                datasets: [
                    {
                        label: "Bookings",
                        data: bookings,
                        backgroundColor: "rgba(79, 70, 229, 0.7)",
                        borderColor: "rgba(79, 70, 229, 1)",
                        borderWidth: 2,
                        borderRadius: 6
                    },
                    {
                        label: "Revenue (NPR)",
                        data: revenue,
                        backgroundColor: "rgba(34, 197, 94, 0.7)",
                        borderColor: "rgba(34, 197, 94, 1)",
                        borderWidth: 2,
                        borderRadius: 6
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: "top" }
                },
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    }
</script>

</body>
</html>