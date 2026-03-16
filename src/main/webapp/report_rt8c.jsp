<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RT-8(C) Final Season Report | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-blue: #2563eb;
            --sidebar-dark: #1e293b;
            --bg-light: #f1f5f9;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-main);
        }

        /* ERP Layout Window */
        .app-window { 
            background: #ffffff; 
            border: none;
            border-radius: 12px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-top: 20px;
        }

        .window-header { 
            background-color: #ffffff; 
            padding: 15px 25px; 
            font-weight: 700; 
            border-bottom: 1px solid var(--border-color); 
            color: var(--text-main);
            display: flex;
            align-items: center;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Industry Sidebar */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 900px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 10px; 
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1); 
            color: #cbd5e1;
            text-align: left;
            padding: 12px 15px;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            border-radius: 8px;
            font-size: 0.88rem;
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            transform: translateX(5px);
        }

        /* Main Workspace */
        .main-panel { background-color: var(--bg-light); padding: 30px; }

        /* Filter Controls */
        .filter-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        /* --- Final Report Paper Styling --- */
        .report-paper { 
            background-color: white; 
            padding: 60px; 
            border: 1px solid #d1d5db; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            margin: 0 auto; 
            max-width: 1000px; 
            color: #000;
        }

        .report-header-box { border-bottom: 3px solid #000; margin-bottom: 25px; padding-bottom: 15px; }
        .report-title { text-align: center; font-weight: 800; font-size: 1.5rem; text-transform: uppercase; margin: 0; }
        .report-subtitle { text-align: center; font-weight: 600; font-size: 1.1rem; color: #374151; margin-top: 5px; }
        .excise-header { text-align: center; font-weight: 900; font-size: 1.3rem; margin: 20px 0; text-decoration: underline; text-underline-offset: 8px; }

        /* Data Tables */
        .table-report { width: 100%; border-collapse: collapse; border: 1.5px solid #000; margin-bottom: 30px; }
        .table-report th { 
            background-color: #f3f4f6 !important; 
            border: 1px solid #000; 
            text-align: center; 
            padding: 10px; 
            font-size: 0.75rem; 
            text-transform: uppercase;
            font-weight: 800;
        }
        .table-report td { 
            border: 1px solid #000; 
            padding: 8px 12px; 
            font-size: 0.88rem; 
            font-family: 'JetBrains Mono', monospace; /* Professional numeric alignment */
        }
        
        .section-header { 
            background-color: #000 !important; 
            color: #fff !important; 
            font-weight: 800 !important; 
            text-transform: uppercase;
            font-size: 0.85rem !important;
            font-family: 'Inter', sans-serif !important;
        }

        .row-label { font-family: 'Inter', sans-serif !important; font-weight: 600; color: #1f2937; }

        /* Signature Section */
        .signature-line { border-top: 1.5px solid #000; width: 85%; margin: 80px auto 10px auto; }
        
        @media print {
            body { background: white; }
            .navbar, .sidebar-panel, .filter-card, .btn-outline-dark { display: none !important; }
            .main-panel { padding: 0; background: white; }
            .app-window { box-shadow: none; margin: 0; border: none; }
            .window-header { display: none; }
            .report-paper { box-shadow: none; border: none; padding: 20px; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none text-muted">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Final Reports</li>
                    <li class="breadcrumb-item active text-primary">Form RT-8(C)</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-calendar-check-fill"></i> SEASONAL CLOSURE ENGINE - FINAL RT-8(C)
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-white" onclick="window.print()">
                        <i class="bi bi-printer-fill text-info"></i> Print Final Report
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-file-earmark-pdf-fill text-danger"></i> Export PDF
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-file-earmark-excel-fill text-success"></i> Export Excel
                    </button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5 bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close Engine
                    </a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <div class="filter-card shadow-sm mx-auto" style="max-width: 900px;">
                        <form action="GenerateRT8CServlet" method="GET" class="row g-3 align-items-end justify-content-center">
                            <div class="col-auto">
                                <label class="small fw-bold text-muted text-uppercase mb-1 d-block">Select Crushing Season</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="bi bi-calendar-range"></i></span>
                                    <select class="form-select" name="seasonYear" required>
                                        <option value="2025-2026" selected>2025-2026 (Current)</option>
                                        <option value="2024-2025">2024-2025</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE FINAL DATA
                                </button>
                            </div>
                        </form>
                    </div>

                    <div id="printableArea" class="report-paper shadow">
                        <div class="report-header-box text-center">
                            <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                            <p class="report-subtitle">Tal. Indapur, Dist. Pune, Maharashtra - 413 106</p>
                        </div>
                        
                        <div class="excise-header">FORM R.T. 8 (C) - FINAL MANUFACTURING REPORT</div>
                        
                        <div class="row mb-4" style="font-size: 0.9rem; font-weight: bold;">
                            <div class="col-6">CRUSHING SEASON: 2025-2026</div>
                            <div class="col-6 text-end">REPORT DATE: 30-APR-2026</div>
                            <div class="col-6">PLANT CAPACITY: 3500 TCD</div>
                            <div class="col-6 text-end">TOTAL OPERATIONAL DAYS: 165</div>
                        </div>

                        <table class="table-report">
                            <thead>
                                <tr><th colspan="3" class="section-header">1.0 Milling & Technical Efficiency Performance</th></tr>
                                <tr>
                                    <th style="width: 50%; text-align: left;">Particulars</th>
                                    <th class="text-end">Current (2025-26)</th>
                                    <th class="text-end">Previous (2024-25)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td class="row-label">Total Cane Crushed (MT)</td><td class="text-end fw-bold">575,250.000</td><td class="text-end">540,100.000</td></tr>
                                <tr><td class="row-label">Average Recovery % Cane</td><td class="text-end fw-bold text-primary">11.45</td><td class="text-end text-muted">11.20</td></tr>
                                <tr><td class="row-label">Mill Extraction %</td><td class="text-end fw-bold">96.15</td><td class="text-end">95.80</td></tr>
                                <tr><td class="row-label">Reduced Mill Extraction %</td><td class="text-end fw-bold">96.50</td><td class="text-end">96.20</td></tr>
                                <tr><td class="row-label">Total Sugar Losses % Cane</td><td class="text-end fw-bold text-danger">2.05</td><td class="text-end">2.15</td></tr>
                            </tbody>
                        </table>

                        <table class="table-report">
                            <thead>
                                <tr><th colspan="3" class="section-header">2.0 Bagasse Energy Balance (MT)</th></tr>
                                <tr>
                                    <th style="width: 50%; text-align: left;">Energy Particulars</th>
                                    <th class="text-end">Current Season</th>
                                    <th class="text-end">Previous Season</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td class="row-label">Total Bagasse Produced</td><td class="text-end fw-bold">161,070.000</td><td class="text-end">151,228.000</td></tr>
                                <tr><td class="row-label">Used for Sugar Mill Boiler</td><td class="text-end">105,000.000</td><td class="text-end">102,500.000</td></tr>
                                <tr><td class="row-label">Used for Co-Generation Unit</td><td class="text-end">45,000.000</td><td class="text-end">40,000.000</td></tr>
                                <tr class="bg-light fw-bold" style="border-top: 2px solid #000;">
                                    <td>NET BAGASSE SAVED (MT)</td>
                                    <td class="text-end text-success">22,070.000</td>
                                    <td class="text-end">17,500.000</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table-report">
                            <thead>
                                <tr><th colspan="3" class="section-header">3.0 Operational Consumables & Utilities</th></tr>
                                <tr>
                                    <th style="width: 50%; text-align: left;">Particulars</th>
                                    <th class="text-end">Current Season</th>
                                    <th class="text-end">Previous Season</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td class="row-label">Sulphur Consumption % Cane</td><td class="text-end">0.055</td><td class="text-end">0.060</td></tr>
                                <tr><td class="row-label">Total Electricity Generated (KWH)</td><td class="text-end fw-bold">18,500,000</td><td class="text-end">17,200,000</td></tr>
                            </tbody>
                        </table>
                        
                        <div class="row text-center" style="margin-top: 60px;">
                            <div class="col-3">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">CHIEF CHEMIST</span>
                            </div>
                            <div class="col-3">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">CHIEF ENGINEER</span>
                            </div>
                            <div class="col-3">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">MANAGING DIRECTOR</span>
                            </div>
                            <div class="col-3">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">CENTRAL EXCISE / GST</span>
                                <br><span class="text-muted small">(Seal & Signature)</span>
                            </div>
                        </div>
                    </div></div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>