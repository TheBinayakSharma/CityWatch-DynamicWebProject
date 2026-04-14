<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>CityWatch &ndash; Register</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
 <div class="auth-card" style="max-width:500px;">
 <div class="brand-title">CityWatch</div>
 <div class="brand-sub">Create your account</div>
 <%-- Inline field errors --%>
 <c:if test="${error == 'fullName'}">
 <div class="alert alert-danger">Full name is required and must not contain digits.</div>
 </c:if>
 <c:if test="${error == 'username'}">
 <div class="alert alert-danger">Username is required or already taken.</div>
 </c:if>
 <c:if test="${error == 'password'}">
 <div class="alert alert-danger">Password must be at least 6 characters.</div>
 </c:if>
 <c:if test="${error == 'email'}">
 <div class="alert alert-danger">Invalid email or email already registered.</div>
 </c:if>
 <c:if test="${error == 'phone'}">
 <div class="alert alert-danger">Phone must be 10 digits and not already registered.</div>
 </c:if>
 <c:if test="${error == 'role'}">
 <div class="alert alert-danger">Please select a valid role.</div>
 </c:if>
 <c:if test="${not empty error && error != 'fullName' && error != 'username'
 && error != 'password' && error != 'email' && error != 'phone' && error != 'role'}">
 <div class="alert alert-danger"><c:out value="${error}"/></div>
 </c:if>
 <form action="${pageContext.request.contextPath}/register" method="post">
 <div class="form-group">
 <label>Full Name</label>
 <input type="text" name="full_name" class="form-control" placeholder="Your full name" required>
 </div>
 <div class="form-group">
 <label>Username</label>
 <input type="text" name="username" class="form-control" placeholder="Choose a username" required>
 </div>
 <div class="form-group">
 <label>Password</label>
 <input type="password" name="password" class="form-control" placeholder="Min. 6 characters" required>
 </div>
 <div class="form-group">
 <label>Email</label>
 <input type="email" name="email" class="form-control" placeholder="your@email.com" required>
 </div>
 <div class="form-group">
 <label>Phone (10 digits)</label>
 <input type="text" name="phone" class="form-control" placeholder="98XXXXXXXX" required>
 </div>
 <div class="form-group">
 <label>Role</label>
 <select name="role" class="form-control" required onchange="toggleOrgFields(this.value)">
 <option value="">-- Select Role --</option>
 <option value="ORGANIZATION">Organization (NGO/Agency)</option>
 <option value="CIVILIAN">Civilian</option>
 </select>
 </div>
 <%-- Organization extra fields --%>
 <div id="org-fields" style="display:none;">
 <div class="form-group">
 <label>Organization Name</label>
 <input type="text" name="org_name" class="form-control" placeholder="NGO / Agency name">
 </div>
 <div class="form-group">
 <label>Organization Type</label>
 <input type="text" name="org_type" class="form-control" placeholder="e.g. Environmental, Health">
 </div>
 </div>
 <%-- Civilian extra fields --%>
 <div id="civ-fields" style="display:none;">
 <div class="form-group">
 <label>Ward No.</label>
 <input type="number" name="ward_no" class="form-control" placeholder="Ward number" min="1">
 </div>
 </div>
 <div class="form-group">
 <label>Address</label>
 <input type="text" name="address" class="form-control" placeholder="Your address">
 </div>
 <button type="submit" class="btn btn-primary" style="width:100%; padding:11px;">Register</button>
 </form>
 <div class="auth-links">
 Already have an account? <a href="${pageContext.request.contextPath}/login">Login</a>
 </div>
 </div>
</div>
<script>
 function toggleOrgFields(role) {
 document.getElementById('org-fields').style.display = role === 'ORGANIZATION' ? 'block' : 'none';
 document.getElementById('civ-fields').style.display = role === 'CIVILIAN' ? 'block' : 'none';
 }
</script>
</body>
</html>