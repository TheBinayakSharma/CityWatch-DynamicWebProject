<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Details Section Styles (Bottom of page, above footer) */
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
        letter-spacing: 0.8px;
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
    
    .form-item {
        margin-bottom: 0;
    }
    
    .form-item label {
        display: block;
        font-size: 0.75rem;
        color: var(--muted);
        text-transform: uppercase;
        font-weight: 700;
        margin-bottom: 6px;
    }
    
    .form-item input, .form-item textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid var(--border);
        border-radius: 4px;
        font-size: 0.9rem;
    }

    .form-item input:focus, .form-item textarea:focus {
        border-color: var(--primary);
        outline: none;
    }

    .form-item input:disabled, .form-item textarea:disabled {
        background: #f1f3f5;
        color: #666;
    }

    /* Highlight active row */
    tr.active-row {
        background: #eef3f8 !important;
        box-shadow: inset 4px 0 0 var(--primary);
    }
</style>

<div id="detailsSection" class="details-container">
    <div class="details-header">
        <h3 id="detailsTitle">Details</h3>
        <button type="button" onclick="closeDetails()" style="background:none; border:none; color:var(--muted); font-size:1.5rem; cursor:pointer;">&times;</button>
    </div>
    
    <form id="detailsForm" method="post" action="">
        <input type="hidden" name="action" id="formAction" value="">
        <input type="hidden" name="id" id="itemId" value="">
        <input type="hidden" name="userId" id="userId" value="">
        
        <div class="details-body" id="detailsBody" style="min-height: 80px;">
            <!-- Content Injected via JS -->
        </div>
        
        <div class="details-footer">
            <button type="submit" class="btn btn-primary btn-sm" id="updateBtn">Update Changes</button>
            <button type="button" class="btn btn-warning btn-sm" id="lockBtn" style="display:none;" onclick="handleAccountStatus('lockUser')">Lock Account</button>
            <button type="button" class="btn btn-success btn-sm" id="unlockBtn" style="display:none;" onclick="handleAccountStatus('unlockUser')">Unlock Account</button>
            <button type="button" class="btn btn-danger btn-sm" id="removeBtn" onclick="handleRemove()">Remove Item</button>
            <button type="button" class="btn btn-sm" style="background:#ddd;" onclick="closeDetails()">Cancel</button>
        </div>
    </form>
</div>

<script>
    function initializeDetailsForm(baseUrl, updateAction, removeAction, title) {
        var form = document.getElementById('detailsForm');
        if (form) form.action = baseUrl;
        var actionInput = document.getElementById('formAction');
        if (actionInput) actionInput.value = updateAction;
        var titleElem = document.getElementById('detailsTitle');
        if (titleElem) titleElem.innerText = title;
        window.currentRemoveAction = removeAction;
    }

    function handleRemove() {
        if (confirm('Are you sure you want to remove this item?')) {
            document.getElementById('formAction').value = window.currentRemoveAction;
            document.getElementById('detailsForm').submit();
        }
    }

    function handleAccountStatus(action) {
        if (confirm('Confirm account status change?')) {
            document.getElementById('formAction').value = action;
            document.getElementById('detailsForm').submit();
        }
    }

    function showDetailsForm(contentHtml, idValue, isUser, rowElement, isLocked, isAddMode, customAction) {
        var rows = document.querySelectorAll('tbody tr');
        for (var i = 0; i < rows.length; i++) rows[i].classList.remove('active-row');
        if (rowElement) rowElement.classList.add('active-row');

        var userIdField = document.getElementById('userId');
        var itemIdField = document.getElementById('itemId');
        var formAction = document.getElementById('formAction');
        var lockBtn = document.getElementById('lockBtn');
        var unlockBtn = document.getElementById('unlockBtn');
        var updateBtn = document.getElementById('updateBtn');
        var removeBtn = document.getElementById('removeBtn');
        
        if (customAction) formAction.value = customAction;

        lockBtn.style.display = 'none';
        unlockBtn.style.display = 'none';
        updateBtn.innerText = isAddMode ? 'Add New' : 'Update Changes';
        removeBtn.style.display = isAddMode ? 'none' : 'inline-block';

        if (isUser) {
            userIdField.value = idValue || '';
            itemIdField.value = '';
            
            if (!isAddMode) {
                if (isLocked === 'true' || isLocked === true) {
                    unlockBtn.style.display = 'inline-block';
                } else if (isLocked !== undefined) {
                    lockBtn.style.display = 'inline-block';
                }
            }
        } else {
            itemIdField.value = idValue || '';
            userIdField.value = '';
        }

        var body = document.getElementById('detailsBody');
        body.innerHTML = contentHtml || '<div style="grid-column: 1/-1; text-align:center; padding:20px;">No details available.</div>';
        
        var section = document.getElementById('detailsSection');
        section.classList.add('open');
        section.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
    
    function closeDetails() {
        document.getElementById('detailsSection').classList.remove('open');
        var rows = document.querySelectorAll('tbody tr');
        for (var i = 0; i < rows.length; i++) rows[i].classList.remove('active-row');
    }
    
    function createFormField(label, name, value, type, placeholder, readOnly) {
        var val = (value === undefined || value === null) ? '' : value;
        var ph = placeholder || '';
        var attr = readOnly ? 'readonly' : '';
        var field = '';
        if (type === 'textarea') {
            field = '<textarea name="' + name + '" ' + attr + ' placeholder="' + ph + '" rows="2">' + val + '</textarea>';
        } else {
            var inputType = type || 'text';
            field = '<input type="' + inputType + '" name="' + name + '" value="' + val + '" ' + attr + ' placeholder="' + ph + '">';
        }
        return '<div class="form-item"><label>' + label + '</label>' + field + '</div>';
    }
</script>
