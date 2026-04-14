<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard – CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">

    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>

    <div class="main">
        <div class="page-header">
            <h1>Admin Dashboard</h1>
            <p>
                Welcome back, 
                <c:out value="${sessionScope.fullName}"/>. Here’s your overview.
            </p>
        </div>

        <%-- Stat cards --%>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="label">Organizations</div>
                <div class="value"><c:out value="${totalOrgs}"/></div>
            </div>

            <div class="stat-card green">
                <div class="label">Civilians</div>
                <div class="value"><c:out value="${totalCivilians}"/></div>
            </div>

            <div class="stat-card orange">
                <div class="label">Tasks In Progress</div>
                <div class="value"><c:out value="${tasksInProgress}"/></div>
            </div>

            <div class="stat-card">
                <div class="label">Completed Tasks</div>
                <div class="value"><c:out value="${completedTasks}"/></div>
            </div>

            <div class="stat-card">
                <div class="label">Total Tasks</div>
                <div class="value"><c:out value="${totalTasks}"/></div>
            </div>

            <div class="stat-card green">
                <div class="label">Total Notices</div>
                <div class="value"><c:out value="${totalNotices}"/></div>
            </div>
        </div>

        <%-- Recent notices widget --%>
        <div class="card">
            <div class="card-title">📢 Recent Notices</div>

            <c:choose>
                <c:when test="${empty recentNotices}">
                    <p style="color:#888;">No notices posted yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="n" items="${recentNotices}">
                        <div class="notice-item">
                            <div class="notice-title">
                                <c:out value="${n.title}"/>
                            </div>
                            <div class="notice-date">
                                <fmt:formatDate value="${n.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                            </div>
                            <div class="notice-desc">
                                <c:out value="${n.description}"/>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <div style="margin-top:14px;">
                <a href="${pageContext.request.contextPath}/admin/notices" 
                   class="btn btn-primary btn-sm">
                    View All Notices
                </a>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    </div>
</div>
</body>
</html>