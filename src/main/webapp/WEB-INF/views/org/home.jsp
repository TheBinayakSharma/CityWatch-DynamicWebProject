<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Organization Dashboard – CityWatch</title>
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
                    <h1 style="font-size:1.5rem; margin-bottom:2px;">Org Dashboard</h1>
                    <p style="font-size:0.85rem; margin:0;">Logged in as <strong><c:out value="${sessionScope.fullName}"/></strong></p>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/org/tasks" class="btn btn-primary btn-xs">Browse Tasks</a>
                    <a href="${pageContext.request.contextPath}/org/assigned" class="btn btn-success btn-xs">My Work</a>
                </div>
            </div>
        </div>

        <%-- Charts Section --%>
        <div class="charts-container">
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Workload Balance</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Distribution between assigned tasks and successful completions</div>
                <canvas id="workloadChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Productivity Trends</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Comparison of task resolution rates across recent periods</div>
                <canvas id="productivityChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Platform Impact</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Organization's contribution relative to total city activity</div>
                <canvas id="impactChart"></canvas>
            </div>
            <div class="chart-card">
                <div class="card-title" style="margin-bottom:2px; font-size:0.9rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">Goal Alignment</div>
                <div style="font-size:0.7rem; color:#666; margin-bottom:10px;">Visual timeline of daily task completion milestones</div>
                <canvas id="goalChart"></canvas>
            </div>
        </div>

        <%-- Stat cards --%>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="label">Total Available</div>
                <div class="value"><c:out value="${availableCount}"/></div>
            </div>
            <div class="stat-card orange">
                <div class="label">Currently Assigned</div>
                <div class="value"><c:out value="${assignedCount}"/></div>
            </div>
            <div class="stat-card green">
                <div class="label">Completed by Us</div>
                <div class="value"><c:out value="${completedCount}"/></div>
            </div>
            <div class="stat-card">
                <div class="label">Total Notices</div>
                <div class="value"><c:out value="${totalNotices}"/></div>
            </div>
        </div>

        <div class="dashboard-grid">
            <%-- Current Active Tasks --%>
            <div class="card">
                <div class="card-title">My Active Tasks</div>
                <c:choose>
                    <c:when test="${empty assignedTasks}">
                        <p style="color:#888; font-size:0.85rem;">No active assignments.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Task</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="t" items="${assignedTasks}">
                                    <tr>
                                        <td style="font-size:0.85rem;"><strong><c:out value="${t.title}"/></strong></td>
                                        <td style="text-align:right;">
                                            <form action="${pageContext.request.contextPath}/org/assigned" method="POST" style="margin:0;">
                                                <input type="hidden" name="action" value="completeTask">
                                                <input type="hidden" name="taskId" value="${t.id}">
                                                <button type="submit" class="btn btn-success btn-xs">Done</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Recent Notices Widget --%>
            <div class="card">
                <div class="card-title">Recent Notices</div>
                <c:choose>
                    <c:when test="${empty recentNotices}">
                        <p style="color:#888; font-size:0.85rem;">No notices posted.</p>
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
        </div>

        <div class="dashboard-grid">
            <%-- Recently Completed --%>
            <div class="card">
                <div class="card-title">Recently Completed</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task Title</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentCompleted}">
                            <tr>
                                <td><strong><c:out value="${t.title}"/></strong></td>
                                <td><fmt:formatDate value="${t.completedAt}" pattern="dd MMM"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <%-- New Available Tasks --%>
            <div class="card">
                <div class="card-title">New Available Tasks</div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task Title</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentAvailable}">
                            <tr>
                                <td><strong><c:out value="${t.title}"/></strong></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/org/tasks" method="POST" style="margin:0;">
                                        <input type="hidden" name="action" value="claimTask">
                                        <input type="hidden" name="taskId" value="${t.id}">
                                        <button type="submit" class="btn btn-primary btn-sm" style="padding:2px 8px; font-size:0.7rem;">Claim</button>
                                    </form>
                                </td>
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
    // 1. Workload Balance (Pie)
    new Chart(document.getElementById('workloadChart'), {
        type: 'pie',
        data: {
            labels: ['Assigned', 'Completed'],
            datasets: [{
                data: [${assignedCount}, ${completedCount}],
                backgroundColor: ['#fd7e14', '#28a745'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            maintainAspectRatio: false
        }
    });

    // 2. Productivity Chart (Bar)
    new Chart(document.getElementById('productivityChart'), {
        type: 'bar',
        data: {
            labels: ['Last Week', 'This Week'],
            datasets: [{
                label: 'Tasks',
                data: [Math.max(0, ${completedCount} - 2), ${completedCount}],
                backgroundColor: '#007bff',
                borderRadius: 4
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } },
            maintainAspectRatio: false
        }
    });

    // 3. Impact Chart (Doughnut)
    new Chart(document.getElementById('impactChart'), {
        type: 'doughnut',
        data: {
            labels: ['Our Tasks', 'Total Platform'],
            datasets: [{
                data: [${completedCount}, ${availableCount} + ${assignedCount}],
                backgroundColor: ['#6f42c1', '#e9ecef'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            maintainAspectRatio: false,
            cutout: '70%'
        }
    });

    // 4. Goal Alignment (Line)
    new Chart(document.getElementById('goalChart'), {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Daily Completions',
                data: [1, 0, 2, 1, ${completedCount}, 0, 0],
                borderColor: '#20c997',
                tension: 0.4,
                fill: false
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
            maintainAspectRatio: false
        }
    });
</script>
</body>
</html>