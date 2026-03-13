<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="mr" ng-app="mfgShortApp">
<head>
    <meta charset="UTF-8">
    <title>Daily Manufacturing Short (Marathi) Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportMfgShort.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #e9ecef; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; }
        .action-btn:hover { background-color: #e2e6ea; }
        
        /* Report Specific Styling */
        .report-paper { background-color: white; padding: 30px; border: 1px solid #ccc; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); margin: 0 auto; max-width: 950px; }
        .report-title { text-align: center; font-weight: bold; color: #000; margin-bottom: 5px; font-size: 1.2rem; }
        .report-subtitle { text-align: center; font-weight: bold; font-size: 1.1rem; margin-bottom: 15px; }
        .table-report { margin-bottom: 15px; width: 100%; border-collapse: collapse; }
        .table-report th { background-color: #f8f9fa !important; border: 1px solid #000; text-align: center; vertical-align: middle; padding: 6px; font-size: 0.9rem; }
        .table-report td { border: 1px solid #000; padding: 4px 8px; font-size: 0.9rem; }
        .marathi-text { font-family: 'Mangal', 'Arial Unicode MS', sans-serif; }
        
        @media print {
            body * { visibility: hidden; }
            #printableArea, #printableArea * { visibility: visible; }
            #printableArea { position: absolute; left: 0; top: 0; width: 100%; box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body ng-controller="MfgShortController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">DAILY MANUFACTURING SHORT (MARATHI) REPORT</div>
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

                    <div id="printableArea" class="report-paper marathi-text" ng-show="isDataLoaded">
                        <h3 class="report-title">श्री. छत्रपती सहकारी साखर कारखाना लि., भवानीनगर, ता. इंदापूर जि. पुणे.</h3>
                        <h5 class="report-subtitle">डेली क्रशींग रिपोर्ट<br><span style="font-size: 1rem; font-weight: normal;">एकत्रीत रिपोर्ट</span></h5>
                        
                        <div class="row mb-3" style="font-size: 0.95rem; font-weight: bold;">
                            <div class="col-4">क्रॉपडे : {{ reportData.cropDay }}</div>
                            <div class="col-4 text-center">हंगाम २०२५-२०२६</div>
                            <div class="col-4 text-end">दिनांक : {{ displayDate }}</div>
                        </div>

                        <table class="table table-report table-sm mb-4">
                            <thead>
                                <tr>
                                    <th rowspan="2" style="width: 5%;">अ. न.</th>
                                    <th rowspan="2" style="width: 25%;">तपशील</th>
                                    <th rowspan="2" style="width: 15%;">आज</th>
                                    <th colspan="2" style="width: 30%;">हंगाम २०२५-२०२६</th>
                                    <th colspan="2" style="width: 25%;">मागील हंगाम २०२४-२०२५</th>
                                </tr>
                                <tr>
                                    <th>आजपर्यंत</th>
                                    <th>%</th>
                                    <th>आज</th>
                                    <th>आजपर्यंत</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center" rowspan="5" style="vertical-align: top;">१.</td>
                                    <td class="fw-bold">ऊस गळीत (मे. टन)</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">सभासद</td>
                                    <td class="text-end">{{ reportData.caneMemberToday | number:3 }}</td>
                                    <td class="text-end">{{ reportData.caneMemberTodate | number:3 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">बि. सभासद</td>
                                    <td class="text-end">{{ reportData.caneNonMemberToday | number:3 }}</td>
                                    <td class="text-end">{{ reportData.caneNonMemberTodate | number:3 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">इतर</td>
                                    <td class="text-end">{{ reportData.caneOtherToday | number:3 }}</td>
                                    <td class="text-end">{{ reportData.caneOtherTodate | number:3 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold" style="padding-left: 20px;">एकूण</td>
                                    <td class="text-end fw-bold">{{ reportData.caneTotalToday | number:3 }}</td>
                                    <td class="text-end fw-bold">{{ reportData.caneTotalTodate | number:3 }}</td>
                                    <td></td>
                                    <td class="text-end fw-bold">-</td>
                                    <td class="text-end fw-bold">-</td>
                                </tr>

                                <tr>
                                    <td class="text-center" rowspan="7" style="vertical-align: top;">२.</td>
                                    <td class="fw-bold">साखर पोती (क्विंटल)</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">एल-३०</td>
                                    <td class="text-end">{{ reportData.sugarL30Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarL30Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">एम-३०</td>
                                    <td class="text-end">{{ reportData.sugarM30Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarM30Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">एस १-३०</td>
                                    <td class="text-end">{{ reportData.sugarS130Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarS130Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">एस २-३०</td>
                                    <td class="text-end">{{ reportData.sugarS230Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarS230Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">ब्राउन शुगर</td>
                                    <td class="text-end">{{ reportData.sugarBrownToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarBrownTodate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold" style="padding-left: 20px;">एकूण</td>
                                    <td class="text-end fw-bold">{{ reportData.sugarTotalToday | number:2 }}</td>
                                    <td class="text-end fw-bold">{{ reportData.sugarTotalTodate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end fw-bold">-</td>
                                    <td class="text-end fw-bold">-</td>
                                </tr>

                                <tr>
                                    <td class="text-center" rowspan="3" style="vertical-align: top;">३.</td>
                                    <td style="padding-left: 20px;">एल-३० %</td>
                                    <td class="text-end">{{ reportData.pctL30Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.pctL30Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">एम-३० %</td>
                                    <td class="text-end">{{ reportData.pctM30Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.pctM30Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 20px;">एस १-३० %</td>
                                    <td class="text-end">{{ reportData.pctS130Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.pctS130Todate | number:2 }}</td>
                                    <td></td>
                                    <td class="text-end">-</td>
                                    <td class="text-end">-</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5">
                            <div class="col-4 text-center fw-bold mt-5">लॅब इंचार्ज</div>
                            <div class="col-4 text-center fw-bold mt-5">चीफ केमिस्ट</div>
                            <div class="col-4 text-center fw-bold mt-5">मॅनेजिंग डायरेक्टर</div>
                        </div>
                    </div>

                    <div class="alert alert-info w-75 mx-auto text-center shadow-sm" ng-hide="isDataLoaded">
                        <strong>Info:</strong> Please select a date and click Generate to view the Marathi report.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>