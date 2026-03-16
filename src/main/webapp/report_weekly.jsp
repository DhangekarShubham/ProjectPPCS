<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="weeklyReportApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weekly Performance Report | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportWeekly.js"></script>

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
            text-transform: uppercase;
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Modern Sidebar */
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

        /* Search Filter Controls */
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
            max-width: 950px; 
            color: #000;
        }

        .report-header-section { border-bottom: 3px solid #000; margin-bottom: 25px; padding-bottom: 10px; }
        .report-title { text-align: center; font-weight: 800; font-size: 1.5rem; text-transform: uppercase; margin: 0; }
        .report-subtitle { text-align: center; font-weight: 700; font-size: 1.1rem; color: #4b5563; }

        /* Performance Table Styling */
        .table-report { width: 100%; border-collapse: collapse; border: 1.5px solid #000; }
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
            padding: 8px 12px; 
            font-size: 0.88rem; 
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

        .particulars-col { font-family: 'Inter', sans-serif !important; font-weight: 600; color: #1f2937; }

        /* Signature Lines */
        .signature-line { border-top: 1.5px solid #000; width: 80%; margin: 80px auto 10px auto; }

        @media print {
            body { background: white; }
            .navbar, .sidebar-panel, .filter-card, .btn-sm { display: none !important; }
            .main-panel { padding: 0; background: white; }
            .app-window { box-shadow: none; margin: 0; border: none; }
            .window-header { display: none; }
            .report-paper { box-shadow: none; border: none; padding: 20px; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body ng-controller="WeeklyReportController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Weekly Reports</li>
                    <li class="breadcrumb-item active text-primary">Manufacturing & Performance</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-calendar-range-fill"></i> WEEKLY MANUFACTURING PERFORMANCE ENGINE
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-white" ng-click="printReport()">
                        <i class="bi bi-printer-fill text-info"></i> Print Report
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
                        <form name="searchForm" class="row g-3 align-items-end justify-content-center" novalidate>
                            <div class="col-auto">
                                <label class="small fw-bold text-muted text-uppercase mb-1 d-block">Week No.</label>
                                <input type="number" class="form-control form-control-sm" ng-model="weekNo" style="width: 80px;" required>
                            </div>
                            <div class="col-auto">
                                <label class="small fw-bold text-muted text-uppercase mb-1 d-block">From Date</label>
                                <input type="date" class="form-control form-control-sm" ng-model="fromDate" required>
                            </div>
                            <div class="col-auto">
                                <label class="small fw-bold text-muted text-uppercase mb-1 d-block">To Date</label>
                                <input type="date" class="form-control form-control-sm" ng-model="toDate" required>
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm" ng-click="generateReport()">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE
                                </button>
                            </div>
                        </form>
                    </div>

                    <div id="printableArea" class="report-paper shadow" ng-show="isDataLoaded">
                        <div class="report-header-section text-center">
                            <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                            <h5 class="report-subtitle">Weekly Manufacturing & Technical Performance Report</h5>
                        </div>
                        
                        <div class="row mb-4" style="font-size: 0.9rem; font-weight: bold;">
                            <div class="col-4">SEASON: {{ report.seasonYear }}</div>
                            <div class="col-4 text-center">WEEK NO: <span class="text-primary">{{ report.weekNo }}</span></div>
                            <div class="col-4 text-end">PERIOD: {{ displayFromDate }} TO {{ displayToDate }}</div>
                        </div>

                        <table class="table-report">
                            <thead>
                                <tr>
                                    <th style="width: 40%; text-align: left;">OPERATIONAL PARTICULARS</th>
                                    <th class="text-end">THIS WEEK</th>
                                    <th class="text-end">TO-DATE (SEASON)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td class="section-header" colspan="3">1.0 Throughput & Production Metrics</td></tr>
                                <tr>
                                    <td class="particulars-col">Total Cane Crushed (MT)</td>
                                    <td class="text-end fw-bold">{{ report.caneCrushedWeek | number:3 }}</td>
                                    <td class="text-end">{{ report.caneCrushedTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td class="particulars-col">Total Sugar Made (Qtls)</td>
                                    <td class="text-end fw-bold">{{ report.totalSugarMadeWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.totalSugarMadeTodate | number:2 }}</td>
                                </tr>
                                <tr class="bg-dark text-white fw-bold">
                                    <td class="text-white">AVERAGE RECOVERY % CANE</td>
                                    <td class="text-end text-white">{{ report.recoveryWeek | number:2 }}</td>
                                    <td class="text-end text-white">{{ report.recoveryTodate | number:2 }}</td>
                                </tr>

                                <tr><td class="section-header" colspan="3">2.0 Efficiency & Technical Losses (%)</td></tr>
                                <tr>
                                    <td class="particulars-col">Reduced Mill Extraction</td>
                                    <td class="text-end fw-bold">{{ report.redMillExtWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.redMillExtTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="particulars-col">Boiling House Extraction</td>
                                    <td class="text-end fw-bold">{{ report.boilingHouseExtWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.boilingHouseExtTodate | number:2 }}</td>
                                </tr>
                                <tr class="bg-light fw-bold" style="border-top: 2px solid #000;">
                                    <td>OVERALL EXTRACTION (%)</td>
                                    <td class="text-end text-primary">{{ report.overallExtWeek | number:2 }}</td>
                                    <td class="text-end text-primary">{{ report.overallExtTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="particulars-col">Total Sugar Losses % Cane</td>
                                    <td class="text-end fw-bold text-danger">{{ report.sugarLossesWeek | number:2 }}</td>
                                    <td class="text-end text-danger">{{ report.sugarLossesTodate | number:2 }}</td>
                                </tr>

                                <tr><td class="section-header" colspan="3">3.0 Time Account & Crushing Rate</td></tr>
                                <tr>
                                    <td class="particulars-col">Actual Crushing Hours</td>
                                    <td class="text-end">{{ report.crushingHrsWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.crushingHrsTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="particulars-col">Crushing Rate per 24 Hrs (MT)</td>
                                    <td class="text-end fw-bold">{{ report.crushRateWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.crushRateTodate | number:2 }}</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row text-center">
                            <div class="col-4">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">CHIEF CHEMIST</span>
                            </div>
                            <div class="col-4">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">WORKS MANAGER</span>
                            </div>
                            <div class="col-4">
                                <div class="signature-line"></div>
                                <span class="small fw-bold">MANAGING DIRECTOR</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert-custom w-75 mx-auto text-center border-0 shadow-sm" ng-hide="isDataLoaded" style="background: #eef2ff; color: #4338ca;">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        <strong>System Notice:</strong> Please enter the target Week Number and date range to compute performance metrics.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>