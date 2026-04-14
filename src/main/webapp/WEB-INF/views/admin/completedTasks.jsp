<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Completed Tasks &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
 <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
 <div class="main">
 <div class="page-header">
 <h1>Completed Tasks</h1>
 <p>All tasks that have been successfully completed.</p>
 </div>
 <div class="card">
 <div class="table-wrap">
 <table>
 <thead>
 <tr>
 <th>#</th>
 <th>Title</th>
 <th>Description</th>
 <th>Completed By</th>
 <th>Created</th>
 <th>Completed On</th>
 </tr>
 </thead>
 <tbody>
 <c:choose>
 <c:when test="${empty tasks}">
 <tr><td colspan="6" style="text-align:center;color:#888;">No completed tasks yet.</td></tr>
 </c:when>
 <c:otherwise>
 <c:forEach var="t" items="${tasks}" varStatus="st">
 <tr>
 <td><c:out value="${st.count}"/></td>
 <td><c:out value="${t.title}"/></td>
 <td><c:out value="${t.description}"/></td>
 <td><c:out value="${not empty t.assignedOrgName ? t.assignedOrgName : '—'}"/></td>
 <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
 <td><fmt:formatDate value="${t.completedAt}" pattern="dd MMM yyyy, HH:mm"/></td>
 </tr>
 </c:forEach>
 </c:otherwise>
 </c:choose>
 </tbody>
 </table>
 </div>
 </div>
 <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
 </div>
</div>
</body>
</html>