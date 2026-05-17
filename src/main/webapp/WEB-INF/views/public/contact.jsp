<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us – CityWatch</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&family=Outfit:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1a3c5e;
            --accent-color: #7ecfff;
            --text-light: #ffffff;
            --bg-gradient: linear-gradient(135deg, #0d253f 0%, #1a3c5e 100%);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            color: var(--text-light);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        /* ── Navigation ── */
        .landing-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background: rgba(13, 37, 63, 0.4);
            backdrop-filter: blur(10px);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            font-family: 'Outfit', sans-serif;
            font-size: 2rem;
            font-weight: 900;
            color: var(--text-light);
            text-decoration: none;
            letter-spacing: 1px;
        }

        .logo span {
            color: var(--accent-color);
        }

        .nav-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: var(--text-light);
        }

        .btn-outline {
            border: 2px solid var(--accent-color);
            color: var(--accent-color);
            padding: 8px 24px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline:hover {
            background: var(--accent-color);
            color: #0d253f;
            box-shadow: 0 0 15px rgba(126, 207, 255, 0.5);
        }

        .btn-filled {
            background: var(--accent-color);
            color: #0d253f;
            padding: 10px 26px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-filled:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(126, 207, 255, 0.3);
        }

        /* ── Contact Section ── */
        .contact-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 20px 60px;
            position: relative;
        }

        .contact-section::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 700px;
            height: 700px;
            background: radial-gradient(circle, rgba(126,207,255,0.1) 0%, rgba(0,0,0,0) 60%);
            z-index: -1;
        }

        .contact-container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.8s ease-out;
        }

        .contact-info {
            flex: 1;
            padding: 50px;
            background: rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .contact-info h2 {
            font-family: 'Outfit', sans-serif;
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--accent-color);
        }

        .contact-info p {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.6;
            margin-bottom: 40px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .info-item i {
            font-size: 1.2rem;
            color: var(--accent-color);
            width: 24px;
            text-align: center;
        }

        .form-area {
            flex: 1.2;
            padding: 50px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: rgba(255, 255, 255, 0.9);
        }

        .form-control {
            width: 100%;
            padding: 14px 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent-color);
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 0 4px rgba(126, 207, 255, 0.1);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .btn-submit {
            width: 100%;
            background: var(--accent-color);
            color: #0d253f;
            padding: 16px;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(126, 207, 255, 0.3);
        }

        .alert {
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 0.95rem;
            text-align: center;
            animation: fadeIn 0.4s ease-out;
        }

        .alert-error {
            background: rgba(255, 82, 82, 0.15);
            border: 1px solid rgba(255, 82, 82, 0.4);
            color: #ff8a80;
        }

        .alert-success {
            background: rgba(126, 207, 255, 0.15);
            border: 1px solid rgba(126, 207, 255, 0.4);
            color: #b9e3ff;
        }

        /* ── Client Validation Errors ── */
        .error-msg {
            color: #ff8a80;
            font-size: 0.8rem;
            margin-top: 5px;
            display: none; /* Hidden by default */
        }
        .form-control.invalid {
            border-color: #ff8a80;
            background: rgba(255, 82, 82, 0.05);
        }
        .form-control.invalid + .error-msg {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 900px) {
            .contact-container { flex-direction: column; }
            .landing-nav { padding: 15px 20px; }
            .contact-info { padding: 30px; }
            .form-area { padding: 30px; }
        }
    </style>
</head>
<body>

    <nav class="landing-nav">
        <a href="${pageContext.request.contextPath}/about" class="logo">CITY<span>WATCH</span></a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/about" class="nav-link">About Us</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-filled">Sign Up</a>
        </div>
    </nav>

    <section class="contact-section">
        <div class="contact-container">
            <div class="contact-info">
                <div>
                    <h2>Get in Touch</h2>
                    <p>Have questions about how CityWatch works? Want to register your organization or report a critical issue directly? Drop us a line and our team will get back to you promptly.</p>
                    
                    <div class="info-item">
                        <i class="fa-solid fa-location-dot"></i>
                        <span>New Road, Kathmandu HQ, Nepal</span>
                    </div>
                    <div class="info-item">
                        <i class="fa-solid fa-phone"></i>
                        <span>+977 1 4220000</span>
                    </div>
                    <div class="info-item">
                        <i class="fa-solid fa-envelope"></i>
                        <span>support@citywatch.gov.np</span>
                    </div>
                </div>
            </div>

            <div class="form-area">
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fa-solid fa-circle-exclamation" style="margin-right: 8px;"></i>
                        <c:out value="${error}"/>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fa-solid fa-circle-check" style="margin-right: 8px;"></i>
                        <c:out value="${success}"/>
                    </div>
                </c:if>

                <form id="contactForm" action="${pageContext.request.contextPath}/contact" method="POST" novalidate>
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control" value="<c:out value='${name}'/>" placeholder="E.g. Binayak Sharma" required minlength="3">
                        <div class="error-msg">Please enter a valid name (at least 3 characters).</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="number">Contact Number</label>
                        <input type="tel" id="number" name="number" class="form-control" value="<c:out value='${number}'/>" placeholder="E.g. 9800000000" required pattern="^[0-9]{10}$">
                        <div class="error-msg">Please enter a valid 10-digit phone number.</div>
                    </div>

                    <div class="form-group">
                        <label for="query">Your Query</label>
                        <textarea id="query" name="query" class="form-control" placeholder="How can we help you?" required minlength="10"><c:out value='${query}'/></textarea>
                        <div class="error-msg">Please provide more details (at least 10 characters).</div>
                    </div>

                    <button type="submit" class="btn-submit">Send Message</button>
                </form>
            </div>
        </div>
    </section>

    <script>
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            let isValid = true;
            
            const name = document.getElementById('name');
            const number = document.getElementById('number');
            const query = document.getElementById('query');

            // Name validation
            if(name.value.trim().length < 3) {
                name.classList.add('invalid');
                isValid = false;
            } else {
                name.classList.remove('invalid');
            }

            // Number validation (simple 10 digit regex)
            const phoneRegex = /^[0-9]{10}$/;
            if(!phoneRegex.test(number.value.trim())) {
                number.classList.add('invalid');
                isValid = false;
            } else {
                number.classList.remove('invalid');
            }

            // Query validation
            if(query.value.trim().length < 10) {
                query.classList.add('invalid');
                isValid = false;
            } else {
                query.classList.remove('invalid');
            }

            if(!isValid) {
                e.preventDefault(); // Stop submission if validation fails
            }
        });

        // Clear validation errors on input
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                this.classList.remove('invalid');
            });
        });
    </script>
</body>
</html>
