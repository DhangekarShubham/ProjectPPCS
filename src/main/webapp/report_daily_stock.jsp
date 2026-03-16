<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="stockReportApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Ledger Report | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportDailyStock.js"></script>

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

        /* Modern Sidebar */
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

        /* Report Paper Styling */
        .report-paper { 
            background-color: white; 
            padding: 50px; 
            border: 1px solid #d1d5db; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            margin: 0 auto; 
            max-width: 950px; 
            color: #000;
        }

        .report-title { 
            text-align: center; 
            font-weight: 800; 
            font-size: 1.5rem; 
            margin-bottom: 5px; 
            text-transform: uppercase;
        }

        .report-subtitle { 
            text-align: center; 
            font-weight: 700; 
            font-size: 1.1rem; 
            margin-bottom: 30px;
            text-decoration: underline;
            text-underline-offset: 5px;
        }

        /* Industry Standard Ledger Table */
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
            padding: 8px 15px !important;
        }
        
        .product-name { font-family: 'Inter', sans-serif !important; font-weight: 600; color: #1f2937; }

        /* Signature Lines */
        .sig-container { margin-top: 80px; }
        .sig-box { border-top: 1.5px solid #000; width: 85%; margin: 0 auto; padding-top: 5px; font-size: 0.8rem; font-weight: 700; }

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
<body ng-controller="StockReportController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Inventory Reports</li>
                    <li class="breadcrumb-item active text-primary">Daily Stock Ledger</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-journal-check"></i> DAILY STOCK LEDGER REPORT GENERATION
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-white" ng-click="printReport()">
                        <i class="bi bi-printer-fill text-info"></i> Print Ledger
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
                    
                    <form name="searchForm" class="mb-5 bg-white p-4 border rounded shadow-sm w-75 mx-auto" novalidate>
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-muted text-uppercase small">Select Valuation Date:</label>
                            <div class="col-auto">
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white border-secondary"><i class="bi bi-calendar-event"></i></span>
                                    <input type="date" class="form-control border-secondary" ng-model="selectedDate" required>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm" ng-click="generateReport()">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE LEDGER
                                </button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper shadow" ng-show="isDataLoaded">
                        <div class="text-center border-bottom border-3 border-dark mb-4 pb-2">
                            <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                            <h5 class="report-subtitle">Daily Product & By-Product Stock Ledger</h5>
                        </div>
                        
                        <div class="row mb-3" style="font-size: 0.9rem; font-weight: bold;">
                            <div class="col-4">CRUSHING SEASON: {{ sugarList[0].seasonYear }}</div>
                            <div class="col-4 text-center">UNIT: 01 (COMBINE)</div>
                            <div class="col-4 text-end">LEDGER DATE: {{ displayDate }}</div>
                        </div>

                        <table class="table-report mb-0">
                            <thead>
                                <tr>
                                    <th style="width: 5%;">SR.</th>
                                    <th style="width: 25%; text-align: left;">PARTICULARS</th>
                                    <th style="width: 8%;">UNIT</th>
                                    <th style="width: 15%;">OPENING</th>
                                    <th style="width: 15%;">PRODUCTION</th>
                                    <th style="width: 15%;">DISPATCH</th>
                                    <th style="width: 17%;">CLOSING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="section-header" colspan="7">1.0 FINAL SUGAR STOCKS (FINISHED GOODS)</td>
                                </tr>
                                <tr ng-repeat="sugar in sugarList">
                                    <td class="text-center">{{ sugar.rowNumber }}</td>
                                    <td class="product-name">{{ sugar.productName }}</td>
                                    <td class="text-center">{{ sugar.unit }}</td>
                                    <td class="text-end">{{ sugar.openingBalance | number:2 }}</td>
                                    <td class="text-end">{{ sugar.productionToday | number:2 }}</td>
                                    <td class="text-end">{{ sugar.dispatchSale | number:2 }}</td>
                                    <td class="text-end fw-bold">{{ sugar.closingBalance | number:2 }}</td>
                                </tr>
                                <tr class="bg-light">
                                    <td colspan="2" class="text-end fw-bold">CONSOLIDATED SUGAR TOTAL:</td>
                                    <td class="text-center fw-bold">QTLS</td>
                                    <td class="text-end fw-bold">{{ totals.opening | number:2 }}</td>
                                    <td class="text-end fw-bold">{{ totals.prod | number:2 }}</td>
                                    <td class="text-end fw-bold">{{ totals.dispatch | number:2 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ totals.closing | number:2 }}</td>
                                </tr>

                                <tr>
                                    <td class="section-header" colspan="7">2.0 BY-PRODUCTS & RESIDUAL STOCKS</td>
                                </tr>
                                <tr ng-repeat="byprod in byProductList">
                                    <td class="text-center">{{ byprod.rowNumber }}</td>
                                    <td class="product-name">{{ byprod.productName }}</td>
                                    <td class="text-center">{{ byprod.unit }}</td>
                                    <td class="text-end">{{ byprod.openingBalance | number:3 }}</td>
                                    <td class="text-end">{{ byprod.productionToday | number:3 }}</td>
                                    <td class="text-end">{{ byprod.dispatchSale | number:3 }}</td>
                                    <td class="text-end fw-bold">{{ byprod.closingBalance | number:3 }}</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row sig-container text-center">
                            <div class="col-3">
                                <div class="sig-box">STORE KEEPER</div>
                            </div>
                            <div class="col-3">
                                <div class="sig-box">CHIEF CHEMIST</div>
                            </div>
                            <div class="col-3">
                                <div class="sig-box">CHIEF ACCOUNTANT</div>
                            </div>
                            <div class="col-3">
                                <div class="sig-box">MANAGING DIRECTOR</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert-custom w-75 mx-auto text-center border-0 shadow-sm" ng-hide="isDataLoaded" style="background: #eef2ff; color: #4338ca;">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        <strong>System Notice:</strong> Please select a valuation date and click Generate to retrieve the official stock ledger.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>