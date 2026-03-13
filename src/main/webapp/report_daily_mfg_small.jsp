<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="mr" ng-app="mfgSmallApp">
<head>
    <meta charset="UTF-8">
    <title>Daily Manufacturing Small (Marathi) Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportMfgSmall.js"></script>

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
        .report-title { text-align: center; font-weight: bold; color: #000; margin-bottom: 5px; font-size: 1.3rem; }
        .report-subtitle { text-align: center; font-weight: bold; font-size: 1.1rem; margin-bottom: 10px; }
        .table-report { margin-bottom: 15px; width: 100%; }
        .table-report th { background-color: #f8f9fa !important; border: 1px solid #000; text-align: center; vertical-align: middle; padding: 4px; font-size: 0.85rem; }
        .table-report td { border: 1px solid #000; padding: 3px 6px; font-size: 0.85rem; }
        .marathi-text { font-family: 'Mangal', 'Arial Unicode MS', sans-serif; }
        
        @media print {
            body * { visibility: hidden; }
            #printableArea, #printableArea * { visibility: visible; }
            #printableArea { position: absolute; left: 0; top: 0; width: 100%; box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body ng-controller="MfgSmallController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">DAILY MANUFACTURING SMALL (MARATHI) REPORT</div>
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
                        <h3 class="report-title">श्री. छत्रपती सहकारी साखर कारखाना लि., भवानीनगर, ता. इंदापूर जि.पुणे.</h3>
                        <h5 class="report-subtitle">डेली क्रशींग रिपोर्ट<br><span style="font-size: 1rem; font-weight: normal;">(Unit No.-1)</span></h5>
                        
                        <div class="row mb-2" style="font-size: 0.9rem; font-weight: bold;">
                            <div class="col-4">क्रॉपडे : {{ reportData.cropDay }}</div>
                            <div class="col-4 text-center">हंगाम २०२५-२०२६</div>
                            <div class="col-4 text-end">दिनांक : {{ displayDate }}</div>
                        </div>

                        <table class="table table-report table-sm mb-3">
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
                                    <td class="text-center">१.</td>
                                    <td>ऊस (मे. टन)<br>सभासद<br>बि. सभासद<br>इतर<br><b>एकूण</b></td>
                                    <td class="text-end"><br>{{ reportData.caneMemberToday | number:3 }}<br>{{ reportData.caneNonMemberToday | number:3 }}<br>{{ reportData.caneOtherToday | number:3 }}<br><b>{{ reportData.caneTotalToday | number:3 }}</b></td>
                                    <td class="text-end"><br>{{ reportData.caneMemberTodate | number:3 }}<br>{{ reportData.caneNonMemberTodate | number:3 }}<br>{{ reportData.caneOtherTodate | number:3 }}<br><b>{{ reportData.caneTotalTodate | number:3 }}</b></td>
                                    <td></td>
                                    <td class="text-end"><br>-<br>-<br>-<br>-</td>
                                    <td class="text-end"><br>-<br>-<br>-<br>-</td>
                                </tr>
                                <tr>
                                    <td class="text-center">२.</td>
                                    <td>साखर पोती (क्विंटल)<br>एल-३०<br>एम-३०<br>एस १-३०<br>रॉ-शुगर<br><b>एकूण</b></td>
                                    <td class="text-end"><br>{{ reportData.sugarL30Today | number:2 }}<br>{{ reportData.sugarM30Today | number:2 }}<br>{{ reportData.sugarS130Today | number:2 }}<br>{{ reportData.sugarRawToday | number:2 }}<br><b>{{ reportData.sugarTotalToday | number:2 }}</b></td>
                                    <td class="text-end"><br>{{ reportData.sugarL30Todate | number:2 }}<br>{{ reportData.sugarM30Todate | number:2 }}<br>{{ reportData.sugarS130Todate | number:2 }}<br>{{ reportData.sugarRawTodate | number:2 }}<br><b>{{ reportData.sugarTotalTodate | number:2 }}</b></td>
                                    <td></td>
                                    <td class="text-end"><br>-<br>-<br>-<br>-<br>-</td>
                                    <td class="text-end"><br>-<br>-<br>-<br>-<br>-</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm mb-3">
                            <tbody>
                                <tr>
                                    <td style="width: 5%; text-center">१०.</td>
                                    <td style="width: 35%;">बगॅस % ऊस</td>
                                    <td style="width: 20%; text-end">{{ reportData.bagassePctCaneToday | number:2 }}</td>
                                    <td style="width: 20%; text-end">{{ reportData.bagassePctCaneTodate | number:2 }}</td>
                                    <td style="width: 20%;"></td>
                                </tr>
                                <tr>
                                    <td class="text-center">११.</td>
                                    <td>फायबर % ऊस</td>
                                    <td class="text-end">{{ reportData.fiberPctCaneToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.fiberPctCaneTodate | number:2 }}</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="text-center">१४.</td>
                                    <td>टोटल लॉसेस</td>
                                    <td class="text-end">{{ reportData.totalLossesToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.totalLossesTodate | number:2 }}</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="text-center">१५.</td>
                                    <td>मिल एक्स्ट्रॅक्शन</td>
                                    <td class="text-end">{{ reportData.millExtractionToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.millExtractionTodate | number:2 }}</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="text-center">१६.</td>
                                    <td>रिड्यूस्ड मिल एक्स्ट्रॅक्शन</td>
                                    <td class="text-end">{{ reportData.reducedMillExtractionToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.reducedMillExtractionTodate | number:2 }}</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="text-center">१७.</td>
                                    <td>क्रशिंग रेट (ब. बंद वेळ सोडून)</td>
                                    <td class="text-end">{{ reportData.crushingRateExclStopsToday | number:3 }}</td>
                                    <td class="text-end">{{ reportData.crushingRateExclStopsTodate | number:3 }}</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="text-center">१८.</td>
                                    <td>मिल चालू तास</td>
                                    <td class="text-end">{{ reportData.millRunningHrsToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.millRunningHrsTodate | number:2 }}</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="text-center">१९.</td>
                                    <td>मिल बंद तास (वाया गेलेले तास)</td>
                                    <td class="text-end">{{ reportData.millStopHrsToday | number:2 }}</td>
                                    <td class="text-end">{{ reportData.millStopHrsTodate | number:2 }}</td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5">
                            <div class="col-4 text-center fw-bold mt-4">लॅब इंचार्ज</div>
                            <div class="col-4 text-center fw-bold mt-4">चीफ केमिस्ट</div>
                            <div class="col-4 text-center fw-bold mt-4">मॅनेजिंग डायरेक्टर</div>
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