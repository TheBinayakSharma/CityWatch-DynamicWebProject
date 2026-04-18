<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .auth-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 40px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }
        .auth-container h2 { margin-bottom: 15px; color: var(--primary); }
        .auth-container p { color: var(--muted); margin-bottom: 25px; }
    </style>
</head>
<body>

<div class="auth-container">
    <h2>Update Password</h2>
    <p>Enter your reset token and your new password.</p>

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

    <div style="margin-top:20px;">
        <a href="${pageContext.request.contextPath}/login" style="color:var(--muted); font-size:0.9rem;">Back to Login</a>
    </div>
</div>

</body>
</html>
