<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Civilian Dashboard – CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .charts-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }
        .chart-card {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            height: 280px;
            display: flex;
            flex-direction: column;
        }
        .chart-card canvas {
            max-height: 200px;
        }
    </style>
</head>
<body>
<div class="layout">

    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>

    <div class="main">
        <div class="page-header" style="padding-bottom:15px; margin-bottom:20px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <div>
                    <h1 style="font-size:1.5rem; margin-bottom:2px;">Civilian Portal</h1>
                    <p style="font-size:0.85rem; margin:0;">Logged in as <strong><c:out value="${sessionScope.fullName}"/></strong></p>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/civilian/myRequests" class="btn btn-primary btn-xs">My Requests</a>
                    <a href="${pageContext.request.contextPath}/civilian/requestTask" class="btn btn-success btn-xs">+ New</a>
                </div>
            </div>
        </div>

        <%-- Charts Section --%>
        <div class="charts-container">
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">City Task Progress</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Total overview of active and completed community projects</div>
                <canvas id="cityProgressChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Organization Engagement</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Visualizing the level of participation from local organizations</div>
                <canvas id="orgEngagementChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Information Balance</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Ratio between official government notices and active tasks</div>
                <canvas id="infoBalanceChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">City Activity Trend</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Timeline showing the volume of city-wide project updates</div>
                <canvas id="activityTrendChart"></canvas>
            </div>
        </div>

        <%-- Stat cards --%>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="label">Public Tasks Available</div>
                <div class="value"><c:out value="${availableCount}"/></div>
            </div>
            <div class="stat-card orange">
                <div class="label">In Progress (City-wide)</div>
                <div class="value"><c:out value="${inProgressCount}"/></div>
            </div>
            <div class="stat-card green">
                <div class="label">Successfully Completed</div>
                <div class="value"><c:out value="${completedCount}"/></div>
            </div>
            <div class="stat-card">
                <div class="label">Active Organizations</div>
                <div class="value"><c:out value="${totalOrgs}"/></div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="card">
                <div class="card-title">Government Notices</div>
                <c:choose>
                    <c:when test="${empty recentNotices}">
                        <p style="color:#888; font-size:0.85rem;">No recent notices.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="n" items="${recentNotices}">
                            <div class="notice-item" style="padding:6px 0;">
                                <div class="notice-title" style="font-size:0.85rem;"><c:out value="${n.title}"/></div>
                                <div class="notice-date" style="font-size:0.7rem;">
                                    <fmt:formatDate value="${n.createdAt}" pattern="dd MMM"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Recently Completed --%>
            <div class="card">
                <div class="card-title">Recently Completed</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task</th>
                            <th>By Org</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentCompleted}">
                            <tr>
                                <td style="font-size:0.85rem;"><strong><c:out value="${t.title}"/></strong></td>
                                <td style="font-size:0.8rem;"><c:out value="${t.assignedOrgName}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="dashboard-grid">
            <%-- Tasks In Progress --%>
            <div class="card">
                <div class="card-title">In Progress</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Project</th>
                            <th>Org</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${inProgressWithOrg}">
                            <tr>
                                <td style="font-size:0.85rem;"><strong><c:out value="${t.title}"/></strong></td>
                                <td style="font-size:0.8rem;"><c:out value="${t.assignedOrgName}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="card-title">New Postings</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentAvailable}">
                            <tr>
                                <td style="font-size:0.85rem;"><strong><c:out value="${t.title}"/></strong></td>
                                <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    </div>
</div>

<script>
    // 1. City Task Progress (Pie)
    new Chart(document.getElementById('cityProgressChart'), {
        type: 'pie',
        data: {
            labels: ['Available', 'In Progress', 'Completed'],
            datasets: [{
                data: [${availableCount}, ${inProgressCount}, ${completedCount}],
                backgroundColor: ['#28a745', '#fd7e14', '#007bff'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            maintainAspectRatio: false
        }
    });

    // 2. Org Engagement (Bar)
    new Chart(document.getElementById('orgEngagementChart'), {
        type: 'bar',
        data: {
            labels: ['Active Orgs', 'Platform Goal'],
            datasets: [{
                label: 'Participation',
                data: [${totalOrgs}, Math.max(10, ${totalOrgs} + 2)],
                backgroundColor: '#6f42c1',
                borderRadius: 4
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } },
            maintainAspectRatio: false
        }
    });

    // 3. Info Balance (Doughnut)
    new Chart(document.getElementById('infoBalanceChart'), {
        type: 'doughnut',
        data: {
            labels: ['Notices', 'Tasks'],
            datasets: [{
                data: [5, ${availableCount} + ${inProgressCount} + ${completedCount}],
                backgroundColor: ['#e83e8c', '#17a2b8'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            maintainAspectRatio: false,
            cutout: '70%'
        }
    });

    // 4. City Activity Trend (Line)
    new Chart(document.getElementById('activityTrendChart'), {
        type: 'line',
        data: {
            labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
            datasets: [{
                label: 'Updates',
                data: [2, 5, 3, 8],
                borderColor: '#20c997',
                tension: 0.4,
                fill: true,
                backgroundColor: 'rgba(32, 201, 151, 0.1)'
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } },
            maintainAspectRatio: false
        }
    });
</script>
</body>
</html>
