<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="auth-wrapper" style="background: linear-gradient(rgba(0, 0, 0, 0.65), rgba(0, 0, 0, 0.65)), url('${pageContext.request.contextPath}/images/auth-bg.png') no-repeat center center / cover fixed;">
    <div class="auth-card">
        <div class="brand-title">CityWatch</div>
        <div class="brand-sub">Enter your new password</div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" style="margin-bottom:20px;">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <div class="form-group" style="text-align:left;">
            <label>Reset Token</label>
            <input type="text" name="token" class="form-control" required placeholder="Paste your token here">
        </div>
        <div class="form-group" style="text-align:left; margin-top:15px;">
            <label>New Password</label>
            <input type="password" name="newPassword" class="form-control" required minlength="6" placeholder="At least 6 characters">
        </div>
        <div class="form-group" style="text-align:left; margin-top:15px;">
            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" required minlength="6" placeholder="Confirm your new password">
        </div>
        <button type="submit" class="btn btn-primary" style="width:100%; margin-top:20px;">Update Password</button>
    </form>

    <div class="auth-links">
        <a href="${pageContext.request.contextPath}/login">Back to Login</a>
    </div>

    </div>
</div>

</body>
</html>
