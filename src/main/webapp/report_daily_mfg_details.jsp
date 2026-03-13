<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="mfgReportApp">
<head>
    <meta charset="UTF-8">
    <title>Daily Manufacturing Details Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportMfgDetails.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #e9ecef; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; }
        .action-btn:hover { background-color: #e2e6ea; }
        
        /* Report Specific Styling */
        .report-paper { background-color: white; padding: 30px; border: 1px solid #ccc; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); margin: 0 auto; max-width: 900px; }
        .report-title { text-align: center; font-weight: bold; color: #000; margin-bottom: 5px; }
        .report-subtitle { text-align: center; font-weight: bold; font-size: 1.1rem; margin-bottom: 20px; }
        .table-report th { background-color: #f8f9fa !important; border: 1px solid #000; text-align: center; vertical-align: middle; padding: 5px; font-size: 0.9rem; }
        .table-report td { border: 1px solid #000; padding: 4px 8px; font-size: 0.9rem; }
        
        /* Ensures only the report is visible when printing */
        @media print {
            body * { visibility: hidden; }
            #printableArea, #printableArea * { visibility: visible; }
            #printableArea { position: absolute; left: 0; top: 0; width: 100%; box-shadow: none; border: none; }
        }
    </style>
</head>
<body ng-controller="MfgReportController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">DAILY MANUFACTURING (DETAILS) REPORT</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-primary" ng-click="printReport()">Print Report</button>
                    <button type="button" class="btn action-btn text-danger">Export to PDF</button>
                    <button type="button" class="btn action-btn text-success">Export to Excel</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <form name="searchForm" class="mb-4 bg-white p-3 border rounded shadow-sm w-75 mx-auto" novalidate>
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-dark">Select Date:</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm border-secondary" ng-model="selectedDate" required>
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-sm btn-dark px-4 fw-bold" ng-click="generateReport()">Generate</button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper" ng-show="isDataLoaded">
                        <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                        <h5 class="report-subtitle">Daily Manufacturing Details<br><span class="text-muted" style="font-size: 1rem;">Combine Report</span></h5>
                        
                        <div class="row mb-3">
                            <div class="col-6 fw-bold">Season: 2025-2026</div>
                            <div class="col-6 fw-bold text-end">Crush Date: {{ displayDate }}</div>
                        </div>

                        <table class="table table-report table-sm mb-0">
                            <thead>
                                <tr>
                                    <th style="width: 8%;">Sr No</th>
                                    <th style="width: 35%;">Particulars</th>
                                    <th style="width: 15%;">Brix</th>
                                    <th style="width: 15%;">Pol %</th>
                                    <th style="width: 15%;">Purity</th>
                                    <th style="width: 12%;">Remark</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="row in reportDataList">
                                    <td class="text-center">{{ row.srNo }}</td>
                                    <td class="fw-bold text-secondary">{{ row.particulars }}</td>
                                    <td class="text-end">{{ row.brix | number:2 }}</td>
                                    <td class="text-end">{{ row.pol | number:2 }}</td>
                                    <td class="text-end">{{ row.purity | number:2 }}</td>
                                    <td>{{ row.remark }}</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5">
                            <div class="col-4 text-center fw-bold mt-4">Lab Incharge</div>
                            <div class="col-4 text-center fw-bold mt-4">Chief Chemist</div>
                            <div class="col-4 text-center fw-bold mt-4">Managing Director</div>
                        </div>
                    </div>
                    
                    <div class="alert alert-info w-75 mx-auto text-center shadow-sm" ng-hide="isDataLoaded">
                        <strong>Info:</strong> Please select a date and click Generate to view the report.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>