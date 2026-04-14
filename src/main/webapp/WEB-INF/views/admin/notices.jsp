<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Notices &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
 <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
 <div class="main">
 <div class="page-header">
 <h1>Notices</h1>
 </div>
 <div class="card">
 <div style="margin-bottom:16px;">
 <a href="${pageContext.request.contextPath}/admin/addNotice" class="btn btn-success btn-sm">+ New Notice</a>
 </div>
 <div class="table-wrap">
 <table>
 <thead>
 <tr>
 <th>#</th>
 <th>Title</th>
 <th>Description</th>
 <th>Posted</th>
 <th>Updated</th>
 <th>Actions</th>
 </tr>
 </thead>
 <tbody>
 <c:choose>
 <c:when test="${empty notices}">
 <tr><td colspan="6" style="text-align:center;color:#888;">No notices yet.</td></tr>
 </c:when>
 <c:otherwise>
 <c:forEach var="n" items="${notices}" varStatus="st">
 <tr>
 <td><c:out value="${st.count}"/></td>
 <td><c:out value="${n.title}"/></td>
 <td><c:out value="${n.description}"/></td>
 <td><fmt:formatDate value="${n.createdAt}" pattern="dd MMM yyyy"/></td>
 <td><fmt:formatDate value="${n.updatedAt}" pattern="dd MMM yyyy"/></td>
 <td>
 <form action="${pageContext.request.contextPath}/admin/notices" method="post" style="display:inline;">
 <input type="hidden" name="action" value="deleteNotice">
 <input type="hidden" name="id" value="${n.id}">
 <button type="submit" class="btn btn-danger btn-sm"
 onclick="return confirm('Delete this notice?')">Delete</button>
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