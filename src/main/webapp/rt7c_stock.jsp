<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="rt7cApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RT-7(C) Stock Entry | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/rt7cStock.js"></script>

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
            font-size: 0.88rem;
        }

        /* Unified App Window */
        .app-window { 
            background: #ffffff; 
            border-radius: 12px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-top: 25px;
            border: none;
        }

        .window-header { 
            background-color: #ffffff; 
            padding: 18px 25px; 
            font-weight: 700; 
            border-bottom: 1px solid var(--border-color); 
            color: var(--text-main);
            display: flex;
            align-items: center;
            letter-spacing: 0.5px;
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Industry Sidebar */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 750px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 12px; 
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

        /* Main Workspace */
        .main-panel { background-color: #ffffff; padding: 30px; }

        /* Modern Tabs */
        .nav-tabs { border-bottom: 2px solid var(--border-color); }
        .nav-tabs .nav-link { 
            border: none; 
            color: #64748b; 
            font-weight: 600; 
            padding: 12px 25px;
            transition: all 0.2s;
        }
        .nav-tabs .nav-link.active { 
            color: var(--primary-blue); 
            border-bottom: 3px solid var(--primary-blue); 
            background: transparent;
        }

        /* Spreadsheet-style Grid */
        .table-container { 
            background-color: white; 
            border: 1px solid var(--border-color); 
            border-radius: 8px;
            height: 450px; 
            overflow-y: auto; 
            margin-top: 15px;
        }

        .table thead th { 
            background-color: #f8fafc; 
            color: #64748b;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 0.5px;
            padding: 12px;
            position: sticky;
            top: 0;
            z-index: 10;
            border-bottom: 2px solid var(--border-color);
        }

        .input-grid { 
            width: 100%; 
            border: 1px solid transparent; 
            background-color: transparent; 
            outline: none; 
            padding: 6px 8px; 
            text-align: right;
            font-weight: 600;
            color: var(--primary-blue);
            border-radius: 4px;
            transition: all 0.2s;
        }

        .input-grid:focus { 
            background-color: #eff6ff; 
            border: 1px solid var(--primary-blue); 
        }

        .readonly-calc { 
            background-color: #f8fafc !important; 
            color: #dc2626 !important; /* Professional red for calculated Purity */
            cursor: not-allowed; 
        }

        .material-col { font-weight: 600; color: #334155; text-align: left !important; }

        /* Filter Strip */
        .filter-strip {
            background-color: #f8fafc;
            padding: 15px 25px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            margin-bottom: 20px;
        }
    </style>
</head>
<body ng-controller="RT7CController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Transaction</li>
                    <li class="breadcrumb-item active text-primary">RT-7(C) Stock Entry</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-journal-plus"></i> RT-7(C) MONTHLY STOCK VALUATION & DATA ENTRY
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()"><i class="bi bi-file-earmark-plus"></i> New Entry</button>
                    <button type="button" class="btn action-btn" ng-click="findData()"><i class="bi bi-search"></i> Find Record</button>
                    <button type="button" class="btn action-btn" ng-click="saveData('update')"><i class="bi bi-pencil-square"></i> Change</button>
                    <button type="button" class="btn action-btn" ng-click="saveData('save')"><i class="bi bi-cloud-arrow-up-fill"></i> Save Stock</button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()"><i class="bi bi-x-circle"></i> Cancel</button>
                    <button type="button" class="btn action-btn text-danger"><i class="bi bi-trash3"></i> Delete</button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-auto bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close App
                    </a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <form name="rt7Form" novalidate>
                        
                        <div class="filter-strip d-flex align-items-center">
                            <div class="me-4" style="width: 200px;">
                                <label class="small fw-bold text-muted mb-1 d-block">VALUATION DATE</label>
                                <input type="date" class="form-control form-control-sm" ng-model="stockDate" required>
                            </div>
                            <div style="width: 200px;">
                                <label class="small fw-bold text-muted mb-1 d-block">REPORTING MONTH</label>
                                <input type="month" class="form-control form-control-sm" ng-model="reportMonth" required>
                            </div>
                            <div class="ms-auto text-muted small fst-italic">
                                <i class="bi bi-info-circle me-1"></i> Data entered here will reflect in statutory monthly filings.
                            </div>
                        </div>

                        <ul class="nav nav-tabs" id="rt7cTabs" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#process" type="button">
                                    <i class="bi bi-gear-wide-connected me-2"></i>In-Process Stock
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#sugar" type="button">
                                    <i class="bi bi-box-seam me-2"></i>Sugar & Molasses
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#old-stock" type="button">
                                    <i class="bi bi-clock-history me-2"></i>Old Recoveries
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="rt7cTabsContent">
                            
                            <div class="tab-pane fade show active" id="process" role="tabpanel">
                                <div class="table-container shadow-sm">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 30%;">Material Name</th>
                                                <th class="text-end" style="width: 15%;">Volume (HL)</th>
                                                <th class="text-end" style="width: 15%;">Sp. Gravity</th>
                                                <th class="text-end" style="width: 13%;">Brix %</th>
                                                <th class="text-end" style="width: 13%;">Pol %</th>
                                                <th class="text-end" style="width: 14%;">Purity %</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in processList">
                                                <td class="material-col">
                                                    <input type="hidden" ng-model="item.materialId">
                                                    {{item.materialName}}
                                                </td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.volume"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.spGravity"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.brixPercent" ng-change="calculatePurity(item)"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.polPercent" ng-change="calculatePurity(item)"></td>
                                                <td><input type="number" step="0.01" class="input-grid readonly-calc" ng-model="item.purityPercent" readonly></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="sugar" role="tabpanel">
                                <div class="table-container shadow-sm">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 30%;">Product / Grade</th>
                                                <th class="text-end" style="width: 15%;">Qty (Qtls)</th>
                                                <th class="text-end" style="width: 15%;">Sp. Gravity</th>
                                                <th class="text-end" style="width: 13%;">Brix %</th>
                                                <th class="text-end" style="width: 13%;">Pol %</th>
                                                <th class="text-end" style="width: 14%;">Purity %</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in sugarList">
                                                <td class="material-col">{{item.materialName}}</td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.quantity"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.spGravity" ng-readonly="!item.materialName.includes('Molasses')"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.brixPercent" ng-change="calculatePurity(item)"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.polPercent" ng-change="calculatePurity(item)"></td>
                                                <td><input type="number" step="0.01" class="input-grid readonly-calc" ng-model="item.purityPercent" readonly></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="old-stock" role="tabpanel">
                                <div class="alert alert-warning py-3 mt-3 border-0 rounded-3 shadow-sm d-flex align-items-center" style="background: #fffbeb; color: #92400e;">
                                    <i class="bi bi-exclamation-triangle-fill fs-4 me-3"></i>
                                    <span><strong>Processing Note:</strong> Provide data for stocks recovered from previous crushing seasons. "Total Sugar" is derived automatically based on Pol content.</span>
                                </div>
                                <div class="table-container shadow-sm" style="height: 380px;">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 40%;">Source Description</th>
                                                <th class="text-end" style="width: 20%;">Qty Reprocessed</th>
                                                <th class="text-end" style="width: 20%;">Pol %</th>
                                                <th class="text-end" style="width: 20%;">Sugar Content (Calc)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in oldStockList">
                                                <td class="material-col">{{item.materialName}}</td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.quantity" ng-change="calculateOldSugar(item)"></td>
                                                <td><input type="number" step="0.01" class="input-grid" ng-model="item.polPercent" ng-change="calculateOldSugar(item)"></td>
                                                <td><input type="number" step="0.01" class="input-grid readonly-calc" style="color: #2563eb !important;" ng-model="item.volume" readonly></td>
                                            </tr>
                                        </tbody>
                                    </table>
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