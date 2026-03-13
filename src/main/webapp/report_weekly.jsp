<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="weeklyReportApp">
<head>
    <meta charset="UTF-8">
    <title>Weekly Manufacturing Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportWeekly.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #e9ecef; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; }
        .action-btn:hover { background-color: #e2e6ea; }
        
        .report-paper { background-color: white; padding: 40px; border: 1px solid #ccc; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); margin: 0 auto; max-width: 950px; }
        .report-title { text-align: center; font-weight: bold; color: #000; margin-bottom: 5px; font-size: 1.4rem; }
        .report-subtitle { text-align: center; font-weight: bold; font-size: 1.1rem; margin-bottom: 25px; text-decoration: underline; }
        .table-report { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .table-report th { background-color: #f8f9fa !important; border: 1px solid #000; text-align: center; vertical-align: middle; padding: 8px; font-size: 0.95rem; }
        .table-report td { border: 1px solid #000; padding: 6px 10px; font-size: 0.95rem; }
        .section-header { background-color: #e9ecef !important; font-weight: bold; text-align: left !important; }
        
        @media print {
            body * { visibility: hidden; }
            #printableArea, #printableArea * { visibility: visible; }
            #printableArea { position: absolute; left: 0; top: 0; width: 100%; box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body ng-controller="WeeklyReportController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">WEEKLY MANUFACTURING REPORT</div>
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
                            <label class="col-auto fw-bold text-dark">Week No:</label>
                            <div class="col-auto">
                                <input type="number" class="form-control form-control-sm border-secondary" ng-model="weekNo" style="width: 80px;" required>
                            </div>
                            <label class="col-auto fw-bold text-dark ms-3">From Date:</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm border-secondary" ng-model="fromDate" required>
                            </div>
                            <label class="col-auto fw-bold text-dark ms-2">To Date:</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm border-secondary" ng-model="toDate" required>
                            </div>
                            <div class="col-auto ms-3">
                                <button type="button" class="btn btn-sm btn-dark px-4 fw-bold" ng-click="generateReport()">Generate</button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper" ng-show="isDataLoaded">
                        <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                        <h5 class="report-subtitle">Weekly Manufacturing & Performance Report</h5>
                        
                        <div class="row mb-3">
                            <div class="col-4 fw-bold">Season: {{ report.seasonYear }}</div>
                            <div class="col-4 fw-bold text-center">Week No: {{ report.weekNo }}</div>
                            <div class="col-4 fw-bold text-end">Period: {{ displayFromDate }} to {{ displayToDate }}</div>
                        </div>

                        <table class="table table-report table-sm">
                            <thead>
                                <tr>
                                    <th style="width: 40%;">Particulars</th>
                                    <th style="width: 30%;">This Week</th>
                                    <th style="width: 30%;">To-Date (Season)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="section-header" colspan="3">1. Cane Crushing & Sugar Production</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Total Cane Crushed (MT)</td>
                                    <td class="text-end">{{ report.caneCrushedWeek | number:3 }}</td>
                                    <td class="text-end">{{ report.caneCrushedTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Sugar Bagged (Qtls)</td>
                                    <td class="text-end">{{ report.sugarBaggedWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.sugarBaggedTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Sugar in Process (Qtls)</td>
                                    <td class="text-end">{{ report.sugarInProcessWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.sugarInProcessTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold" style="padding-left: 20px;">Total Sugar Made (Qtls)</td>
                                    <td class="text-end fw-bold">{{ report.totalSugarMadeWeek | number:2 }}</td>
                                    <td class="text-end fw-bold">{{ report.totalSugarMadeTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold text-primary" style="padding-left: 20px;">Recovery % Cane</td>
                                    <td class="text-end fw-bold text-primary">{{ report.recoveryWeek | number:2 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ report.recoveryTodate | number:2 }}</td>
                                </tr>

                                <tr>
                                    <td class="section-header" colspan="3">2. Time Account & Crushing Rate</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Total Available Hours</td>
                                    <td class="text-end">{{ report.availableHrsWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.availableHrsTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Hours Lost (Mech/Elec/Process)</td>
                                    <td class="text-end">{{ report.lostHrsWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.lostHrsTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Actual Crushing Hours</td>
                                    <td class="text-end">{{ report.crushingHrsWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.crushingHrsTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Crushing Rate per 24 Hrs (MT)</td>
                                    <td class="text-end">{{ report.crushRateWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.crushRateTodate | number:2 }}</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm mt-4">
                            <thead>
                                <tr>
                                    <th style="width: 40%;">Technical Parameters</th>
                                    <th style="width: 30%;">This Week (%)</th>
                                    <th style="width: 30%;">To-Date (%)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="section-header" colspan="3">3. Efficiency & Losses</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Mill Extraction</td>
                                    <td class="text-end">{{ report.millExtWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.millExtTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Reduced Mill Extraction</td>
                                    <td class="text-end">{{ report.redMillExtWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.redMillExtTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Boiling House Extraction</td>
                                    <td class="text-end">{{ report.boilingHouseExtWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.boilingHouseExtTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold" style="padding-left: 20px;">Overall Extraction</td>
                                    <td class="text-end fw-bold">{{ report.overallExtWeek | number:2 }}</td>
                                    <td class="text-end fw-bold">{{ report.overallExtTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Total Sugar Losses % Cane</td>
                                    <td class="text-end">{{ report.sugarLossesWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.sugarLossesTodate | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Bagasse % Cane</td>
                                    <td class="text-end">{{ report.bagassePctWeek | number:2 }}</td>
                                    <td class="text-end">{{ report.bagassePctTodate | number:2 }}</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5">
                            <div class="col-4 text-center fw-bold mt-5">Chief Chemist</div>
                            <div class="col-4 text-center fw-bold mt-5">Works Manager</div>
                            <div class="col-4 text-center fw-bold mt-5">Managing Director</div>
                        </div>
                    </div>
                    
                    <div class="alert alert-info w-75 mx-auto text-center shadow-sm" ng-hide="isDataLoaded">
                        <strong>Info:</strong> Please enter the Week Number and Date Range, then click Generate to view the report.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>