<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analysis Report | Sugar ERP</title>
    
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

        /* ERP Layout */
        .app-window { 
            background: #ffffff; 
            border-radius: 12px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-top: 20px;
            border: none;
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
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Sidebar Actions */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 800px; 
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

        /* Report Controls */
        .filter-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        /* --- Report Paper Styling --- */
        .report-paper { 
            background-color: white; 
            padding: 50px; 
            border: 1px solid #d1d5db; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            margin: 0 auto; 
            max-width: 900px; 
            color: #000;
        }

        .report-header-section {
            border-bottom: 3px solid #000;
            margin-bottom: 25px;
            padding-bottom: 10px;
        }

        .report-title { 
            text-align: center; 
            font-weight: 800; 
            font-size: 1.6rem; 
            text-transform: uppercase;
            margin-bottom: 2px;
        }

        .report-subtitle { 
            text-align: center; 
            font-weight: 600; 
            font-size: 1.1rem; 
            color: #4b5563;
        }

        /* High Contrast Table for Reports */
        .table-report { width: 100%; margin-bottom: 20px; border: 1.5px solid #000; }
        .table-report th { 
            background-color: #f3f4f6 !important; 
            border: 1px solid #000; 
            text-align: center; 
            padding: 8px; 
            font-size: 0.75rem; 
            text-transform: uppercase;
            font-weight: 700;
        }
        .table-report td { 
            border: 1px solid #000; 
            padding: 6px 10px; 
            font-size: 0.85rem; 
            font-family: 'JetBrains Mono', monospace; 
        }
        
        .section-header { 
            background-color: #000 !important; 
            color: #fff !important; 
            font-weight: bold; 
            text-align: center !important; 
        }
        
        .signature-line {
            border-top: 1.5px solid #000;
            width: 80%;
            margin: 0 auto 5px auto;
        }

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

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Reports</li>
                    <li class="breadcrumb-item active text-primary">Daily Analysis</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-file-earmark-bar-graph-fill"></i> ANALYTICAL REPORT ENGINE
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2" onclick="window.print()">
                        <i class="bi bi-printer-fill"></i> Print Report
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

                <div class="col-md-10 main-panel p-4">
                    
                    <div class="filter-card shadow-sm mx-auto" style="max-width: 900px;">
                        <form action="GenerateDailyAnalysisServlet" method="GET" class="row g-3 align-items-end justify-content-center">
                            <div class="col-auto">
                                <label class="small fw-bold text-muted text-uppercase mb-1 d-block">Select Report Date</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="bi bi-calendar3"></i></span>
                                    <input type="date" class="form-control" name="reportDate" required>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE REPORT
                                </button>
                            </div>
                        </form>
                    </div>

                    <div id="printableArea" class="report-paper">
                        <div class="report-header-section text-center">
                            <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                            <h5 class="report-subtitle">Daily Laboratory Analysis Report</h5>
                        </div>
                        
                        <div class="row mb-3" style="font-size: 0.9rem;">
                            <div class="col-6"><strong>CRUSHING SEASON:</strong> 2025-2026</div>
                            <div class="col-6 text-end"><strong>REPORT DATE:</strong> 15-DEC-2025</div>
                        </div>

                        <div class="row g-2">
                            <div class="col-md-6">
                                <table class="table-report">
                                    <thead>
                                        <tr><th colspan="2" class="section-header">Time & Throughput</th></tr>
                                        <tr><th>Particulars</th><th class="text-end">Value</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Actual Working Hours</td><td class="text-end fw-bold">21.50</td></tr>
                                        <tr><td>Total Lost Hours</td><td class="text-end">2.50</td></tr>
                                        <tr><td>Member Cane (MT)</td><td class="text-end">3050.00</td></tr>
                                        <tr><td>Non-Member Cane (MT)</td><td class="text-end">250.00</td></tr>
                                        <tr class="fw-bold" style="border-top: 2px solid #000;"><td>Total Crushed (MT)</td><td class="text-end">3300.00</td></tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-md-6">
                                <table class="table-report">
                                    <thead>
                                        <tr><th colspan="2" class="section-header">Corrections & Recovery</th></tr>
                                        <tr><th>Particulars</th><th class="text-end">Value</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Dirt Correction (%)</td><td class="text-end">0.55</td></tr>
                                        <tr><td>Recovery Correction</td><td class="text-end">0.00</td></tr>
                                        <tr><td>Undetermined Losses</td><td class="text-end">0.18</td></tr>
                                        <tr><td>Condenser Inlet (°C)</td><td class="text-end">32.50</td></tr>
                                        <tr><td>Condenser Outlet (°C)</td><td class="text-end">45.20</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row g-2 mt-2">
                            <div class="col-md-6">
                                <table class="table-report">
                                    <thead>
                                        <tr><th colspan="3" class="section-header">By-Product Analysis</th></tr>
                                        <tr><th>Item</th><th class="text-end">Pol %</th><th class="text-end">Moist %</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Bagasse</td><td class="text-end">2.15</td><td class="text-end">49.50</td></tr>
                                        <tr><td>Filter Cake</td><td class="text-end">1.85</td><td class="text-end">70.20</td></tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-md-6">
                                <table class="table-report">
                                    <thead>
                                        <tr><th colspan="2" class="section-header">Sugar Production (Bags)</th></tr>
                                        <tr><th>Grade Grade</th><th class="text-end">Units</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>M-30 (50 Kg)</td><td class="text-end">4,500</td></tr>
                                        <tr><td>S1-30 (50 Kg)</td><td class="text-end">850</td></tr>
                                        <tr class="fw-bold" style="border-top: 2px solid #000;"><td>Total Bags</td><td class="text-end">5,350</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-12">
                                <table class="table-report">
                                    <thead>
                                        <tr><th colspan="4" class="section-header">Process Products Analysis</th></tr>
                                        <tr>
                                            <th style="width: 40%; text-align: left;">Product Name</th>
                                            <th class="text-end">Brix %</th>
                                            <th class="text-end">Pol %</th>
                                            <th class="text-end">Purity %</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Primary Juice</td><td class="text-end">19.85</td><td class="text-end">16.80</td><td class="text-end">84.63</td></tr>
                                        <tr><td>Mixed Juice</td><td class="text-end">14.50</td><td class="text-end">11.90</td><td class="text-end">82.06</td></tr>
                                        <tr><td>Clear Juice</td><td class="text-end">15.10</td><td class="text-end">12.45</td><td class="text-end">82.45</td></tr>
                                        <tr><td>Final Molasses</td><td class="text-end">86.10</td><td class="text-end">27.01</td><td class="text-end">31.37</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="row mt-5 pt-5">
                            <div class="col-4 text-center small fw-bold">
                                <div class="signature-line"></div>
                                LAB CHEMIST
                            </div>
                            <div class="col-4 text-center small fw-bold">
                                <div class="signature-line"></div>
                                CHIEF CHEMIST
                            </div>
                            <div class="col-4 text-center small fw-bold">
                                <div class="signature-line"></div>
                                MANAGING DIRECTOR
                            </div>
                        </div>
                    </div></div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>