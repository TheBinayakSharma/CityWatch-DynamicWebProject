<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CityWatch &ndash; Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .step-transition {
            transition: opacity 0.3s ease, transform 0.3s ease;
        }
        .hidden {
            display: none;
            opacity: 0;
            transform: translateY(10px);
        }
        .visible {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card" style="max-width:500px;">
        <div class="brand-title">CityWatch</div>
        <div class="brand-sub">Join the community</div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" style="margin-bottom: 20px;">
                <c:choose>
                    <c:when test="${error == 'fullName'}">Full name is required and must not contain digits.</c:when>
                    <c:when test="${error == 'username'}">Username is required or already taken.</c:when>
                    <c:when test="${error == 'password'}">Password must be at least 6 characters.</c:when>
                    <c:when test="${error == 'email'}">Invalid email or email already registered.</c:when>
                    <c:when test="${error == 'phone'}">Phone must be 10 digits and unique.</c:when>
                    <c:when test="${error == 'role'}">Please select a valid role.</c:when>
                    <c:otherwise><c:out value="${error}"/></c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registrationForm">
            <!-- Step 1: Select Role -->
            <div id="step-1">
                <div class="form-group">
                    <label>How will you use CityWatch?</label>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 10px;">
                        <div class="role-card" onclick="selectRole('CIVILIAN')" id="role-CIVILIAN" 
                             style="border: 2px solid #ddd; padding: 20px; border-radius: 8px; cursor: pointer; text-align: center; transition: 0.3s;">
                            <div style="font-size: 2rem; margin-bottom: 10px;">👤</div>
                            <div style="font-weight: 700;">Civilian</div>
                            <div style="font-size: 0.8rem; color: var(--muted);">Report issues near you</div>
                        </div>
                        <div class="role-card" onclick="selectRole('ORGANIZATION')" id="role-ORGANIZATION"
                             style="border: 2px solid #ddd; padding: 20px; border-radius: 8px; cursor: pointer; text-align: center; transition: 0.3s;">
                            <div style="font-size: 2rem; margin-bottom: 10px;">🏢</div>
                            <div style="font-weight: 700;">Organization</div>
                            <div style="font-size: 0.8rem; color: var(--muted);">Manage and solve tasks</div>
                        </div>
                    </div>
                    <input type="hidden" name="role" id="selected-role" required>
                </div>
            </div>

            <!-- Step 2: Form Details -->
            <div id="step-2" class="hidden step-transition">
                <div style="margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                    <button type="button" onclick="showStep(1)" style="background:none; border:none; color:var(--primary); cursor:pointer; font-weight:700;">&larr; Back</button>
                    <span id="role-label" style="text-transform: uppercase; font-size: 0.75rem; font-weight: 700; color: var(--primary); background: #eef2ff; padding: 2px 10px; border-radius: 20px;"></span>
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="full_name" class="form-control" placeholder="Your full name" required>
                </div>

                <div id="org-fields" class="hidden">
                    <div class="form-group">
                        <label>Organization Name</label>
                        <input type="text" name="org_name" id="org_name_input" class="form-control" placeholder="Agency / NGO Name">
                    </div>
                    <div class="form-group">
                        <label>Organization Type</label>
                        <input type="text" name="org_type" class="form-control" placeholder="Health, Environment, etc.">
                    </div>
                </div>

                <div id="civ-fields" class="hidden">
                    <div class="form-group">
                        <label>Ward No.</label>
                        <input type="number" name="ward_no" class="form-control" placeholder="1-32" min="1">
                    </div>
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Choose a unique ID" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="your@email.com" required>
                </div>

                <div class="form-group">
                    <label>Phone / Contact</label>
                    <input type="text" name="phone" id="phone_field" class="form-control" placeholder="98XXXXXXXX" required>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" class="form-control" placeholder="Street, City" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="At least 6 characters" required>
                </div>

                <button type="submit" class="btn btn-primary" style="width:100%; margin-top:10px; padding:12px;">Create Account</button>
            </div>
        </form>

        <div class="auth-links">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
</div>

<script>
    function selectRole(role) {
        // Update UI markers
        document.querySelectorAll('.role-card').forEach(c => {
            c.style.borderColor = '#ddd';
            c.style.background = 'none';
        });
        const active = document.getElementById('role-' + role);
        active.style.borderColor = 'var(--primary)';
        active.style.background = '#f5f7ff';

        document.getElementById('selected-role').value = role;
        document.getElementById('role-label').innerText = role;

        // Toggle role specific sub-fields
        document.getElementById('org-fields').classList.toggle('hidden', role !== 'ORGANIZATION');
        document.getElementById('civ-fields').classList.toggle('hidden', role !== 'CIVILIAN');
        
        // Validation settings
        document.getElementById('org_name_input').required = (role === 'ORGANIZATION');

        // Go to next step
        showStep(2);
    }

    function showStep(s) {
        if (s === 1) {
            document.getElementById('step-1').style.display = 'block';
            document.getElementById('step-2').classList.remove('visible');
            document.getElementById('step-2').classList.add('hidden');
        } else {
            document.getElementById('step-1').style.display = 'none';
            document.getElementById('step-2').classList.remove('hidden');
            document.getElementById('step-2').classList.add('visible');
        }
    }
    
    // Auto-detect if we returned with an error (keep role selected)
    window.onload = function() {
        const role = '${param.role}';
        if (role) selectRole(role);
    };
</script>
</body>
</html>