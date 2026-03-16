<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RT-7(C) Statutory Report | Sugar ERP</title>
    
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
            min-height: 850px; 
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

        /* Search Filter Card */
        .filter-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        /* --- Report Paper Styling (Print Focus) --- */
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
        .excise-header { text-align: center; font-weight: 900; font-size: 1.4rem; margin: 20px 0; text-decoration: underline; text-underline-offset: 8px; }

        /* Technical Data Table */
        .table-report { width: 100%; border-collapse: collapse; border: 1.5px solid #000; margin-bottom: 25px; }
        .table-report th { 
            background-color: #f3f4f6 !important; 
            border: 1px solid #000; 
            text-align: center; 
            padding: 8px; 
            font-size: 0.75rem; 
            text-transform: uppercase;
            font-weight: 800;
        }
        .table-report td { 
            border: 1px solid #000; 
            padding: 6px 12px; 
            font-size: 0.85rem; 
            font-family: 'JetBrains Mono', monospace; /* Professional numeric alignment */
        }
        
        .section-header { 
            background-color: #000 !important; 
            color: #fff !important; 
            font-weight: 800 !important; 
            text-transform: uppercase;
            font-size: 0.8rem !important;
            font-family: 'Inter', sans-serif !important;
        }

        .signature-line { border-top: 1.5px solid #000; width: 85%; margin: 100px auto 10px auto; }
        
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
                    <li class="breadcrumb-item active text-muted">Statutory Reports</li>
                    <li class="breadcrumb-item active text-primary">Form RT-7(C)</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-file-earmark-check-fill"></i> STATUTORY COMPLIANCE ENGINE - MONTHLY RT-7(C)
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-white" onclick="window.print()">
                        <i class="bi bi-printer-fill text-info"></i> Print RT-7(C)
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
                        <form action="GenerateRT7CServlet" method="GET" class="row g-3 align-items-end justify-content-center">
                            <div class="col-auto">
                                <label class="small fw-bold text-muted text-uppercase mb-1 d-block">Report Month</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="bi bi-calendar3"></i></span>
                                    <input type="month" class="form-control" name="reportMonth" value="2025-12" required>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE STATUTORY DATA
                                </button>
                            </div>
                        </form>
                    </div>

                    <div id="printableArea" class="report-paper shadow">
                        <div class="report-header-box text-center">
                            <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                            <p class="report-subtitle">Tal. Indapur, Dist. Pune, Maharashtra - 413 106</p>
                        </div>
                        
                        <div class="excise-header">FORM R.T. 7 (C)</div>
                        
                        <div class="row mb-4" style="font-size: 0.9rem; font-weight: bold;">
                            <div class="col-6">CRUSHING SEASON: 2025-2026</div>
                            <div class="col-6 text-end">MONTH: DECEMBER 2025</div>
                            <div class="col-6">GSTIN: 27AAAAA0000A1Z5</div>
                            <div class="col-6 text-end">FILING DATE: 01-JAN-2026</div>
                        </div>

                        <table class="table-report">
                            <thead>
                                <tr><th colspan="3" class="section-header">1.0 Manufacturing Efficiency Summary</th></tr>
                                <tr>
                                    <th style="width: 50%; text-align: left;">Particulars</th>
                                    <th class="text-end">For the Month</th>
                                    <th class="text-end">To-Date (Season)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fw-semibold">Cane Crushed (MT)</td>
                                    <td class="text-end">105,420.000</td>
                                    <td class="text-end">350,890.500</td>
                                </tr>
                                <tr>
                                    <td class="fw-semibold">Sugar Bagged (Qtls)</td>
                                    <td class="text-end">118,500.00</td>
                                    <td class="text-end">395,200.00</td>
                                </tr>
                                <tr>
                                    <td class="fw-semibold">Sugar in Process (Qtls)</td>
                                    <td class="text-end">1,250.00</td>
                                    <td class="text-end">1,250.00</td>
                                </tr>
                                <tr class="bg-light fw-bold" style="border-top: 2px solid #000;">
                                    <td>TOTAL NET SUGAR MADE (QTLS)</td>
                                    <td class="text-end">119,750.00</td>
                                    <td class="text-end">396,450.00</td>
                                </tr>
                                <tr class="bg-dark text-white fw-bold">
                                    <td class="text-white">RECOVERY % CANE</td>
                                    <td class="text-end text-white">11.36</td>
                                    <td class="text-end text-white">11.29</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table-report">
                            <thead>
                                <tr><th colspan="7" class="section-header">2.0 Statement of In-Process Stocks (W.I.P.)</th></tr>
                                <tr>
                                    <th style="width: 20%; text-align: left;">Material</th>
                                    <th class="text-end">Volume (HL)</th>
                                    <th class="text-end">Sp. Gr.</th>
                                    <th class="text-end">Brix%</th>
                                    <th class="text-end">Pol%</th>
                                    <th class="text-end">Purity%</th>
                                    <th class="text-end">Avail. Sugar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>Clear Juice</td><td class="text-end">450.00</td><td class="text-end">1.06</td><td class="text-end">15.50</td><td class="text-end">13.20</td><td class="text-end">85.16</td><td class="text-end fw-bold">45.20</td></tr>
                                <tr><td>Sulphited Syrup</td><td class="text-end">350.00</td><td class="text-end">1.28</td><td class="text-end">56.10</td><td class="text-end">47.20</td><td class="text-end">84.13</td><td class="text-end fw-bold">545.80</td></tr>
                                <tr><td>A-Massecuite</td><td class="text-end">280.00</td><td class="text-end">1.48</td><td class="text-end">92.50</td><td class="text-end">78.50</td><td class="text-end">84.86</td><td class="text-end fw-bold">278.50</td></tr>
                                <tr><td>C-Massecuite</td><td class="text-end">410.00</td><td class="text-end">1.52</td><td class="text-end">98.50</td><td class="text-end">58.20</td><td class="text-end">59.08</td><td class="text-end fw-bold">200.00</td></tr>
                                <tr class="bg-light fw-bold">
                                    <td colspan="6" class="text-end">CONSOLIDATED SUGAR IN PROCESS (QTLS):</td>
                                    <td class="text-end text-primary">1,250.00</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table-report">
                            <thead>
                                <tr><th colspan="5" class="section-header">3.0 Final Sugar Inventory Account (Qtls)</th></tr>
                                <tr>
                                    <th style="width: 24%; text-align: left;">Grade</th>
                                    <th class="text-end">Opening Bal</th>
                                    <th class="text-end">Produced</th>
                                    <th class="text-end">Dispatched</th>
                                    <th class="text-end">Closing Bal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td class="fw-semibold">L-30 Grade</td><td class="text-end">25,000.00</td><td class="text-end">12,500.00</td><td class="text-end">10,000.00</td><td class="text-end fw-bold">27,500.00</td></tr>
                                <tr><td class="fw-semibold">M-30 Grade</td><td class="text-end">120,000.00</td><td class="text-end">90,000.00</td><td class="text-end">45,000.00</td><td class="text-end fw-bold">165,000.00</td></tr>
                                <tr><td class="fw-semibold">S1-30 Grade</td><td class="text-end">18,000.00</td><td class="text-end">15,000.00</td><td class="text-end">5,000.00</td><td class="text-end fw-bold">28,000.00</td></tr>
                                <tr class="bg-light fw-bold" style="border-top: 2px solid #000;">
                                    <td>GRAND TOTAL (QTLS)</td>
                                    <td class="text-end">164,200.00</td>
                                    <td class="text-end">118,500.00</td>
                                    <td class="text-end">60,000.00</td>
                                    <td class="text-end text-primary">222,700.00</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row text-center" style="margin-top: 50px;">
                            <div class="col-4">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">CHIEF CHEMIST</span>
                            </div>
                            <div class="col-4">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">MANAGING DIRECTOR</span>
                            </div>
                            <div class="col-4">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">EXCISE INSPECTOR / GST OFFICER</span>
                                <br><span class="text-muted" style="font-size: 0.65rem;">(Official Seal & Signature)</span>
                            </div>
                        </div>
                    </div></div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>