<%-- Reusable Premium Footer --%>
<style>
    .main-footer {
        margin-top: 60px;
        width: 100%;
        font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    }

    .footer-main {
        background: #1a3c5e; /* Project Primary Blue */
        color: #ffffff;
        padding: 80px 8%;
        display: grid;
        grid-template-columns: 1.2fr 1fr 1fr 1.5fr;
        gap: 50px;
        align-items: start;
    }

    .footer-brand .footer-logo {
        font-family: 'Montserrat', sans-serif;
        font-size: 2rem; font-weight: 800; margin-bottom: 25px;
        letter-spacing: -0.5px;
    }
    .footer-brand .footer-logo span { color: #d4ff00; font-size: 0.9rem; vertical-align: top; }
    .footer-brand p { color: rgba(255,255,255,0.7); font-size: 0.95rem; line-height: 1.8; max-width: 280px; }

    .footer-col .col-header {
        font-size: 0.85rem; font-weight: 800; text-transform: uppercase;
        letter-spacing: 1.2px; margin-bottom: 30px; color: #fff;
        border-bottom: 2px solid rgba(255,255,255,0.2);
        padding-bottom: 10px;
        width: fit-content;
    }
    .footer-col p { font-size: 0.95rem; color: rgba(255,255,255,0.7); margin-bottom: 12px; line-height: 1.6; }
    .footer-col a { color: #fff; text-decoration: none; transition: color 0.2s; }
    .footer-col a:hover { color: #d4ff00; }

    .footer-photo-section {
        width: 100%;
        height: 250px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        border: 4px solid rgba(255,255,255,0.1);
    }
    .footer-photo-section img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    .footer-photo-section:hover img {
        transform: scale(1.05);
    }

    .footer-bottom {
        background: #142d47; /* Darker shade of primary */
        color: rgba(255,255,255,0.4); 
        padding: 25px 8%;
        font-size: 0.8rem; font-weight: 600;
        display: flex; justify-content: space-between;
        border-top: 1px solid rgba(255,255,255,0.05);
    }

    @media (max-width: 1100px) {
        .footer-main { grid-template-columns: 1fr 1fr; }
        .footer-photo-section { grid-column: span 2; height: 300px; }
    }

    @media (max-width: 700px) {
        .footer-main { grid-template-columns: 1fr; }
        .footer-photo-section { grid-column: span 1; }
    }
</style>

<footer class="main-footer">
    <div class="footer-main">
        <div class="footer-brand">
            <div class="footer-logo">CityWatch<span>&reg;</span></div>
            <p>Empowering citizens to report issues and collaborating with organizations to build a smarter, safer, and more transparent Nepal.</p>
            
            <div style="margin-top: 40px; display: flex; gap: 20px;">
                <a href="#" style="font-size: 1.1rem; color: #fff; opacity: 0.6;">FB</a>
                <a href="#" style="font-size: 1.1rem; color: #fff; opacity: 0.6;">TW</a>
                <a href="#" style="font-size: 1.1rem; color: #fff; opacity: 0.6;">IG</a>
                <a href="#" style="font-size: 1.1rem; color: #fff; opacity: 0.6;">LI</a>
            </div>
        </div>
        
        <div class="footer-col">
            <div class="col-header">KATHMANDU (HQ)</div>
            <p><a href="mailto:ktm@citywatch.gov.np">ktm@citywatch.gov.np</a></p>
            <p>+977 1 4220000</p>
            <p>New Road, Ward 22,<br>Kathmandu, Nepal</p>
        </div>
        
        <div class="footer-col">
            <div class="col-header">POKHARA</div>
            <p><a href="mailto:pkr@citywatch.gov.np">pkr@citywatch.gov.np</a></p>
            <p>+977 61 460000</p>
            <p>Lakeside, Ward 6,<br>Pokhara, Nepal</p>
        </div>
        
        <div class="footer-col" style="display: flex; flex-direction: column; gap: 15px;">
            <div class="col-header">OUR VIBRANT CITY</div>
            <div class="footer-photo-section">
                <img src="${pageContext.request.contextPath}/images/footer-cityscape.png" alt="Modern Nepal Cityscape">
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        <span>&copy; 2026 CityWatch. All rights reserved.</span>
        <span>Built with Unity for a Smarter Nepal</span>
    </div>
</footer>