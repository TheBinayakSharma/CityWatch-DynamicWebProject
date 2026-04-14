<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Error &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
 <div class="auth-card" style="text-align:center;">
 <div class="brand-title" style="color:#c62828;">
 <c:choose>
 <c:when test="${not empty pageContext.errorData.statusCode}">
 <c:out value="${pageContext.errorData.statusCode}"/>
 </c:when>
 <c:otherwise>Error</c:otherwise>
 </c:choose>
 </div>
 <div class="brand-sub">Something went wrong</div>
 
 <c:if test="${not empty errorMsg}">
 <div class="alert alert-danger" style="text-align:left;"><c:out value="${errorMsg}"/></div>
 </c:if>
 
 <c:choose>
 <c:when test="${pageContext.errorData.statusCode == 404}">
 <p style="color:#555; margin-bottom:20px;">The page you are looking for does not exist.</p>
 </c:when>
 <c:when test="${pageContext.errorData.statusCode == 403}">
 <p style="color:#555; margin-bottom:20px;">You do not have permission to access this page.</p>
 </c:when>
 <c:otherwise>
 <p style="color:#555; margin-bottom:20px;">
 An unexpected error occurred. Please try again or contact the administrator.
 </p>
 </c:otherwise>
 </c:choose>
 
 <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Back to Login</a>
 </div>
</div>
</body>
</html>