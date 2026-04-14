<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>CityWatch &ndash; Forgot Password</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
 <div class="auth-card">
 <div class="brand-title">CityWatch</div>
 <div class="brand-sub">Reset your password</div>
 
 <c:if test="${not empty error}">
 <div class="alert alert-danger"><c:out value="${error}"/></div>
 </c:if>
 <c:if test="${not empty info}">
 <div class="alert alert-info"><c:out value="${info}"/></div>
 <p style="font-size:0.85rem; color:#555; margin-bottom:16px;">
 Use the token above at the
 <a href="${pageContext.request.contextPath}/reset-password">Reset Password</a> page.
 </p>
 </c:if>
 
 <form action="${pageContext.request.contextPath}/forgot-password" method="post">
 <div class="form-group">
 <label>Registered Email</label>
 <input type="email" name="email" class="form-control" placeholder="your@email.com" required>
 </div>
 <button type="submit" class="btn btn-primary" style="width:100%; padding:11px;">Send Reset Token</button>
 </form>
 
 <div class="auth-links">
 <a href="${pageContext.request.contextPath}/login">Back to Login</a>
 </div>
 </div>
</div>
</body>
</html>