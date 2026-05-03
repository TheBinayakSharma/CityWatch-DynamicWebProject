<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            /* Details Section Styles (Bottom of page, above footer) */
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
                background: #f1f4f8;
                border-radius: 0 0 var(--radius) var(--radius);
            }

            .form-item {
                margin-bottom: 0;
            }

            .form-item label {
                display: block;
                font-size: 0.72rem;
                color: rgba(255, 255, 255, 0.85);
                text-transform: uppercase;
                font-weight: 700;
                margin-bottom: 8px;
                letter-spacing: 0.5px;
            }

            .form-item input,
            .form-item textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid var(--border);
                border-radius: 4px;
                font-size: 0.9rem;
            }

            .form-item input:focus,
            .form-item textarea:focus {
                border-color: var(--primary);
                outline: none;
            }

            .form-item input:disabled,
            .form-item textarea:disabled {
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
                <button type="button" onclick="closeDetails()"
                    style="background:none; border:none; color:rgba(255,255,255,0.8); font-size:1.5rem; cursor:pointer;">&times;</button>
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
                    <button type="button" class="btn btn-success btn-sm" id="approveBtn" style="display:none;"
                        onclick="handleApproval('approveTask')">Approve Task</button>
                    <button type="button" class="btn btn-warning btn-sm" id="rejectBtn" style="display:none;"
                        onclick="handleApproval('rejectTask')">Reject Request</button>
                    <button type="button" class="btn btn-warning btn-sm" id="lockBtn" style="display:none;"
                        onclick="handleAccountStatus('lockUser')">Lock Account</button>
                    <button type="button" class="btn btn-success btn-sm" id="unlockBtn" style="display:none;"
                        onclick="handleAccountStatus('unlockUser')">Unlock Account</button>
                    <button type="button" class="btn btn-danger btn-sm" id="removeBtn" onclick="handleRemove()">Remove
                        Item</button>
                    <button type="button" class="btn btn-sm" style="background:#ddd;"
                        onclick="closeDetails()">Cancel</button>
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

            function handleApproval(action) {
                if (confirm('Are you sure you want to perform this action on the request?')) {
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
                var approveBtn = document.getElementById('approveBtn');
                var rejectBtn = document.getElementById('rejectBtn');

                if (customAction) formAction.value = customAction;

                lockBtn.style.display = 'none';
                unlockBtn.style.display = 'none';
                approveBtn.style.display = 'none';
                rejectBtn.style.display = 'none';
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

                    // Check for Pending Task (using a convention or extra param)
                    if (window.currentTaskStatus === 'PENDING') {
                        approveBtn.style.display = 'inline-block';
                        rejectBtn.style.display = 'inline-block';
                        updateBtn.style.display = 'none'; // Optional: hide update if it's just for approval
                    } else {
                        updateBtn.style.display = 'inline-block';
                    }
                }

                var body = document.getElementById('detailsBody');
                body.innerHTML = contentHtml || '<div style="grid-column: 1/-1; text-align:center; padding:20px;">No details available.</div>';

                var section = document.getElementById('detailsSection');
                section.classList.add('open');
                
                // Add space at the bottom of main so the last rows aren't covered
                setTimeout(function() {
                    var main = document.querySelector('.main');
                    if (main) main.style.paddingBottom = (section.offsetHeight + 40) + 'px';
                    updateDetailsDocking(); // Initial docking check
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

            // Smooth Docking logic to prevent flicker and overlap
            function updateDetailsDocking() {
                var details = document.getElementById('detailsSection');
                var footer = document.querySelector('.main-footer');
                if (!details || !footer || !details.classList.contains('open')) return;

                var footerRect = footer.getBoundingClientRect();
                var windowHeight = window.innerHeight;
                var threshold = 40; // Spacing from footer

                if (footerRect.top < windowHeight) {
                    // Footer is visible, push the fixed details up
                    var newBottom = (windowHeight - footerRect.top) + threshold;
                    details.style.bottom = newBottom + 'px';
                    details.style.boxShadow = '0 5px 20px rgba(0,0,0,0.1)';
                } else {
                    // Footer is below view, keep at base bottom
                    details.style.bottom = '20px';
                    details.style.boxShadow = '0 -10px 40px rgba(0, 0, 0, 0.2)';
                }
            }

            window.addEventListener('scroll', function() {
                requestAnimationFrame(updateDetailsDocking);
            });
            window.addEventListener('resize', updateDetailsDocking);
        </script>