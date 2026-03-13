<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="dailyTonApp">
<head>
    <meta charset="UTF-8">
    <title>Daily Tonnage Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportDailyTon.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #e9ecef; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; }
        .action-btn:hover { background-color: #e2e6ea; }
        
        /* Report Specific Styling */
        .report-paper { background-color: white; padding: 40px; border: 1px solid #ccc; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); margin: 0 auto; max-width: 900px; }
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
<body ng-controller="DailyTonController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">DAILY TON DATA REPORT</div>
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
                        <h5 class="report-subtitle">Daily Cane Crushing (Tonnage) Report</h5>
                        
                        <div class="row mb-3" style="font-size: 0.95rem;">
                            <div class="col-4 fw-bold">Season: {{ report.seasonYear }}</div>
                            <div class="col-4 fw-bold text-center">Crop Day: {{ report.cropDay }}</div>
                            <div class="col-4 fw-bold text-end">Date: {{ displayDate }}</div>
                        </div>

                        <table class="table table-report table-sm">
                            <thead>
                                <tr>
                                    <th style="width: 25%;">Shift Details</th>
                                    <th style="width: 25%;">Cane Crushed (MT)</th>
                                    <th style="width: 25%;">Hours Worked</th>
                                    <th style="width: 25%;">Crushing Rate (MT/Hr)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center">Shift A (06:00 - 14:00)</td>
                                    <td class="text-end">{{ report.shiftACane | number:3 }}</td>
                                    <td class="text-end">{{ report.shiftAHours | number:2 }}</td>
                                    <td class="text-end">{{ report.rateA | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="text-center">Shift B (14:00 - 22:00)</td>
                                    <td class="text-end">{{ report.shiftBCane | number:3 }}</td>
                                    <td class="text-end">{{ report.shiftBHours | number:2 }}</td>
                                    <td class="text-end">{{ report.rateB | number:2 }}</td>
                                </tr>
                                <tr>
                                    <td class="text-center">Shift C (22:00 - 06:00)</td>
                                    <td class="text-end">{{ report.shiftCCane | number:3 }}</td>
                                    <td class="text-end">{{ report.shiftCHours | number:2 }}</td>
                                    <td class="text-end">{{ report.rateC | number:2 }}</td>
                                </tr>
                                <tr class="fw-bold bg-light">
                                    <td class="text-center">Total Today</td>
                                    <td class="text-end">{{ report.totalCaneToday | number:3 }}</td>
                                    <td class="text-end">{{ report.totalHoursToday | number:2 }}</td>
                                    <td class="text-end">{{ report.rateTotalToday | number:2 }}</td>
                                </tr>
                                <tr class="fw-bold text-primary">
                                    <td class="text-center">Total To-Date</td>
                                    <td class="text-end">{{ report.totalCaneTodate | number:3 }}</td>
                                    <td class="text-end">{{ report.totalHoursTodate | number:2 }}</td>
                                    <td class="text-end">{{ report.rateTotalTodate | number:2 }}</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm mt-4">
                            <thead>
                                <tr>
                                    <th style="width: 40%;">Source Category</th>
                                    <th style="width: 30%;">Today (MT)</th>
                                    <th style="width: 30%;">To-Date (MT)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="section-header" colspan="3">1. Member / Non-Member Status</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Member Cane</td>
                                    <td class="text-end">{{ report.memberCaneToday | number:3 }}</td>
                                    <td class="text-end">{{ report.memberCaneTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Non-Member / Outside Cane</td>
                                    <td class="text-end">{{ report.nonMemberCaneToday | number:3 }}</td>
                                    <td class="text-end">{{ report.nonMemberCaneTodate | number:3 }}</td>
                                </tr>
                                
                                <tr>
                                    <td class="section-header" colspan="3">2. Vehicle / Transport Type</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Bullock Cart</td>
                                    <td class="text-end">{{ report.bullockCartToday | number:3 }}</td>
                                    <td class="text-end">{{ report.bullockCartTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Tractor</td>
                                    <td class="text-end">{{ report.tractorToday | number:3 }}</td>
                                    <td class="text-end">{{ report.tractorTodate | number:3 }}</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">Truck</td>
                                    <td class="text-end">{{ report.truckToday | number:3 }}</td>
                                    <td class="text-end">{{ report.truckTodate | number:3 }}</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5">
                            <div class="col-4 text-center fw-bold mt-5">Cane Yard Supervisor</div>
                            <div class="col-4 text-center fw-bold mt-5">Chief Chemist</div>
                            <div class="col-4 text-center fw-bold mt-5">Managing Director</div>
                        </div>
                    </div>
                    
                    <div class="alert alert-info w-75 mx-auto text-center shadow-sm" ng-hide="isDataLoaded">
                        <strong>Info:</strong> Please select a date and click Generate to view the Tonnage report.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>