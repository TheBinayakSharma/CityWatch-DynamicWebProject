<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="auth-wrapper" style="background: linear-gradient(rgba(0, 0, 0, 0.65), rgba(0, 0, 0, 0.65)), url('${pageContext.request.contextPath}/images/auth-bg.png') no-repeat center center / cover fixed;">
    <div class="auth-card">
        <div class="brand-title">CityWatch</div>
        <div class="brand-sub">Reset your password</div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" style="margin-bottom:20px;">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group" style="text-align:left;">
            <label>Username</label>
            <input type="text" name="username" class="form-control" required placeholder="Enter your username">
        </div>
        <div class="form-group" style="text-align:left; margin-top:15px;">
            <label>Registered Email</label>
            <input type="email" name="email" class="form-control" required placeholder="name@example.com">
        </div>
        <button type="submit" class="btn btn-primary" style="width:100%; margin-top:20px;">Generate Reset Token</button>
    </form>

    <div class="auth-links">
        <a href="${pageContext.request.contextPath}/login">Back to Login</a>
    </div>

    </div>
</div>

<c:if test="${not empty token}">
    <div class="modal-overlay show" id="tokenModal">
        <div class="modal-card">
            <h3 style="color:var(--primary); margin-bottom:10px;">Reset Token Generated</h3>
            <p style="font-size:0.9rem;">Copy the token below to update your password:</p>
            <div class="token-box" id="tokenValue">${token}</div>
            <p style="font-size:0.8rem; color:var(--muted); margin-bottom:20px;">Valid for 1 hour.</p>
            <div class="btn-group">
                <button class="btn btn-secondary btn-sm" onclick="copyToken()">Copy Token</button>
                <a href="${pageContext.request.contextPath}/reset-password" class="btn btn-primary btn-sm">Proceed to Update</a>
            </div>
        </div>
    </div>
</c:if>

<script>
    function copyToken() {
        var token = document.getElementById('tokenValue').innerText;
        navigator.clipboard.writeText(token).then(() => {
            alert('Token copied!');
        });
    }
</script>

</body>
</html>