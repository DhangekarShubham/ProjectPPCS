<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="dailyTonApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Tonnage Report | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    

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

        /* Main Workspace */
        .main-panel { background-color: var(--bg-light); padding: 30px; }

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

        .report-title { 
            text-align: center; 
            font-weight: 800; 
            font-size: 1.5rem; 
            text-transform: uppercase;
            margin-bottom: 5px; 
        }

        .report-subtitle { 
            text-align: center; 
            font-weight: 700; 
            font-size: 1.1rem; 
            margin-bottom: 25px;
            text-decoration: underline;
            text-underline-offset: 5px;
        }

        /* Table Components */
        .table-report { width: 100%; border-collapse: collapse; border: 1.5px solid #000; }
        
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
            font-family: 'Inter', sans-serif !important;
            text-transform: uppercase;
            font-size: 0.8rem !important;
        }
        
        .source-label { font-family: 'Inter', sans-serif !important; font-weight: 600; }

        /* Print Settings */
        @media print {
            body { background: white; }
            .navbar, .sidebar-panel, .btn-outline-dark, form, .alert { display: none !important; }
            .main-panel { padding: 0; background: white; }
            .app-window { box-shadow: none; margin: 0; border: none; }
            .window-header { display: none; }
            .report-paper { box-shadow: none; border: none; padding: 20px; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body ng-controller="DailyTonController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Reporting</li>
                    <li class="breadcrumb-item active text-primary">Daily Tonnage Report</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-truck-flatbed"></i> CANE YARD MANAGEMENT - DAILY TONNAGE REPORT
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-white" ng-click="printReport()">
                        <i class="bi bi-printer-fill text-info"></i> Print Report
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-file-earmark-pdf-fill text-danger"></i> Export to PDF
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-file-earmark-excel-fill text-success"></i> Export to Excel
                    </button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-5 bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close Engine
                    </a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <form name="searchForm" class="mb-5 bg-white p-4 border rounded shadow-sm w-75 mx-auto" novalidate>
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-muted text-uppercase small">Select Tonnage Date:</label>
                            <div class="col-auto">
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white border-secondary"><i class="bi bi-calendar3"></i></span>
                                    <input type="date" class="form-control border-secondary" ng-model="selectedDate" required>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm" ng-click="generateReport()">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE REPORT
                                </button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper shadow" ng-show="isDataLoaded">
                        <div class="text-center border-bottom border-3 border-dark mb-4 pb-2">
                            <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                            <h5 class="report-subtitle">Daily Cane Crushing (Tonnage) Report</h5>
                        </div>
                        
                        <div class="row mb-4" style="font-size: 0.95rem; font-weight: bold;">
                            <div class="col-4">SEASON: {{ report.seasonYear }}</div>
                            <div class="col-4 text-center">CROP DAY: <span class="text-primary">{{ report.cropDay }}</span></div>
                            <div class="col-4 text-end">DATE: {{ displayDate }}</div>
                        </div>

                        <table class="table-report mb-4">
                            <thead>
                                <tr>
                                    <th style="width: 25%; text-align: left;">SHIFT DETAILS</th>
                                    <th class="text-end">CANE CRUSHED (MT)</th>
                                    <th class="text-end">HOURS WORKED</th>
                                    <th class="text-end">CRUSHING RATE (MT/HR)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="source-label">Shift A (06:00 - 14:00)</td>
                                    <td class="text-end fw-bold">{{ report.shiftACane | number:3 }}</td>
                                    <td class="text-end">{{ report.shiftAHours | number:2 }}</td>
                                    <td class="text-end">{{ report.rateA | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="source-label">Shift B (14:00 - 22:00)</td>
                                    <td class="text-end fw-bold">{{ report.shiftBCane | number:3 }}</td>
                                    <td class="text-end">{{ report.shiftBHours | number:2 }}</td>
                                    <td class="text-end">{{ report.rateB | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="source-label">Shift C (22:00 - 06:00)</td>
                                    <td class="text-end fw-bold">{{ report.shiftCCane | number:3 }}</td>
                                    <td class="text-end">{{ report.shiftCHours | number:2 }}</td>
                                    <td class="text-end">{{ report.rateC | number:2 }}</td>
                                </tr>
                                <tr class="bg-light fw-bold" style="border-top: 2px solid #000;">
                                    <td class="source-label">TOTAL TODAY</td>
                                    <td class="text-end">{{ report.totalCaneToday | number:3 }}</td>
                                    <td class="text-end">{{ report.totalHoursToday | number:2 }}</td>
                                    <td class="text-end">{{ report.rateTotalToday | number:2 }}</td>
                                </tr>
                                <tr class="bg-dark text-white fw-bold">
                                    <td class="source-label text-white">TOTAL TO-DATE</td>
                                    <td class="text-end text-white">{{ report.totalCaneTodate | number:3 }}</td>
                                    <td class="text-end text-white">{{ report.totalHoursTodate | number:2 }}</td>
                                    <td class="text-end text-white">{{ report.rateTotalTodate | number:2 }}</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table-report">
                            <thead>
                                <tr>
                                    <th style="width: 40%; text-align: left;">SOURCE & TRANSPORT CATEGORY</th>
                                    <th class="text-end">TODAY (MT)</th>
                                    <th class="text-end">TO-DATE (MT)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="section-header" colspan="3">1.0 Grower Membership Status</td>
                                </tr>
                                <tr>
                                    <td class="source-label" style="padding-left: 20px;">Member Cane</td>
                                    <td class="text-end">{{ report.memberCaneToday | number:3 }}</td>
                                    <td class="text-end fw-bold">{{ report.memberCaneTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td class="source-label" style="padding-left: 20px;">Non-Member / Outside Cane</td>
                                    <td class="text-end">{{ report.nonMemberCaneToday | number:3 }}</td>
                                    <td class="text-end fw-bold">{{ report.nonMemberCaneTodate | number:3 }}</td>
                                </tr>
                                
                                <tr>
                                    <td class="section-header" colspan="3">2.0 Logistics / Transport Mode</td>
                                </tr>
                                <tr>
                                    <td class="source-label" style="padding-left: 20px;">Bullock Cart</td>
                                    <td class="text-end">{{ report.bullockCartToday | number:3 }}</td>
                                    <td class="text-end">{{ report.bullockCartTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td class="source-label" style="padding-left: 20px;">Tractor (Single/Double Trolley)</td>
                                    <td class="text-end">{{ report.tractorToday | number:3 }}</td>
                                    <td class="text-end">{{ report.tractorTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td class="source-label" style="padding-left: 20px;">Truck / 10-Wheeler</td>
                                    <td class="text-end">{{ report.truckToday | number:3 }}</td>
                                    <td class="text-end">{{ report.truckTodate | number:3 }}</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5 pt-5 text-center">
                            <div class="col-4">
                                <div style="border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto;"></div>
                                <span class="fw-bold small">CANE YARD SUPERVISOR</span>
                            </div>
                            <div class="col-4">
                                <div style="border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto;"></div>
                                <span class="fw-bold small">CHIEF CHEMIST</span>
                            </div>
                            <div class="col-4">
                                <div style="border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto;"></div>
                                <span class="fw-bold small">MANAGING DIRECTOR</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert-custom w-75 mx-auto text-center border-0 shadow-sm" ng-hide="isDataLoaded" style="background: #eef2ff; color: #4338ca;">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        <strong>System Notice:</strong> Please select a target date and click Generate to retrieve the Yard Tonnage logs.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>