<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Available Tasks &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
 <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
 <div class="main">
 <div class="page-header">
 <h1>Available Tasks</h1>
 <p>Claim a task to start working on it.</p>
 </div>
 <div class="card">
 <div class="table-wrap">
 <table>
 <thead>
 <tr><th>#</th><th>Title</th><th>Description</th><th>Posted</th><th>Action</th></tr>
 </thead>
 <tbody>
 <c:choose>
 <c:when test="${empty tasks}">
 <tr><td colspan="5" style="text-align:center;color:#888;">No tasks available right now.</td></tr>
 </c:when>
 <c:otherwise>
 <c:forEach var="t" items="${tasks}" varStatus="st">
 <tr>
 <td><c:out value="${st.count}"/></td>
 <td><c:out value="${t.title}"/></td>
 <td><c:out value="${t.description}"/></td>
 <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
 <td>
 <form action="${pageContext.request.contextPath}/org/tasks" method="post">
 <input type="hidden" name="action" value="claimTask">
 <input type="hidden" name="taskId" value="${t.id}">
 <button type="submit" class="btn btn-success btn-sm"
 onclick="return confirm('Claim this task?')">Claim</button>
 </form>
 </td>
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
