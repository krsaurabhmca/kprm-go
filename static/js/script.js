document.addEventListener('DOMContentLoaded', () => {
    const uploadArea = document.getElementById('uploadArea');
    const fileInput = document.getElementById('excelFile');
    const fileNameDisplay = document.getElementById('fileName');

    if (uploadArea && fileInput) {
        uploadArea.addEventListener('click', () => fileInput.click());

        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('dragover');

            if (e.dataTransfer.files.length > 0) {
                fileInput.files = e.dataTransfer.files;
                updateFileName();
            }
        });

        fileInput.addEventListener('change', updateFileName);

        function updateFileName() {
            if (fileInput.files.length > 0) {
                const fileName = fileInput.files[0].name;
                fileNameDisplay.textContent = `Selected: ${fileName}`;
                fileNameDisplay.style.color = 'var(--success)';
            } else {
                fileNameDisplay.textContent = 'Support .xlsx, .xls';
                fileNameDisplay.style.color = 'var(--text-muted)';
            }
        }
    }

    const sidebar = document.querySelector('.sidebar');
    const toggleBtn = document.getElementById('sidebarToggle');

    if (sidebar) {
        const isMinimized = localStorage.getItem('sidebarMinimized');
        if (isMinimized === 'true') {
            sidebar.classList.add('minimized');
        }
    }

    if (toggleBtn && sidebar) {
        toggleBtn.addEventListener('click', () => {
            const isCollapsed = sidebar.classList.toggle('minimized');
            localStorage.setItem('sidebarMinimized', String(isCollapsed));
        });
    }
});

/**
 * ====================================================================
 * Financial Statement Comparison Matrix Engine
 * ====================================================================
 */

function parseFinancialNumber(val) {
    if (val === null || val === undefined) return null;
    val = String(val).trim();
    if (val === '') return null;
    if (val.toUpperCase() === 'NA') return 'NA';
    // Remove currency symbols, commas, spaces
    const clean = val.replace(/,/g, '').replace(/\s/g, '').replace(/₹/g, '').replace(/\$/g, '');
    const num = parseFloat(clean);
    return isNaN(num) ? NaN : num;
}

function updateFinancialRow(metaId, triggerElement) {
    if (!triggerElement) return;
    const row = triggerElement.closest('tr.fin-row-item');
    if (!row) return;

    if (!metaId) {
        metaId = row.getAttribute('data-meta');
    }

    const providedInp = row.querySelector('.fin-provided');
    const itoInp = row.querySelector('.fin-ito');
    const remarkBadge = row.querySelector('.fin-remark-badge');
    const remarkVal = row.querySelector('.fin-remark-val');
    const diffText = row.querySelector('.fin-diff-text');
    const diffVal = row.querySelector('.fin-diff-val');

    if (!providedInp || !itoInp) return;

    const pRaw = providedInp.value;
    const iRaw = itoInp.value;

    const pVal = parseFinancialNumber(pRaw);
    const iVal = parseFinancialNumber(iRaw);

    if (pVal === null && iVal === null) {
        if (remarkBadge) {
            remarkBadge.innerText = '-';
            remarkBadge.style.background = '#f8fafc';
            remarkBadge.style.color = '#94a3b8';
            remarkBadge.style.border = '1px solid #e2e8f0';
        }
        if (remarkVal) remarkVal.value = '';
        if (diffText) {
            diffText.innerText = '-';
            diffText.style.color = '#94a3b8';
        }
        if (diffVal) diffVal.value = '';
    } else if (pVal === 'NA' || iVal === 'NA') {
        if (remarkBadge) {
            remarkBadge.innerText = 'NA';
            remarkBadge.style.background = '#f1f5f9';
            remarkBadge.style.color = '#475569';
            remarkBadge.style.border = '1px solid #cbd5e1';
        }
        if (remarkVal) remarkVal.value = 'NA';
        if (diffText) {
            diffText.innerText = 'NA';
            diffText.style.color = '#64748b';
        }
        if (diffVal) diffVal.value = 'NA';
    } else if (typeof pVal === 'number' && typeof iVal === 'number') {
        // Difference = ITO record - Provided copy
        const diff = iVal - pVal;
        const formattedDiff = (diff < 0 ? '-' : '') + Math.abs(diff).toLocaleString('en-IN');

        if (diffVal) diffVal.value = String(diff);

        if (Math.abs(diff) < 0.0001) {
            if (diffText) {
                diffText.innerText = '0';
                diffText.style.color = '#15803d';
            }
            if (remarkBadge) {
                remarkBadge.innerText = 'Matching';
                remarkBadge.style.background = '#dcfce7';
                remarkBadge.style.color = '#15803d';
                remarkBadge.style.border = '1px solid #86efac';
            }
            if (remarkVal) remarkVal.value = 'Matching';
        } else {
            if (diffText) {
                diffText.innerText = formattedDiff;
                diffText.style.color = '#b91c1c';
            }
            if (remarkBadge) {
                remarkBadge.innerText = 'Figure Differences-';
                remarkBadge.style.background = '#fee2e2';
                remarkBadge.style.color = '#b91c1c';
                remarkBadge.style.border = '1px solid #fca5a5';
            }
            if (remarkVal) remarkVal.value = 'Figure Differences-';
        }
    } else {
        // Partial or invalid input
        if (remarkBadge) {
            remarkBadge.innerText = 'Incomplete';
            remarkBadge.style.background = '#fef3c7';
            remarkBadge.style.color = '#b45309';
            remarkBadge.style.border = '1px solid #fde68a';
        }
        if (remarkVal) remarkVal.value = 'Incomplete';
        if (diffText) {
            diffText.innerText = '-';
            diffText.style.color = '#94a3b8';
        }
        if (diffVal) diffVal.value = '';
    }

    if (metaId) {
        syncFinancialTableJson(metaId);
    }
}

function syncFinancialTableJson(metaId) {
    const table = document.getElementById('fin_table_' + metaId);
    if (!table) return;

    const rows = table.querySelectorAll('tr.fin-row-item');
    const result = [];

    rows.forEach(r => {
        const section = r.getAttribute('data-section') || '';
        const particularInp = r.querySelector('.fin-particular');
        const particular = particularInp ? particularInp.value : '';
        const providedInp = r.querySelector('.fin-provided');
        const provided = providedInp ? providedInp.value.trim() : '';
        const itoInp = r.querySelector('.fin-ito');
        const ito = itoInp ? itoInp.value.trim() : '';
        const remarkVal = r.querySelector('.fin-remark-val');
        const remark = remarkVal ? remarkVal.value : '';
        const diffVal = r.querySelector('.fin-diff-val');
        const diff = diffVal ? diffVal.value : '';

        result.push({
            section: section,
            particular: particular,
            provided_copy: provided,
            ito_record: ito,
            remark: remark,
            difference: diff
        });
    });

    const hiddenInput = document.getElementById('fin_json_' + metaId);
    if (hiddenInput) {
        hiddenInput.value = JSON.stringify(result);
    }
}

function initFinancialTables(root = document) {
    const tables = root.querySelectorAll('.financial-matrix-table');
    tables.forEach(tbl => {
        const metaId = tbl.id.replace('fin_table_', '');
        tbl.querySelectorAll('tr.fin-row-item').forEach(r => {
            const pInp = r.querySelector('.fin-provided');
            if (pInp) {
                updateFinancialRow(metaId, pInp);
            }
        });
        syncFinancialTableJson(metaId);
    });
}

function addFinancialCustomRow(metaId, sectionTitle, btn) {
    const particularName = prompt("Enter Particular Name (e.g. Other Income, Borrowings, Reserves):");
    if (!particularName || !particularName.trim()) return;

    const table = document.getElementById('fin_table_' + metaId);
    if (!table) return;

    const tbody = table.querySelector('tbody');
    const newTr = document.createElement('tr');
    newTr.className = 'fin-row-item';
    newTr.setAttribute('data-meta', metaId);
    newTr.setAttribute('data-section', sectionTitle);
    newTr.style.borderBottom = '1px solid #e2e8f0';

    const safePart = particularName.trim();

    newTr.innerHTML = `
        <td style="padding: 0.55rem 0.85rem; font-weight: 600; color: #1e293b; vertical-align: middle;">
            <input type="hidden" class="fin-particular" value="${safePart}">
            ${safePart}
        </td>
        <td style="padding: 0.55rem 0.85rem; vertical-align: middle;">
            <input type="text" class="review-input fin-provided" value="" placeholder="0.00 or NA" style="text-align: right; font-size: 0.84rem; padding: 0.4rem 0.6rem; border-radius: 6px;" oninput="updateFinancialRow('${metaId}', this)">
        </td>
        <td style="padding: 0.55rem 0.85rem; vertical-align: middle;">
            <input type="text" class="review-input fin-ito" value="" placeholder="0.00 or NA" style="text-align: right; font-size: 0.84rem; padding: 0.4rem 0.6rem; border-radius: 6px;" oninput="updateFinancialRow('${metaId}', this)">
        </td>
        <td style="padding: 0.55rem 0.85rem; text-align: center; vertical-align: middle;">
            <span class="fin-remark-badge" style="font-size: 0.76rem; font-weight: 700; padding: 0.22rem 0.6rem; border-radius: 6px; display: inline-block; background:#f8fafc; color:#94a3b8; border:1px solid #e2e8f0;">-</span>
            <input type="hidden" class="fin-remark-val" value="">
        </td>
        <td style="padding: 0.55rem 0.85rem; text-align: right; vertical-align: middle; font-weight: 700; color: #334155;">
            <span class="fin-diff-text" style="font-variant-numeric: tabular-nums;">-</span>
            <input type="hidden" class="fin-diff-val" value="">
        </td>
    `;

    // Insert before the section's add button row or at end
    const btnRow = btn ? btn.closest('tr') : null;
    if (btnRow && btnRow.parentNode) {
        tbody.insertBefore(newTr, btnRow);
    } else {
        tbody.appendChild(newTr);
    }

    newTr.querySelector('.fin-provided').focus();
    syncFinancialTableJson(metaId);
}

// Global Event Delegation for all Financial Inputs
document.addEventListener('input', function(e) {
    if (e.target && (e.target.classList.contains('fin-provided') || e.target.classList.contains('fin-ito'))) {
        const row = e.target.closest('tr.fin-row-item');
        if (row) {
            const metaId = row.getAttribute('data-meta');
            updateFinancialRow(metaId, e.target);
        }
    }
});

// Run on page load
document.addEventListener('DOMContentLoaded', () => {
    initFinancialTables(document);
});

/**
 * Open Financial View Modal
 * @param {string|object|number|HTMLElement} src - Data object, JSON string, or element with data-fin attribute
 * @param {string} customTitle - Optional modal title
 */
function openFinancialModal(src, customTitle = 'Financial Statements Comparison') {
    let rawData = null;
    if (src && src.nodeType === 1) {
        // HTMLElement
        const finAttr = src.getAttribute('data-fin');
        if (finAttr) {
            try { rawData = JSON.parse(finAttr); } catch(e) { rawData = finAttr; }
        }
    } else if (typeof src === 'string') {
        try { rawData = JSON.parse(src); } catch(e) { rawData = src; }
    } else {
        rawData = src;
    }

    if (!Array.isArray(rawData)) {
        if (rawData && typeof rawData === 'object' && Array.isArray(rawData.data)) {
            rawData = rawData.data;
        } else {
            console.warn('Invalid or empty financial data', rawData);
            rawData = [];
        }
    }

    // Ensure modal DOM element exists
    let modal = document.getElementById('globalFinancialModal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'globalFinancialModal';
        modal.className = 'comm-modal-backdrop';
        modal.style.cssText = 'position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(15,23,42,0.65); backdrop-filter:blur(4px); z-index:99999; display:none; align-items:center; justify-content:center; padding:1rem; box-sizing:border-box;';
        
        modal.innerHTML = `
            <div style="background:#fff; width:100%; max-width:960px; max-height:90vh; border-radius:12px; box-shadow:0 25px 50px -12px rgba(0,0,0,0.25); display:flex; flex-direction:column; overflow:hidden; border:1px solid #cbd5e1; animation:finModalIn 0.2s cubic-bezier(0.16, 1, 0.3, 1);">
                <div style="padding:1rem 1.4rem; background:linear-gradient(135deg, #1e293b 0%, #0f172a 100%); color:#fff; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid rgba(255,255,255,0.1);">
                    <div style="display:flex; align-items:center; gap:0.65rem;">
                        <span style="display:inline-flex; align-items:center; justify-content:center; width:34px; height:34px; border-radius:8px; background:rgba(59,130,246,0.25); color:#60a5fa; border:1px solid rgba(96,165,250,0.4);">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>
                        </span>
                        <div>
                            <h3 id="globalFinModalTitle" style="margin:0; font-size:1.05rem; font-weight:700; color:#fff; line-height:1.2;">Financial Statement Comparison</h3>
                            <div style="font-size:0.75rem; color:#94a3b8;">Detailed P&L & Balance Sheet Verification Matrix</div>
                        </div>
                    </div>
                    <div style="display:flex; align-items:center; gap:0.5rem;">
                        <button type="button" onclick="closeFinancialModal()" style="background:none; border:none; color:#94a3b8; font-size:1.5rem; line-height:1; cursor:pointer; padding:0.2rem 0.4rem; transition:color 0.15s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#94a3b8'">&times;</button>
                    </div>
                </div>

                <div id="globalFinSummaryBar" style="background:#f8fafc; padding:0.75rem 1.4rem; border-bottom:1px solid #e2e8f0; display:flex; align-items:center; gap:1.2rem; flex-wrap:wrap; font-size:0.8rem;">
                    <!-- Metrics populated dynamically -->
                </div>

                <div id="globalFinModalBody" style="padding:1.2rem 1.4rem; overflow-y:auto; flex:1;">
                    <!-- Table populated dynamically -->
                </div>

                <div style="padding:0.85rem 1.4rem; background:#f8fafc; border-top:1px solid #e2e8f0; display:flex; justify-content:space-between; align-items:center;">
                    <span style="font-size:0.75rem; color:#64748b;">Verification Rule: Difference = |Provided Copy - ITO Record|</span>
                    <button type="button" class="btn btn-secondary" onclick="closeFinancialModal()" style="padding:0.4rem 1.1rem; font-size:0.85rem; font-weight:600;">Close</button>
                </div>
            </div>
        `;
        document.body.appendChild(modal);

        modal.addEventListener('click', function(e) {
            if (e.target === modal) closeFinancialModal();
        });
        
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && modal.style.display === 'flex') {
                closeFinancialModal();
            }
        });
    }

    document.getElementById('globalFinModalTitle').innerText = customTitle;

    // Compute Summary Stats
    let totalItems = 0;
    let matchingCount = 0;
    let diffCount = 0;
    let naCount = 0;

    const grouped = {};
    rawData.forEach(r => {
        totalItems++;
        const rem = (r.remark || '').trim();
        if (rem === 'Matching') matchingCount++;
        else if (rem.toLowerCase().includes('diff')) diffCount++;
        else naCount++;

        const sec = r.section || 'Statement';
        if (!grouped[sec]) grouped[sec] = [];
        grouped[sec].push(r);
    });

    // Populate Summary Bar
    const summaryBar = document.getElementById('globalFinSummaryBar');
    summaryBar.innerHTML = `
        <div style="display:flex; align-items:center; gap:0.4rem;">
            <span style="color:#64748b; font-weight:600;">Total Particulars:</span>
            <span style="font-weight:700; color:#0f172a; background:#e2e8f0; padding:0.15rem 0.55rem; border-radius:999px;">${totalItems}</span>
        </div>
        <div style="display:flex; align-items:center; gap:0.4rem;">
            <span style="color:#15803d; font-weight:600;">Matching Figures:</span>
            <span style="font-weight:700; color:#15803d; background:#dcfce7; border:1px solid #86efac; padding:0.15rem 0.55rem; border-radius:999px;">${matchingCount}</span>
        </div>
        <div style="display:flex; align-items:center; gap:0.4rem;">
            <span style="color:#b91c1c; font-weight:600;">Discrepancies:</span>
            <span style="font-weight:700; color:#b91c1c; background:#fee2e2; border:1px solid #fca5a5; padding:0.15rem 0.55rem; border-radius:999px;">${diffCount}</span>
        </div>
        <div style="display:flex; align-items:center; gap:0.4rem;">
            <span style="color:#475569; font-weight:600;">NA / Other:</span>
            <span style="font-weight:700; color:#475569; background:#f1f5f9; border:1px solid #cbd5e1; padding:0.15rem 0.55rem; border-radius:999px;">${naCount}</span>
        </div>
    `;

    // Populate Table
    const body = document.getElementById('globalFinModalBody');
    if (totalItems === 0) {
        body.innerHTML = `<div style="text-align:center; padding:2.5rem; color:#94a3b8; font-size:0.9rem;">No financial statement records available.</div>`;
    } else {
        let tblHtml = `
            <div style="overflow-x:auto; border:1px solid #cbd5e1; border-radius:8px; background:#fff; box-shadow:0 1px 3px rgba(0,0,0,0.03);">
                <table style="width:100%; table-layout:fixed; border-collapse:collapse; font-size:0.83rem; text-align:left;">
                    <colgroup>
                        <col style="width:28%;">
                        <col style="width:23%;">
                        <col style="width:23%;">
                        <col style="width:14%;">
                        <col style="width:12%;">
                    </colgroup>
                    <thead>
                        <tr style="background:linear-gradient(135deg, #1e40af 0%, #3b82f6 100%); color:#fff;">
                            <th style="padding:0.65rem 0.85rem; border-right:1px solid rgba(255,255,255,0.2); font-weight:700;">Particular</th>
                            <th style="padding:0.65rem 0.85rem; border-right:1px solid rgba(255,255,255,0.2); text-align:right; font-weight:700;">Amount as per Provided copy</th>
                            <th style="padding:0.65rem 0.85rem; border-right:1px solid rgba(255,255,255,0.2); text-align:right; font-weight:700;">Amount as per ITO record</th>
                            <th style="padding:0.65rem 0.85rem; border-right:1px solid rgba(255,255,255,0.2); text-align:center; font-weight:700;">Remark</th>
                            <th style="padding:0.65rem 0.85rem; text-align:right; font-weight:700;">Difference</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        for (let secTitle in grouped) {
            tblHtml += `
                <tr style="background:#e0f2fe; font-weight:700; color:#0369a1; border-top:2px solid #bae6fd; border-bottom:2px solid #bae6fd;">
                    <td colspan="4" style="padding:0.5rem 0.85rem; font-size:0.86rem;">📊 ${secTitle.replace(/</g, '&lt;')}</td>
                    <td style="padding:0.5rem 0.85rem; text-align:right; font-size:0.8rem; color:#0369a1;">Difference</td>
                </tr>
            `;

            grouped[secTitle].forEach((r, idx) => {
                const part = (r.particular || '').replace(/</g, '&lt;');
                const prov = (r.provided_copy !== undefined && r.provided_copy !== '') ? String(r.provided_copy).replace(/</g, '&lt;') : '-';
                const itoVal = (r.ito_record !== undefined && r.ito_record !== '') ? String(r.ito_record).replace(/</g, '&lt;') : '-';
                const rem = r.remark || '-';
                const diff = (r.difference !== undefined && r.difference !== '') ? String(r.difference).replace(/</g, '&lt;') : '-';

                let badge = '';
                if (rem === 'Matching') {
                    badge = `<span style="padding:0.2rem 0.6rem; border-radius:6px; font-weight:700; font-size:0.74rem; background:#dcfce7; color:#15803d; border:1px solid #86efac; display:inline-block; white-space:nowrap;">Matching</span>`;
                } else if (rem.toLowerCase().includes('diff')) {
                    badge = `<span style="padding:0.2rem 0.6rem; border-radius:6px; font-weight:700; font-size:0.74rem; background:#fee2e2; color:#b91c1c; border:1px solid #fca5a5; display:inline-block; white-space:nowrap;">${rem.replace(/</g, '&lt;')}</span>`;
                } else {
                    badge = `<span style="padding:0.2rem 0.6rem; border-radius:6px; font-weight:700; font-size:0.74rem; background:#f1f5f9; color:#475569; border:1px solid #cbd5e1; display:inline-block; white-space:nowrap;">${rem.replace(/</g, '&lt;')}</span>`;
                }

                const rowBg = idx % 2 === 0 ? 'background:#fff;' : 'background:#f8fafc;';
                const diffStyle = (diff !== '-' && diff !== '0' && diff !== 'NA') ? 'color:#b91c1c;' : 'color:#475569;';

                tblHtml += `
                    <tr style="border-bottom:1px solid #e2e8f0; ${rowBg}">
                        <td style="padding:0.5rem 0.85rem; font-weight:600; color:#1e293b;">${part}</td>
                        <td style="padding:0.5rem 0.85rem; text-align:right; font-family:Consolas,monospace; font-weight:600; color:#0f172a; font-variant-numeric:tabular-nums;">${prov}</td>
                        <td style="padding:0.5rem 0.85rem; text-align:right; font-family:Consolas,monospace; font-weight:600; color:#0f172a; font-variant-numeric:tabular-nums;">${itoVal}</td>
                        <td style="padding:0.5rem 0.85rem; text-align:center;">${badge}</td>
                        <td style="padding:0.5rem 0.85rem; text-align:right; font-family:Consolas,monospace; font-weight:700; ${diffStyle} font-variant-numeric:tabular-nums;">${diff}</td>
                    </tr>
                `;
            });
        }

        tblHtml += `</tbody></table></div>`;
        body.innerHTML = tblHtml;
    }

    modal.style.display = 'flex';
}

function closeFinancialModal() {
    const modal = document.getElementById('globalFinancialModal');
    if (modal) modal.style.display = 'none';
}


