<%-- Generic Modals to be included in layout --%>
<style>
    .sys-modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background: rgba(0, 0, 0, 0.6);
        backdrop-filter: blur(4px);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        opacity: 0;
        visibility: hidden;
        transition: opacity 0.3s ease, visibility 0.3s ease;
    }

    .sys-modal-overlay.active {
        opacity: 1;
        visibility: visible;
    }

    .sys-modal {
        background: #ffffff;
        border-radius: 12px;
        width: 90%;
        max-width: 500px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        transform: translateY(20px);
        transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        overflow: hidden;
    }

    .sys-modal-overlay.active .sys-modal {
        transform: translateY(0);
    }

    .sys-modal-header {
        padding: 20px 25px;
        background: #f8f9fa;
        border-bottom: 1px solid #dde3ea;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .sys-modal-title {
        font-family: 'Outfit', 'Inter', sans-serif;
        font-weight: 700;
        font-size: 1.25rem;
        color: #1a3c5e;
        margin: 0;
    }

    .sys-modal-close {
        background: none;
        border: none;
        font-size: 1.5rem;
        color: #6c757d;
        cursor: pointer;
        transition: color 0.2s;
    }

    .sys-modal-close:hover {
        color: #c62828;
    }

    .sys-modal-body {
        padding: 25px;
        font-size: 1rem;
        color: #212529;
        line-height: 1.6;
    }

    .sys-modal-footer {
        padding: 15px 25px 20px;
        display: flex;
        justify-content: flex-end;
        gap: 12px;
    }

    .sys-btn {
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.95rem;
        cursor: pointer;
        border: none;
        transition: all 0.2s;
    }

    .sys-btn-cancel {
        background: #e9ecef;
        color: #495057;
    }

    .sys-btn-cancel:hover {
        background: #dde3ea;
    }

    .sys-btn-confirm {
        background: #1a3c5e;
        color: #ffffff;
    }

    .sys-btn-confirm:hover {
        background: #112a45;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    }

    .sys-btn-danger {
        background: #c62828;
        color: #ffffff;
    }

    .sys-btn-danger:hover {
        background: #a31515;
        box-shadow: 0 4px 10px rgba(198, 40, 40, 0.2);
    }
</style>

<!-- Standard Confirmation Modal -->
<div class="sys-modal-overlay" id="confirmModal">
    <div class="sys-modal">
        <div class="sys-modal-header">
            <h3 class="sys-modal-title" id="confirmModalTitle">Confirm Action</h3>
            <button class="sys-modal-close" onclick="closeModal('confirmModal')">&times;</button>
        </div>
        <div class="sys-modal-body" id="confirmModalMessage">
            Are you sure you want to proceed with this action?
        </div>
        <div class="sys-modal-footer">
            <button class="sys-btn sys-btn-cancel" onclick="closeModal('confirmModal')">Cancel</button>
            <button class="sys-btn sys-btn-confirm" id="confirmModalBtn">Confirm</button>
        </div>
    </div>
</div>

<!-- Alert/Info Modal -->
<div class="sys-modal-overlay" id="alertModal">
    <div class="sys-modal">
        <div class="sys-modal-header">
            <h3 class="sys-modal-title" id="alertModalTitle">Notice</h3>
            <button class="sys-modal-close" onclick="closeModal('alertModal')">&times;</button>
        </div>
        <div class="sys-modal-body" id="alertModalMessage">
            Operation completed successfully.
        </div>
        <div class="sys-modal-footer">
            <button class="sys-btn sys-btn-confirm" onclick="closeModal('alertModal')">OK</button>
        </div>
    </div>
</div>

<script>
    function openModal(modalId) {
        document.getElementById(modalId).classList.add('active');
    }

    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('active');
    }

    /**
     * Show a confirmation modal.
     * @param {string} title - The modal title
     * @param {string} message - The message body
     * @param {function} onConfirm - Callback when confirmed
     * @param {boolean} isDanger - If true, styles the confirm button red
     */
    function showConfirmModal(title, message, onConfirm, isDanger = false) {
        document.getElementById('confirmModalTitle').innerText = title;
        document.getElementById('confirmModalMessage').innerHTML = message;
        
        const confirmBtn = document.getElementById('confirmModalBtn');
        
        if(isDanger) {
            confirmBtn.className = 'sys-btn sys-btn-danger';
        } else {
            confirmBtn.className = 'sys-btn sys-btn-confirm';
        }
        
        confirmBtn.onclick = function() {
            closeModal('confirmModal');
            if(onConfirm) onConfirm();
        };
        
        openModal('confirmModal');
    }

    /**
     * Show a simple alert modal.
     */
    function showAlertModal(title, message) {
        document.getElementById('alertModalTitle').innerText = title;
        document.getElementById('alertModalMessage').innerHTML = message;
        openModal('alertModal');
    }

    // Close on outside click
    window.addEventListener('click', function(e) {
        if (e.target.classList.contains('sys-modal-overlay')) {
            e.target.classList.remove('active');
        }
    });
</script>
