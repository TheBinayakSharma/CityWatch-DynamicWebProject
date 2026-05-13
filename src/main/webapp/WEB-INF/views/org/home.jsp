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
</head>
<body>
<div class="layout">

    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>

    <div class="main">
        <div class="page-header">
            <div style="display:flex; justify-content:space-between; align-items:flex-end;">
                <div>
                    <h1>Org Dashboard</h1>
                    <p>Logged in as <strong><c:out value="${sessionScope.fullName}"/></strong>. Here's your mission overview.</p>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/org/tasks" class="btn btn-primary btn-sm">Browse Available Tasks</a>
                    <a href="${pageContext.request.contextPath}/org/assigned" class="btn btn-success btn-sm">View My Assignments</a>
                </div>
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
                <div class="card-title">⏳ My Active Tasks</div>
                <span class="card-subtitle">Tasks currently in progress by your team</span>
                <c:choose>
                    <c:when test="${empty assignedTasks}">
                        <p style="color:#888;">You have no active assignments.</p>
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
                                        <td><strong><c:out value="${t.title}"/></strong></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/org/assigned" method="POST" style="margin:0;">
                                                <input type="hidden" name="action" value="completeTask">
                                                <input type="hidden" name="taskId" value="${t.id}">
                                                <button type="submit" class="btn btn-success btn-sm" style="padding:2px 8px; font-size:0.7rem;">Complete</button>
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
                <div class="card-title">📢 Recent Notices</div>
                <span class="card-subtitle">Latest government announcements</span>
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
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="dashboard-grid">
            <%-- Recently Completed --%>
            <div class="card">
                <div class="card-title">✅ Recently Completed</div>
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
                <div class="card-title">🆕 New Available Tasks</div>
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
</body>
</html>