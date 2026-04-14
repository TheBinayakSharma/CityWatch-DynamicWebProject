<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Reusable page header bar inside .main --%>
<div class="page-header">
 <h1><c:out value="${pageTitle}"/></h1>
 <c:if test="${not empty pageSubtitle}">
 <p><c:out value="${pageSubtitle}"/></p>
 </c:if>
</div>