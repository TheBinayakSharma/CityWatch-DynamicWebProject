/**
 * table-utils.js
 * Provides client-side searching and sorting for HTML tables.
 */

function triggerSearch(inputId) {
    const input = document.getElementById(inputId);
    if (input) {
        input.dispatchEvent(new Event('keyup'));
    }
}

function triggerSort(tableId, columnIndex) {
    const table = document.getElementById(tableId);
    if (table && columnIndex !== "") {
        sortTable(table, parseInt(columnIndex));
    }
}

function initTableFeatures(tableId, searchInputId) {
    const table = document.getElementById(tableId);
    if (!table) return;

    const searchInput = document.getElementById(searchInputId);
    if (searchInput) {
        searchInput.addEventListener('keyup', () => {
            const filter = searchInput.value.toLowerCase();
            const rows = table.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    }

    const headers = table.querySelectorAll('thead th');
    headers.forEach((header, index) => {
        header.style.cursor = 'pointer';
        header.title = 'Click to sort';
        header.addEventListener('click', () => {
            sortTable(table, index);
        });
    });
}

function sortTable(table, columnIndex) {
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const isAscending = table.dataset.sortCol === columnIndex.toString() && table.dataset.sortOrder === 'asc';
    const direction = isAscending ? -1 : 1;

    // Remove old indicators
    table.querySelectorAll('thead th').forEach(th => {
        th.classList.remove('sort-asc', 'sort-desc');
    });

    rows.sort((a, b) => {
        const aCell = a.cells[columnIndex];
        const bCell = b.cells[columnIndex];
        if (!aCell || !bCell) return 0;

        const aText = aCell.textContent.trim();
        const bText = bCell.textContent.trim();

        const aNum = parseFloat(aText.replace(/[^0-9.-]+/g, ""));
        const bNum = parseFloat(bText.replace(/[^0-9.-]+/g, ""));

        if (!isNaN(aNum) && !isNaN(bNum)) {
            return (aNum - bNum) * direction;
        }

        return aText.localeCompare(bText, undefined, { numeric: true, sensitivity: 'base' }) * direction;
    });

    // Clear and re-append
    while (tbody.firstChild) tbody.removeChild(tbody.firstChild);
    tbody.append(...rows);

    // Set state
    table.dataset.sortCol = columnIndex;
    table.dataset.sortOrder = isAscending ? 'desc' : 'asc';
    table.querySelectorAll('thead th')[columnIndex].classList.add(isAscending ? 'sort-desc' : 'sort-asc');
}
