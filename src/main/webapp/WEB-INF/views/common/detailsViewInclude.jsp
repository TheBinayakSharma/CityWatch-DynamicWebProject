<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .details-container {
        margin: 20px 0;
        background: var(--white);
        border-radius: var(--radius);
        box-shadow: 0 4px 25px rgba(0,0,0,0.1);
        border-top: 5px solid var(--primary);
        display: none;
        animation: slideUp 0.3s ease-out;
    }
    
    .details-container.open {
        display: block;
    }
    
    @keyframes slideUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .details-header {
        padding: 18px 25px;
        border-bottom: 1px solid var(--border);
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #f8f9fa;
        border-radius: var(--radius) var(--radius) 0 0;
    }
    
    .details-header h3 {
        margin: 0;
        font-size: 1rem;
        color: var(--primary);
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
        background: #f8f9fa;
        border-radius: 0 0 var(--radius) var(--radius);
    }
    
    .detail-item {
        margin-bottom: 0;
    }
    
    .detail-item label {
        display: block;
        font-size: 0.75rem;
        color: var(--muted);
        text-transform: uppercase;
        font-weight: 700;
        margin-bottom: 4px;
    }
    
    .detail-item .value {
        font-size: 0.95rem;
        color: var(--dark);
        line-height: 1.5;
        word-break: break-all;
    }

    tr.active-row {
        background: #f0f7ff !important;
        box-shadow: inset 4px 0 0 var(--primary);
    }
</style>

<div id="detailsSection" class="details-container">
    <div class="details-header">
        <h3 id="detailsTitle">Details</h3>
        <button type="button" onclick="closeDetails()" style="background:none; border:none; color:var(--muted); font-size:1.5rem; cursor:pointer;">&times;</button>
    </div>
    
    <div class="details-body" id="detailsBody">
        <!-- Content Injected via JS -->
    </div>
    
    <div class="details-footer" id="detailsFooter">
        <!-- Buttons Injected via JS if needed -->
        <button type="button" class="btn btn-sm" style="background:#ddd;" onclick="closeDetails()">Close</button>
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
        section.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }

    function closeDetails() {
        document.getElementById('detailsSection').classList.remove('open');
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
</script>
