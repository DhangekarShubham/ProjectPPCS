<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="analysisApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Data Analysis | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/dailyAnalysis.js"></script>

    <style>
        :root {
            --primary-blue: #2563eb;
            --sidebar-dark: #1e293b;
            --bg-light: #f1f5f9;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
            --accent-red: #ef4444;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-main);
            font-size: 0.88rem;
        }

        /* App Window Styling */
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
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Modern Sidebar */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 750px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 10px; 
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1); 
            color: #cbd5e1;
            text-align: left;
            padding: 10px 15px;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            border-radius: 8px;
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            transform: translateX(5px);
        }

        /* Tabs Styling */
        .nav-tabs { border-bottom: 2px solid var(--border-color); }
        .nav-tabs .nav-link { 
            border: none; 
            color: #64748b; 
            font-weight: 600; 
            padding: 12px 20px; 
        }
        .nav-tabs .nav-link.active { 
            color: var(--primary-blue); 
            border-bottom: 3px solid var(--primary-blue); 
            background: transparent;
        }

        /* Grid & Table Components */
        .grid-title { 
            font-size: 0.75rem; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            color: #64748b; 
            font-weight: 700; 
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        .grid-title::before {
            content: "";
            display: inline-block;
            width: 4px;
            height: 14px;
            background: var(--primary-blue);
            margin-right: 8px;
            border-radius: 2px;
        }

        .table-container { 
            background-color: white; 
            border: 1px solid var(--border-color); 
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .table thead th { 
            background-color: #f8fafc; 
            font-size: 0.7rem; 
            text-transform: uppercase;
            color: #475569;
            padding: 10px;
        }

        .table td { vertical-align: middle; padding: 6px 10px; border-color: #f1f5f9; }

        /* Input Optimization */
        .form-control-sm {
            border: 1px solid #d1d5db;
            border-radius: 4px;
            text-align: right;
            font-weight: 600;
            color: var(--primary-blue);
            padding: 4px 8px;
        }
        .form-control-sm:focus {
            background-color: #eff6ff;
            border-color: var(--primary-blue);
            box-shadow: none;
        }

        .sample-date-card {
            background: #f8fafc;
            border: 1px solid var(--border-color);
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body ng-controller="AnalysisController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Transaction</li>
                    <li class="breadcrumb-item active">Daily Analysis</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-clipboard-data-fill"></i> DAILY DATA ANALYSIS & PROCESS LOG
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">
                        <i class="bi bi-plus-lg"></i> New Entry
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-search"></i> Find Record
                    </button>
                    <button type="button" class="btn action-btn" ng-click="changeData()">
                        <i class="bi bi-pencil-square"></i> Change
                    </button>
                    <button type="button" class="btn action-btn" ng-click="saveData()">
                        <i class="bi bi-cloud-arrow-up-fill"></i> Save Data
                    </button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()">
                        <i class="bi bi-arrow-counterclockwise"></i> Cancel
                    </button>
                    <button type="button" class="btn action-btn text-danger">
                        <i class="bi bi-trash3"></i> Delete
                    </button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-auto bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close Log
                    </a>
                </div>

                <div class="flex-grow-1 p-4" style="background: #fff;">
                    <form name="analysisForm" novalidate>
                        
                        <div class="sample-date-card d-flex align-items-center shadow-sm">
                            <i class="bi bi-calendar3 me-3 text-primary fs-5"></i>
                            <div style="width: 200px;">
                                <label class="small fw-bold text-muted mb-1 d-block text-uppercase">Analysis Date</label>
                                <input type="date" class="form-control" ng-model="analysis.sampleDate" required>
                            </div>
                            <div class="ms-auto">
                                <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">
                                    <i class="bi bi-info-circle me-1"></i> Data Entry Mode: Single Day
                                </span>
                            </div>
                        </div>

                        <ul class="nav nav-tabs mb-4" id="analysisTabs" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" id="screen1-tab" data-bs-toggle="tab" data-bs-target="#screen1" type="button" role="tab">
                                    <i class="bi bi-clock-history me-2"></i>Losses & Time Account
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" id="screen2-tab" data-bs-toggle="tab" data-bs-target="#screen2" type="button" role="tab">
                                    <i class="bi bi-beaker me-2"></i>Process Product Analysis
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="analysisTabsContent">
                            <div class="tab-pane fade show active" id="screen1" role="tabpanel">
                                <div class="row g-4">
                                    <div class="col-md-4">
                                        <div class="grid-title">Crushing & Weight Data</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Parameter</th><th class="text-end">Weight (MT)</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Filter Cake</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.fcWeight"></td></tr>
                                                    <tr><td>Member Cane</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.memberCane"></td></tr>
                                                    <tr><td>Non-Member Cane</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.nonMemberCane"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="grid-title">Time Management</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Operation</th><th class="text-end">Hours</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Working Hours</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.workHours"></td></tr>
                                                    <tr><td>Mechanical Loss</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.lostMech"></td></tr>
                                                    <tr><td>Electrical Loss</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.lostElec"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="grid-title">Solid Waste Analysis</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Material</th><th>Pol%</th><th>Moist%</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Bagasse</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.bagassePol"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.bagasseMoist"></td>
                                                    </tr>
                                                    <tr><td>Filter Cake</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.fcPol"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.fcMoist"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row g-4 mt-1">
                                    <div class="col-md-6">
                                        <div class="grid-title">Efficiency Corrections</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Correction Type</th><th class="text-end">Percentage (%)</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Dirt Correction</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.dirtCorrection"></td></tr>
                                                    <tr><td>Recovery Correction</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.recoveryCorrection"></td></tr>
                                                    <tr><td>Undetermined Losses</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.undetLosses"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="grid-title">Thermal Parameters</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Condenser Measurement</th><th class="text-end">Temp (°C)</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Inlet Temperature</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.inletTemp"></td></tr>
                                                    <tr><td>Outlet Temperature</td><td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.outletTemp"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="screen2" role="tabpanel">
                                <div class="row g-4">
                                    <div class="col-md-4">
                                        <div class="grid-title">Sugar Production (Bags)</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Grade</th><th class="text-end">Units</th></tr></thead>
                                                <tbody>
                                                    <tr><td>L-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm" ng-model="analysis.bagsL30_50"></td></tr>
                                                    <tr><td>M-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm" ng-model="analysis.bagsM30_50"></td></tr>
                                                    <tr><td>S1-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm" ng-model="analysis.bagsS130_50"></td></tr>
                                                    <tr><td>Raw Sugar (50 Kg)</td><td><input type="number" class="form-control form-control-sm" ng-model="analysis.bagsRaw_50"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="col-md-8">
                                        <div class="grid-title">Laboratory Analysis (Juice & Massecuite)</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table mb-0">
                                                <thead><tr><th>Material</th><th>Brix</th><th>Pol</th><th>Purity</th></tr></thead>
                                                <tbody>
                                                    <tr class="fw-bold text-dark">
                                                        <td>Primary Juice</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.pjBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.pjPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-light" ng-model="analysis.pjPurity" readonly></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Mixed Juice</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.mjBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.mjPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.mjPurity"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Clear Juice</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.cjBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.cjPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.cjPurity"></td>
                                                    </tr>
                                                    <tr class="table-warning bg-opacity-10">
                                                        <td>Final Molasses</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.fmBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.fmPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm" ng-model="analysis.fmPurity"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>