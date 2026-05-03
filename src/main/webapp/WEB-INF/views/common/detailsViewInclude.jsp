<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            .details-container {
                position: fixed;
                bottom: 20px;
                left: 30px;
                right: 30px;
                z-index: 1000;
                background: #6f8db6;
                border-radius: var(--radius);
                box-shadow: 0 -10px 40px rgba(0, 0, 0, 0.2);
                border-top: 5px solid var(--primary);
                display: none;
                transition: transform 0.3s ease, opacity 0.3s ease, bottom 0.1s ease;
                animation: slideUp 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            }

            .details-container.open {
                display: block;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .details-header {
                padding: 18px 25px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: var(--primary);
                border-radius: var(--radius) var(--radius) 0 0;
                color: var(--white);
            }

            .details-header h3 {
                margin: 0;
                font-size: 1rem;
                color: var(--white);
                font-weight: 700;
                text-transform: uppercase;
            }

            .details-body {
                padding: 25px;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
            }

            .details-footer {
                padding: 15px 25px;
                border-top: 1px solid var(--border);
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                align-items: center;
                background: #f1f4f8;
                border-radius: 0 0 var(--radius) var(--radius);
            }

            .detail-item {
                margin-bottom: 0;
            }

            .detail-item label {
                display: block;
                font-size: 0.72rem;
                color: rgba(255, 255, 255, 0.85);
                text-transform: uppercase;
                font-weight: 700;
                margin-bottom: 6px;
                letter-spacing: 0.5px;
            }

            .detail-item .value {
                font-size: 0.95rem;
                color: #ffffff;
                line-height: 1.5;
                word-break: break-all;
                font-weight: 600;
            }

            tr.active-row {
                background: #f0f7ff !important;
                box-shadow: inset 4px 0 0 var(--primary);
            }
        </style>

        <div id="detailsSection" class="details-container">
            <div class="details-header">
                <h3 id="detailsTitle">Details</h3>
                <button type="button" onclick="closeDetails()"
                    style="background:none; border:none; color:rgba(255,255,255,0.8); font-size:1.5rem; cursor:pointer;">&times;</button>
            </div>

            <div class="details-body" id="detailsBody">
                <!-- Content Injected via JS -->
            </div>

            <div class="details-footer" id="detailsFooter">
                <!-- Buttons Injected via JS if needed -->
                <button type="button" class="btn btn-sm" style="background:#ddd;"
                    onclick="closeDetails()">Close</button>
            </div>

            <!-- Hidden form for actions if needed -->
            <form id="detailsActionForm" method="post" action="">
                <input type="hidden" name="action" id="detailsActionInput" value="">
                <input type="hidden" name="taskId" id="detailsTaskId" value="">
            </form>
        </div>

        <script>
            function showDetails(title, contentHtml, rowElement, buttons) {
                // Highlight row
                var rows = document.querySelectorAll('tbody tr');
                for (var i = 0; i < rows.length; i++) rows[i].classList.remove('active-row');
                if (rowElement) rowElement.classList.add('active-row');

                // Set Title & Content
                document.getElementById('detailsTitle').innerText = title;
                document.getElementById('detailsBody').innerHTML = contentHtml;

                // Handle Buttons
                var footer = document.getElementById('detailsFooter');
                footer.innerHTML = '';
                if (buttons && buttons.length > 0) {
                    for (var j = 0; j < buttons.length; j++) {
                        var b = buttons[j];
                        var btn = document.createElement('button');
                        btn.className = 'btn btn-sm ' + (b.className || 'btn-primary');
                        btn.innerText = b.label;
                        btn.onclick = b.onclick;
                        footer.appendChild(btn);
                    }
                }

                // Add default Close button
                var closeBtn = document.createElement('button');
                closeBtn.className = 'btn btn-sm';
                closeBtn.style.background = '#ddd';
                closeBtn.innerText = 'Close';
                closeBtn.onclick = closeDetails;
                footer.appendChild(closeBtn);

                var section = document.getElementById('detailsSection');
                section.classList.add('open');

                // Add space at the bottom of main so the last rows aren't covered
                setTimeout(function() {
                    var main = document.querySelector('.main');
                    if (main) main.style.paddingBottom = (section.offsetHeight + 40) + 'px';
                    updateDetailsDocking();
                }, 50);
            }

            function closeDetails() {
                var section = document.getElementById('detailsSection');
                section.classList.remove('open');
                var main = document.querySelector('.main');
                if (main) main.style.paddingBottom = '0px';

                var rows = document.querySelectorAll('tbody tr');
                for (var i = 0; i < rows.length; i++) rows[i].classList.remove('active-row');
            }

            function createDetailItem(label, value) {
                var val = (value === undefined || value === null || value === '') ? '—' : value;
                return '<div class="detail-item"><label>' + label + '</label><div class="value">' + val + '</div></div>';
            }

            function performAction(url, action, taskId) {
                var form = document.getElementById('detailsActionForm');
                form.action = url;
                document.getElementById('detailsActionInput').value = action;
                document.getElementById('detailsTaskId').value = taskId;
                form.submit();
            }

            // Smooth Docking logic to prevent flicker and overlap
            function updateDetailsDocking() {
                var details = document.getElementById('detailsSection');
                var footer = document.querySelector('.main-footer');
                if (!details || !footer || !details.classList.contains('open')) return;

                var footerRect = footer.getBoundingClientRect();
                var windowHeight = window.innerHeight;
                var threshold = 40; // Spacing from footer

                if (footerRect.top < windowHeight) {
                    var newBottom = (windowHeight - footerRect.top) + threshold;
                    details.style.bottom = newBottom + 'px';
                    details.style.boxShadow = '0 5px 20px rgba(0,0,0,0.1)';
                } else {
                    details.style.bottom = '20px';
                    details.style.boxShadow = '0 -10px 40px rgba(0, 0, 0, 0.2)';
                }
            }

            window.addEventListener('scroll', function() {
                requestAnimationFrame(updateDetailsDocking);
            });
            window.addEventListener('resize', updateDetailsDocking);
        </script>