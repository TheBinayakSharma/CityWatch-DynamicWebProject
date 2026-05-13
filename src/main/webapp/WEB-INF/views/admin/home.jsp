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
</head>
<body>
<div class="layout">

    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>

    <div class="main">
        <div class="page-header">
            <div style="display:flex; justify-content:space-between; align-items:flex-end;">
                <div>
                    <h1>System Overview</h1>
                    <p>Welcome back, <strong><c:out value="${sessionScope.fullName}"/></strong>. Here is the latest system activity.</p>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/admin/addTask" class="btn btn-primary btn-sm">+ New Task</a>
                    <a href="${pageContext.request.contextPath}/admin/addNotice" class="btn btn-success btn-sm">+ New Notice</a>
                </div>
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
                <div class="card-title">🏆 Top Organizations</div>
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

            <%-- Recent Notices Widget --%>
            <div class="card">
                <div class="card-title">📢 Recent Notices</div>
                <span class="card-subtitle">Last 5 bulletins posted</span>
                <c:choose>
                    <c:when test="${empty recentNotices}">
                        <p style="color:#888;">No notices posted yet.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="n" items="${recentNotices}">
                            <div class="notice-item">
                                <div class="notice-title"><c:out value="${n.title}"/></div>
                                <div class="notice-date">
                                    <fmt:formatDate value="${n.createdAt}" pattern="dd MMM yyyy"/>
                                </div>
                                <div class="notice-desc" style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                                    <c:out value="${n.description}"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Recent Orgs Widget --%>
            <div class="card">
                <div class="card-title">🏢 New Organizations</div>
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
                                <td><strong><c:out value="${o.fullName}"/></strong></td>
                                <td><fmt:formatDate value="${o.createdAt}" pattern="dd MMM"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div style="margin-top:15px; text-align:right;">
                    <a href="${pageContext.request.contextPath}/admin/orgs" style="font-size:0.8rem; font-weight:700;">Manage Organizations →</a>
                </div>
            </div>

            <%-- Recent Civilians Widget --%>
            <div class="card">
                <div class="card-title">👥 New Civilians</div>
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
                                <td><strong><c:out value="${c.fullName}"/></strong></td>
                                <td><fmt:formatDate value="${c.createdAt}" pattern="dd MMM"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div style="margin-top:15px; text-align:right;">
                    <a href="${pageContext.request.contextPath}/admin/civilians" style="font-size:0.8rem; font-weight:700;">Manage Civilians →</a>
                </div>
            </div>
        </div>

        <%-- Recent Tasks Full Width --%>
        <div class="card">
            <div class="card-title">📋 Recent Task Activity</div>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Task Title</th>
                        <th>Assigned To</th>
                        <th>Created</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${recentTasks}">
                        <tr>
                            <td><strong><c:out value="${t.title}"/></strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty t.assignedOrgName}">
                                        <c:out value="${t.assignedOrgName}"/>
                                    </c:when>
                                    <c:otherwise><span style="color:#999;">Unassigned</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM, HH:mm"/></td>
                            <td>
                                <span class="badge badge-${t.status.toLowerCase().replace('_', '-')}">
                                    <c:out value="${t.status}"/>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    </div>
</div>
</body>
</html>