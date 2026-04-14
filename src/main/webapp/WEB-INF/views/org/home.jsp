<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Organization Dashboard &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
 <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
 <div class="main">
 <div class="page-header">
 <h1>Organization Dashboard</h1>
 <p>Welcome, <c:out value="${sessionScope.fullName}"/>.</p>
 </div>
 <div class="stats-grid">
 <div class="stat-card">
 <div class="label">Available Tasks</div>
 <div class="value"><c:out value="${availableCount}"/></div>
 </div>
 <div class="stat-card orange">
 <div class="label">My Active Tasks</div>
 <div class="value"><c:out value="${assignedCount}"/></div>
 </div>
 <div class="stat-card green">
 <div class="label">Completed by Us</div>
 <div class="value"><c:out value="${completedCount}"/></div>
 </div>
 </div>
 <div class="card">
 <div class="card-title">&#x1F4E2; Recent Notices</div>
 <c:choose>
 <c:when test="${empty recentNotices}">
 <p style="color:#888;">No notices yet.</p>
 </c:when>
 <c:otherwise>
 <c:forEach var="n" items="${recentNotices}">
 <div class="notice-item">
 <div class="notice-title"><c:out value="${n.title}"/></div>
 <div class="notice-date"><fmt:formatDate value="${n.createdAt}" pattern="dd MMM yyyy, HH:mm"/></div>
 <div class="notice-desc"><c:out value="${n.description}"/></div>
 </div>
 </c:forEach>
 </c:otherwise>
 </c:choose>
 <div style="margin-top:14px;">
 <a href="${pageContext.request.contextPath}/org/notices" class="btn btn-primary btn-sm">View All Notices</a>
 </div>
 </div>
 <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
 </div>
</div>
</body>
</html>