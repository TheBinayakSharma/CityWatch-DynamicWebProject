<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About CityWatch – Building a Smarter Nepal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&family=Outfit:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1a3c5e;
            --accent-color: #7ecfff;
            --text-light: #ffffff;
            --bg-gradient: linear-gradient(135deg, #0d253f 0%, #1a3c5e 100%);
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
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
            overflow-x: hidden;
            line-height: 1.6;
        }

        /* ── Navigation ── */
        .landing-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background: rgba(13, 37, 63, 0.8);
            backdrop-filter: blur(15px);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--glass-border);
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

        /* ── Hero Section ── */
        .hero {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 180px 50px 100px;
            text-align: center;
            position: relative;
            min-height: 80vh;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 800px;
            height: 800px;
            background: radial-gradient(circle, rgba(126,207,255,0.12) 0%, rgba(0,0,0,0) 70%);
            z-index: -1;
        }

        .hero-content {
            max-width: 1000px;
            animation: fadeInUp 1s ease-out;
        }

        .hero h1 {
            font-family: 'Outfit', sans-serif;
            font-size: 5rem;
            line-height: 1.1;
            margin-bottom: 30px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }

        .hero h1 span {
            background: linear-gradient(135deg, #7ecfff, #b9e3ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.85);
            margin-bottom: 50px;
            line-height: 1.8;
            max-width: 800px;
            margin-inline: auto;
        }

        .action-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        /* ── Section Titles ── */
        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title h2 {
            font-family: 'Outfit', sans-serif;
            font-size: 3rem;
            color: var(--text-light);
            margin-bottom: 15px;
        }

        .section-title p {
            color: rgba(255,255,255,0.7);
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        /* ── Core Pillars (Mission) ── */
        .mission-section {
            padding: 80px 50px;
            max-width: 1300px;
            margin: 0 auto;
        }

        .grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 40px;
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 50px 40px;
            text-align: left;
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .glass-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 4px;
            background: var(--accent-color);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }

        .glass-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            border-color: rgba(126, 207, 255, 0.3);
        }

        .glass-card:hover::before {
            transform: scaleX(1);
        }

        .glass-card i {
            font-size: 3rem;
            color: var(--accent-color);
            margin-bottom: 25px;
        }

        .glass-card h3 {
            font-family: 'Outfit', sans-serif;
            font-size: 1.6rem;
            margin-bottom: 15px;
        }

        .glass-card p {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.6;
            font-size: 1.05rem;
        }

        /* ── How It Works (Timeline) ── */
        .how-it-works {
            background: rgba(0, 0, 0, 0.2);
            padding: 100px 50px;
            border-top: 1px solid var(--glass-border);
            border-bottom: 1px solid var(--glass-border);
        }

        .timeline {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 40px;
            left: 50px;
            right: 50px;
            height: 2px;
            background: var(--glass-border);
            z-index: 0;
        }

        .step {
            flex: 1;
            text-align: center;
            position: relative;
            z-index: 1;
            padding: 0 20px;
        }

        .step-icon {
            width: 80px;
            height: 80px;
            background: var(--primary-color);
            border: 2px solid var(--accent-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: var(--accent-color);
            margin: 0 auto 25px;
            box-shadow: 0 0 20px rgba(0,0,0,0.5);
        }

        .step h4 {
            font-family: 'Outfit', sans-serif;
            font-size: 1.3rem;
            margin-bottom: 10px;
        }

        .step p {
            font-size: 0.95rem;
            color: rgba(255,255,255,0.7);
        }

        /* ── Feature Split Section ── */
        .feature-split {
            max-width: 1300px;
            margin: 100px auto;
            padding: 0 50px;
            display: flex;
            align-items: center;
            gap: 60px;
        }

        .feature-split.reverse {
            flex-direction: row-reverse;
        }

        .feature-text {
            flex: 1;
        }

        .feature-text h2 {
            font-family: 'Outfit', sans-serif;
            font-size: 2.8rem;
            margin-bottom: 25px;
            color: var(--text-light);
        }

        .feature-text p {
            font-size: 1.15rem;
            color: rgba(255, 255, 255, 0.75);
            margin-bottom: 25px;
        }

        .feature-visual {
            flex: 1;
            height: 400px;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 25px 50px rgba(0,0,0,0.2);
            position: relative;
        }

        .feature-visual i {
            font-size: 8rem;
            color: rgba(126, 207, 255, 0.2);
        }

        /* ── Bottom CTA ── */
        .bottom-cta {
            text-align: center;
            padding: 100px 20px;
            background: radial-gradient(circle at center, rgba(126,207,255,0.1) 0%, rgba(0,0,0,0) 60%);
        }

        .bottom-cta h2 {
            font-family: 'Outfit', sans-serif;
            font-size: 3.5rem;
            margin-bottom: 20px;
        }

        .bottom-cta p {
            font-size: 1.2rem;
            color: rgba(255,255,255,0.7);
            margin-bottom: 40px;
        }

        /* ── Footer ── */
        footer {
            background: #091a2e;
            padding: 40px 50px;
            text-align: center;
            border-top: 1px solid var(--glass-border);
            color: rgba(255,255,255,0.5);
            font-size: 0.9rem;
        }

        footer a {
            color: var(--accent-color);
            text-decoration: none;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 992px) {
            .feature-split, .feature-split.reverse { flex-direction: column; text-align: center; }
            .timeline { flex-direction: column; gap: 40px; }
            .timeline::before { display: none; }
            .hero h1 { font-size: 3.5rem; }
        }
    </style>
</head>
<body>

    <nav class="landing-nav">
        <a href="${pageContext.request.contextPath}/about" class="logo">CITY<span>WATCH</span></a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact Us</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-filled">Sign Up</a>
        </div>
    </nav>

    <!-- 1. HERO -->
    <header class="hero">
        <div class="hero-content">
            <h1>Empowering Citizens.<br>Building a <span>Smarter City.</span></h1>
            <p>
                CityWatch is a unified, transparent platform connecting civilians, local organizations, and government entities to collaboratively address, manage, and resolve civic issues in real-time across Nepal.
            </p>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/register" class="btn-filled" style="padding: 16px 45px; font-size: 1.15rem;">Join the Movement</a>
                <a href="#explore" class="btn-outline" style="padding: 14px 45px; font-size: 1.15rem; border-width: 2px;">Explore Features</a>
            </div>
        </div>
    </header>

    <!-- 2. THE PROBLEM WE SOLVE (SPLIT) -->
    <section id="explore" class="feature-split">
        <div class="feature-visual">
            <i class="fa-solid fa-city"></i>
            <div style="position:absolute; bottom: 30px; background: rgba(0,0,0,0.5); padding: 15px 30px; border-radius: 30px; font-weight: bold; border: 1px solid var(--accent-color);">Unified Civic Management</div>
        </div>
        <div class="feature-text">
            <h2>Bridging the Gap Between Citizens and Action</h2>
            <p>For too long, reporting civic issues like broken infrastructure, waste mismanagement, or utility failures has been a frustrating, opaque process. Citizens report problems into a void, never knowing if or when action will be taken.</p>
            <p>CityWatch changes the paradigm. We provide a centralized digital hub where civilian reports are instantly visible to verified local organizations and government authorities, ensuring accountability and rapid deployment of resources.</p>
        </div>
    </section>

    <!-- 3. CORE PILLARS (MISSION CARDS) -->
    <section class="mission-section">
        <div class="section-title">
            <h2>Our Core Pillars</h2>
            <p>The fundamental principles that drive the CityWatch platform and guarantee community success.</p>
        </div>
        <div class="grid-3">
            <div class="glass-card">
                <i class="fa-solid fa-bullhorn"></i>
                <h3>Voice Your Concerns</h3>
                <p>We believe every citizen has the right to a safe and clean environment. Easily report civic issues directly from your neighborhood. Your voice immediately alerts the relevant authorities.</p>
            </div>
            <div class="glass-card">
                <i class="fa-solid fa-handshake-angle"></i>
                <h3>Collaborative Action</h3>
                <p>We bridge the gap between government bodies and local NGOs. When a task is reported, verified organizations can claim, manage, and resolve the issue transparently on our platform.</p>
            </div>
            <div class="glass-card">
                <i class="fa-solid fa-chart-line"></i>
                <h3>Real-Time Transparency</h3>
                <p>Stay informed with live updates. Track the progress of city-wide projects, view organizational impact, and read official government notices all in one unified, data-driven portal.</p>
            </div>
        </div>
    </section>

    <!-- 4. HOW IT WORKS (TIMELINE) -->
    <section class="how-it-works">
        <div class="section-title">
            <h2>How CityWatch Works</h2>
            <p>From a civilian's report to a completed community project in four simple steps.</p>
        </div>
        <div class="timeline">
            <div class="step">
                <div class="step-icon"><i class="fa-solid fa-pen-to-square"></i></div>
                <h4>1. Report</h4>
                <p>A civilian identifies a civic issue and submits a detailed request via the CityWatch portal.</p>
            </div>
            <div class="step">
                <div class="step-icon"><i class="fa-solid fa-clipboard-check"></i></div>
                <h4>2. Validate</h4>
                <p>Government admins review the submission, categorize it, and publish it to the public task board.</p>
            </div>
            <div class="step">
                <div class="step-icon"><i class="fa-solid fa-users-gear"></i></div>
                <h4>3. Claim & Action</h4>
                <p>Registered local organizations or NGOs claim the task and deploy teams to resolve the issue.</p>
            </div>
            <div class="step">
                <div class="step-icon"><i class="fa-solid fa-circle-check"></i></div>
                <h4>4. Resolve</h4>
                <p>The organization marks the task as complete, instantly updating the city-wide progress statistics.</p>
            </div>
        </div>
    </section>

    <!-- 5. ACCOUNTABILITY (REVERSE SPLIT) -->
    <section class="feature-split reverse">
        <div class="feature-visual">
            <i class="fa-solid fa-shield-halved"></i>
            <div style="position:absolute; bottom: 30px; background: rgba(0,0,0,0.5); padding: 15px 30px; border-radius: 30px; font-weight: bold; border: 1px solid var(--accent-color);">100% Data Transparency</div>
        </div>
        <div class="feature-text">
            <h2>Data-Driven Accountability</h2>
            <p>Our comprehensive dashboards provide real-time analytics to all users. Civilians can track exactly which organization is handling their request and view historical completion rates.</p>
            <p>Organizations are ranked on performance leaderboards, fostering healthy competition to improve city infrastructure, while Admins get a bird's-eye view of task velocity and resource distribution.</p>
        </div>
    </section>

    <!-- 6. BOTTOM CTA -->
    <section class="bottom-cta">
        <h2>Ready to make a difference?</h2>
        <p>Whether you are a concerned citizen or an organization looking to help, CityWatch needs you.</p>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/register" class="btn-filled" style="padding: 16px 50px; font-size: 1.2rem;">Create Your Account</a>
            <a href="${pageContext.request.contextPath}/contact" class="btn-outline" style="padding: 14px 50px; font-size: 1.2rem; border-width: 2px;">Contact Our Team</a>
        </div>
    </section>

    <footer>
        <p>&copy; 2026 CityWatch Initiative. Built for a Smarter Nepal.</p>
        <p style="margin-top: 10px;">Need help? <a href="${pageContext.request.contextPath}/contact">Contact Support</a></p>
    </footer>

</body>
</html>
