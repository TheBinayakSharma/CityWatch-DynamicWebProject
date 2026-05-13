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
</head>
<body>
<div class="layout">

    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>

    <div class="main">
        <div class="page-header">
            <div style="display:flex; justify-content:space-between; align-items:flex-end;">
                <div>
                    <h1>Civilian Portal</h1>
                    <p>Welcome, <strong><c:out value="${sessionScope.fullName}"/></strong>. Monitor your city's progress below.</p>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/civilian/myRequests" class="btn btn-primary btn-sm">&#x1F4DD; My Requests</a>
                    <a href="${pageContext.request.contextPath}/civilian/requestTask" class="btn btn-success btn-sm">+ New Request</a>
                </div>
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
            <%-- Recent Notices Widget --%>
            <div class="card">
                <div class="card-title">📢 Government Notices</div>
                <span class="card-subtitle">Latest official bulletins</span>
                <c:choose>
                    <c:when test="${empty recentNotices}">
                        <p style="color:#888;">No recent notices found.</p>
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

            <%-- Recently Completed --%>
            <div class="card">
                <div class="card-title">✅ Recently Completed Tasks</div>
                <span class="card-subtitle">Transparency view of recent improvements</span>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task</th>
                            <th>By Organization</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentCompleted}">
                            <tr>
                                <td><strong><c:out value="${t.title}"/></strong></td>
                                <td><c:out value="${t.assignedOrgName}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="dashboard-grid">
            <%-- Tasks In Progress --%>
            <div class="card">
                <div class="card-title">⏳ Currently In Progress</div>
                <span class="card-subtitle">Active city projects and handling teams</span>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Project</th>
                            <th>Handling Organization</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${inProgressWithOrg}">
                            <tr>
                                <td><strong><c:out value="${t.title}"/></strong></td>
                                <td><c:out value="${t.assignedOrgName}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <%-- Newly Posted Available Tasks --%>
            <div class="card">
                <div class="card-title">🆕 Newly Posted Tasks</div>
                <span class="card-subtitle">Pending organization claims</span>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Task Title</th>
                            <th>Posted Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${recentAvailable}">
                            <tr>
                                <td><strong><c:out value="${t.title}"/></strong></td>
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
</body>
</html>
