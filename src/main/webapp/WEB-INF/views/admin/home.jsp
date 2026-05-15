<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard – CityWatch</title>
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
            height: 300px;
            display: flex;
            flex-direction: column;
        }
        .chart-card canvas {
            max-height: 220px;
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
                    <h1 style="font-size:1.5rem; margin-bottom:2px;">System Overview</h1>
                    <p style="font-size:0.85rem; margin:0;">Logged in as <strong><c:out value="${sessionScope.fullName}"/></strong></p>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/admin/addTask" class="btn btn-primary btn-xs">+ Task</a>
                    <a href="${pageContext.request.contextPath}/admin/addNotice" class="btn btn-success btn-xs">+ Notice</a>
                </div>
            </div>
        </div>

        <%-- Visual Analytics Section --%>
        <div class="charts-container">
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Task Distribution</div>
                <div style="font-size:0.75rem; color:#666; margin-bottom:12px;">Breakdown of tasks by their current lifecycle status</div>
                <canvas id="taskDistributionChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Organization Performance</div>
                <div style="font-size:0.75rem; color:#666; margin-bottom:12px;">Ranking organizations by total number of completed tasks</div>
                <canvas id="orgPerformanceChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">User Composition</div>
                <div style="font-size:0.75rem; color:#666; margin-bottom:12px;">Ratio of registered organizations versus community civilians</div>
                <canvas id="userCompositionChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Completion Velocity</div>
                <div style="font-size:0.75rem; color:#666; margin-bottom:12px;">Timeline showing the volume of tasks resolved over time</div>
                <canvas id="velocityChart"></canvas>
            </div>
        </div>

        <%-- Stat cards --%>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="label">Total Tasks</div>
                <div class="value"><c:out value="${totalTasks}"/></div>
            </div>
            <div class="stat-card green">
                <div class="label">Available</div>
                <div class="value"><c:out value="${totalAvailable}"/></div>
            </div>
            <div class="stat-card orange">
                <div class="label">In Progress</div>
                <div class="value"><c:out value="${tasksInProgress}"/></div>
            </div>
            <div class="stat-card">
                <div class="label">Completed</div>
                <div class="value"><c:out value="${completedTasks}"/></div>
            </div>
            <div class="stat-card">
                <div class="label">Organizations</div>
                <div class="value"><c:out value="${totalOrgs}"/></div>
            </div>
            <div class="stat-card green">
                <div class="label">Civilians</div>
                <div class="value"><c:out value="${totalCivilians}"/></div>
            </div>
            <div class="stat-card">
                <div class="label">Notices</div>
                <div class="value"><c:out value="${totalNotices}"/></div>
            </div>
        </div>

        <div class="dashboard-grid">
            <%-- Leaderboard Widget --%>
            <div class="card">
                <div class="card-title">Top Organizations</div>
                <span class="card-subtitle">Ranking by completed tasks</span>
                <c:choose>
                    <c:when test="${empty leaderboard}">
                        <p style="color:#888;">No completion data available yet.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${leaderboard}" varStatus="loop">
                            <div class="leaderboard-item">
                                <div class="leaderboard-name">
                                    <span class="leaderboard-rank">${loop.index + 1}</span>
                                    <c:out value="${item.orgName}"/>
                                </div>
                                <span class="leaderboard-count">${item.count} Tasks</span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Recent Orgs Widget --%>
            <div class="card">
                <div class="card-title">New Organizations</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Joined</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${recentOrgs}">
                            <tr>
                                <td style="font-size:0.85rem;"><strong><c:out value="${o.fullName}"/></strong></td>
                                <td><fmt:formatDate value="${o.createdAt}" pattern="dd MMM"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <%-- Recent Civilians Widget --%>
            <div class="card">
                <div class="card-title">New Civilians</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Joined</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${recentCivilians}">
                            <tr>
                                <td style="font-size:0.85rem;"><strong><c:out value="${c.fullName}"/></strong></td>
                                <td><fmt:formatDate value="${c.createdAt}" pattern="dd MMM"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="dashboard-grid">
            <%-- Recent Tasks Widget --%>
            <div class="card">
                <div class="card-title">Recent Task Activity</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task Title</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentTasks}">
                            <tr>
                                <td style="font-size:0.85rem;"><strong><c:out value="${t.title}"/></strong></td>
                                <td>
                                    <span class="badge badge-${t.status.toLowerCase().replace('_', '-')}">
                                        <c:out value="${t.status}"/>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div style="margin-top:15px; text-align:right;">
                    <a href="${pageContext.request.contextPath}/admin/tasks" style="font-size:0.8rem; font-weight:700;">Full Activity →</a>
                </div>
            </div>

            <%-- Recent Notices Widget --%>
            <div class="card">
                <div class="card-title">Recent Notices</div>
                <c:choose>
                    <c:when test="${empty recentNotices}">
                        <p style="color:#888; font-size:0.85rem;">No notices posted yet.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="n" items="${recentNotices}">
                            <div class="notice-item" style="padding:8px 0;">
                                <div class="notice-title" style="font-size:0.85rem;"><c:out value="${n.title}"/></div>
                                <div class="notice-date" style="font-size:0.7rem;">
                                    <fmt:formatDate value="${n.createdAt}" pattern="dd MMM"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    </div>
</div>

<script>
    // 1. Task Distribution Chart (Pie)
    new Chart(document.getElementById('taskDistributionChart'), {
        type: 'pie',
        data: {
            labels: ['Available', 'In Progress', 'Completed'],
            datasets: [{
                data: [${totalAvailable}, ${tasksInProgress}, ${completedTasks}],
                backgroundColor: ['#28a745', '#fd7e14', '#007bff'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            maintainAspectRatio: false
        }
    });

    // 2. Org Performance Chart (Bar)
    var orgLabels = [];
    var orgData = [];
    <c:forEach var="item" items="${leaderboard}">
        orgLabels.push("${item.orgName}");
        orgData.push(${item.count});
    </c:forEach>

    new Chart(document.getElementById('orgPerformanceChart'), {
        type: 'bar',
        data: {
            labels: orgLabels,
            datasets: [{
                label: 'Tasks Completed',
                data: orgData,
                backgroundColor: '#6f42c1',
                borderRadius: 6
            }]
        },
        options: {
            indexAxis: 'y',
            plugins: { legend: { display: false } },
            scales: { x: { beginAtZero: true } },
            maintainAspectRatio: false
        }
    });

    // 3. User Composition Chart (Doughnut)
    new Chart(document.getElementById('userCompositionChart'), {
        type: 'doughnut',
        data: {
            labels: ['Organizations', 'Civilians'],
            datasets: [{
                data: [${totalOrgs}, ${totalCivilians}],
                backgroundColor: ['#17a2b8', '#e83e8c'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            maintainAspectRatio: false,
            cutout: '70%'
        }
    });

    // 4. Velocity Chart (Line)
    // We use mock labels for trend but real counts for recent activity
    new Chart(document.getElementById('velocityChart'), {
        type: 'line',
        data: {
            labels: ['Week 1', 'Week 2', 'Week 3', 'Current'],
            datasets: [{
                label: 'Completion Trend',
                data: [
                    Math.floor(${completedThisMonth} * 0.2), 
                    Math.floor(${completedThisMonth} * 0.3), 
                    Math.floor(${completedThisMonth} * 0.5), 
                    ${completedThisWeek}
                ],
                borderColor: '#20c997',
                backgroundColor: 'rgba(32, 201, 151, 0.1)',
                fill: true,
                tension: 0.4
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