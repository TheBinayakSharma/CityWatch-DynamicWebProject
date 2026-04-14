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
 <p>Public notices from the government.</p>
 </div>
 <div class="card">
 <div class="table-wrap">
 <table>
 <thead>
 <tr><th>#</th><th>Title</th><th>Content</th><th>Posted</th></tr>
 </thead>
 <tbody>
 <c:choose>
 <c:when test="${empty notices}">
 <tr><td colspan="4" style="text-align:center;color:#888;">No notices posted yet.</td></tr>
 </c:when>
 <c:otherwise>
 <c:forEach var="n" items="${notices}" varStatus="st">
 <tr>
 <td><c:out value="${st.count}"/></td>
 <td><c:out value="${n.title}"/></td>
 <td><c:out value="${n.description}"/></td>
 <td><fmt:formatDate value="${n.createdAt}" pattern="dd MMM yyyy"/></td>
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