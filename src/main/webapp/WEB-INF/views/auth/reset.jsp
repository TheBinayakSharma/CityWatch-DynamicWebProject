<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password &ndash; CityWatch</title>
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
        .auth-container h2 { margin-bottom: 10px; color: var(--primary); }
        .auth-container p { color: var(--muted); margin-bottom: 25px; }
        
        .modal-overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            backdrop-filter: blur(4px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            visibility: hidden;
            opacity: 0;
            transition: 0.3s;
        }
        .modal-overlay.show { visibility: visible; opacity: 1; }
        .modal-card {
            background: var(--white);
            padding: 30px;
            border-radius: var(--radius);
            width: 90%;
            max-width: 450px;
            text-align: center;
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
        }
        .token-box {
            background: #f8f9fa;
            border: 2px dashed var(--primary);
            padding: 15px;
            font-family: monospace;
            font-size: 1.2rem;
            margin: 20px 0;
            word-break: break-all;
            color: var(--primary);
        }
    </style>
</head>
<body>

<div class="auth-container">
    <h2>Forgot Password?</h2>
    <p>Enter your username and we'll generate a reset token for you.</p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" style="margin-bottom:20px;">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group" style="text-align:left;">
            <label>Username</label>
            <input type="text" name="username" class="form-control" required placeholder="Enter your username">
        </div>
        <button type="submit" class="btn btn-primary" style="width:100%; margin-top:10px;">Send Reset Link</button>
    </form>

    <div style="margin-top:20px;">
        <a href="${pageContext.request.contextPath}/login" style="color:var(--muted); font-size:0.9rem;">Back to Login</a>
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