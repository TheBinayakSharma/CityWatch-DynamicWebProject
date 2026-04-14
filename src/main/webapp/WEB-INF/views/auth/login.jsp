<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>CityWatch &ndash; Login</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
 <div class="auth-card">
 <div class="brand-title">CityWatch</div>
 <div class="brand-sub">Government &bull; Organizations &bull; Civilians</div>
 <c:if test="${not empty error}">
 <div class="alert alert-danger"><c:out value="${error}"/></div>
 </c:if>
 <c:if test="${param.success == 'registered'}">
 <div class="alert alert-success">Registration successful. Please log in.</div>
 </c:if>
 <c:if test="${param.success == 'passwordReset'}">
 <div class="alert alert-success">Password reset successfully. Please log in.</div>
 </c:if>
 <form action="${pageContext.request.contextPath}/login" method="post">
 <div class="form-group">
 <label for="username">Username</label>
 <input type="text" id="username" name="username" class="form-control"
 placeholder="Enter username" required autofocus>
 </div>
 <div class="form-group">
 <label for="password">Password</label>
 <input type="password" id="password" name="password" class="form-control"
 placeholder="Enter password" required>
 </div>
 <button type="submit" class="btn btn-primary" style="width:100%; padding:11px;">Login</button>
 </form>
 <div class="auth-links">
 <a href="${pageContext.request.contextPath}/register">Create an account</a>
 &nbsp;&bull;&nbsp;
 <a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a>
 </div>
 </div>
</div>
</body>
</html>