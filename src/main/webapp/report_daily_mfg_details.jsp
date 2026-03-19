<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="mfgReportApp">
<head>
    <meta charset="UTF-8">
    <title>Daily Manufacturing Details Report</title>
    
<style>
        /* --- PRINT CSS OVERRIDES --- */
        @media print {
            /* 1. Completely hide the search bar, navbars, and alerts */
            .no-print, .alert, nav, header, footer { 
                display: none !important; 
            }
            
            /* 2. Reset the page background to pure white */
            body, html {
                background-color: #ffffff !important;
                margin: 0 !important;
                padding: 0 !important;
            }

            /* 3. Make the report flow naturally (fixes the blank page bug) */
            #printableArea { 
                position: relative !important;
                left: 0 !important;
                top: 0 !important;
                width: 100% !important; 
                box-shadow: none !important; 
                border: none !important; 
                margin: 0 !important; 
                padding: 0 !important;
                display: block !important;
            }
            
            /* 4. Force browsers to print the black table borders and grey headers */
            .pdf-table { width: 100% !important; border-collapse: collapse !important; }
            .pdf-table th, .pdf-table td { border: 1px solid #000 !important; color: #000 !important; }
            .pdf-table th { 
                background-color: #f1f5f9 !important; 
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important; 
            }
        }
        
        /* --- SCREEN CSS --- */
        .report-header-title { font-size: 22px; font-weight: 800; text-align: center; color: #000; letter-spacing: 0.5px; }
        .report-header-subtitle { font-size: 16px; font-weight: bold; text-align: center; margin-bottom: 25px; color: #333; text-decoration: underline; }
        .report-meta-info { display: flex; justify-content: space-between; font-weight: bold; margin-bottom: 10px; font-size: 14px; color: #000; }
        
        .pdf-table { width: 100%; border-collapse: collapse; margin-bottom: 25px; }
        .pdf-table th, .pdf-table td { border: 1px solid #000; padding: 6px 10px; font-size: 13px; color: #000; }
        .pdf-table th { background-color: #f1f5f9; font-weight: bold; }
        .val-col { text-align: right; font-family: monospace; font-size: 14px; }
    </style>
</head>
<body>

    <div class="contentpanel" ng-controller="MfgReportController">
        
        <link href="css/forms.css" rel="stylesheet">
        
        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded no-print">
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                <i class="fa fa-file-text-o me-2"></i> Daily Manufacturing (Details) Report
            </div>
            
            <div class="row align-items-center bg-light p-3 mx-0 border-bottom">
                
                <div class="col-md-4 d-flex align-items-center">
                    <label class="text-muted small fw-bold text-uppercase me-2 mb-0" style="white-space: nowrap;">Report Date:</label>
                    <div class="input-group input-group-sm shadow-sm">
                        <input type="text" class="form-control border-primary text-center fw-bold text-primary" 
                               placeholder="DD/MM/YYYY" ng-model="manualDateText" ng-change="syncFromText()" 
                               title="Type date as DD/MM/YYYY" maxlength="10">
                        <input type="date" class="form-control border-primary px-1" 
                               ng-model="searchDate" ng-change="syncFromPicker()" 
                               style="max-width: 40px; cursor: pointer;" title="Select from Calendar">
                    </div>
                </div>

                <div class="col-md-5">
                    <button type="button" class="btn btn-sm btn-primary fw-bold px-4 me-2 shadow-sm" ng-click="generateReport()" style="background-color: #6593b4; border: none;">
                        <i class="fa fa-cogs me-1"></i> Generate
                    </button>
                    <button type="button" class="btn btn-sm btn-warning fw-bold px-4 text-white shadow-sm" ng-click="printReport()" style="background-color: #e5a751; border: none;" ng-disabled="!isDataLoaded">
                        <i class="fa fa-print me-1"></i> Print / PDF
                    </button>
                    <button type="button" class="btn btn-sm btn-light fw-bold px-4 border shadow-sm" ng-click="clearReport()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
                </div>
            </div>
        </div>

        <div class="erp-form-container mx-2 mt-4 p-5 bg-white shadow border rounded" id="printableArea" ng-show="isDataLoaded">
            
            <div class="report-header-title">Shri.Chhatrapati S.S.K.Ltd, Bhavaninagar.</div>
            <div class="report-header-subtitle">Combine Report</div>
            
            <div class="report-meta-info">
                <div>Season {{ reportData.seasonYear || '2025-2026' }}</div>
                <div>Crush Date: {{ displayDate }}</div>
            </div>

            <table class="pdf-table">
                <thead>
                    <tr>
                        <th style="width: 6%; text-align: center;">Sr<br>No</th>
                        <th style="width: 34%;">Particulars</th>
                        <th style="width: 15%; text-align: center;">Brix</th>
                        <th style="width: 15%; text-align: center;">Pol%</th>
                        <th style="width: 15%; text-align: center;">Purity</th>
                        <th style="width: 15%; text-align: center;">Remark</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="item in mainList">
                        <td style="text-align: center;">{{ $index + 1 }}</td>
                        <td style="font-weight: bold;">{{ item.particulars }}</td>
                        <td class="val-col">{{ item.brix | number:2 }}</td>
                        <td class="val-col">{{ item.pol | number:2 }}</td>
                        <td class="val-col">{{ item.purity | number:2 }}</td>
                        <td>{{ item.remark }}</td>
                    </tr>
                </tbody>
            </table>

            <table class="pdf-table" style="width: 60%;">
                <thead>
                    <tr>
                        <th style="width: 10%; text-align: center;">Sr<br>No</th>
                        <th style="width: 40%;">Particulars</th>
                        <th style="width: 25%; text-align: center;">Moisture %</th>
                        <th style="width: 25%; text-align: center;">Pol%</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="item in byproductList">
                        <td style="text-align: center;">{{ $index + 1 }}</td>
                        <td style="font-weight: bold;">{{ item.particulars }}</td>
                        <td class="val-col">{{ item.moisture | number:2 }}</td>
                        <td class="val-col">{{ item.pol | number:2 }}</td>
                    </tr>
                </tbody>
            </table>

            <table class="pdf-table">
                <tbody>
                    <tr>
                        <td style="width: 4%; text-align: center;">1</td>
                        <td style="width: 31%; font-weight: bold;">No. of Juice Tank</td>
                        <td style="width: 15%;" class="val-col">{{ params.juiceTanks }}</td>
                        
                        <td style="width: 4%; text-align: center;">5</td>
                        <td style="width: 31%; font-weight: bold;">No. of Added Water Tank</td>
                        <td style="width: 15%;" class="val-col">{{ params.addedWaterTanks }}</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">2</td>
                        <td style="font-weight: bold;">Filter Cake (M.T.)</td>
                        <td class="val-col">{{ params.filterCakeMt }}</td>
                        
                        <td style="text-align: center;">6</td>
                        <td style="font-weight: bold;">No. of F.M. Tank</td>
                        <td class="val-col">{{ params.fmTanks }}</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">3</td>
                        <td style="font-weight: bold;">Condenser Water Inlet Temp.</td>
                        <td class="val-col">{{ params.inletTemp }}</td>
                        
                        <td style="text-align: center;">7</td>
                        <td style="font-weight: bold;">Condenser Water Outlet Temp.</td>
                        <td class="val-col">{{ params.outletTemp }}</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">4</td>
                        <td style="font-weight: bold;">Dirt Correction % in M.J.</td>
                        <td class="val-col">{{ params.dirtCorrection }}</td>
                        
                        <td colspan="3"></td>
                    </tr>
                </tbody>
            </table>

            <div style="margin-top: 80px; display: flex; justify-content: space-between; text-align: center; font-weight: bold; font-size: 15px; color: #000;">
                <div style="width: 30%;">Lab Chemist</div>
                <div style="width: 30%;">Lab Incharge</div>
                <div style="width: 30%;">Chief Chemist</div>
            </div>

        </div>
        
        <div class="alert alert-light w-75 mx-auto text-center border shadow-sm mt-5 text-muted" ng-hide="isDataLoaded">
            <i class="fa fa-info-circle fa-2x mb-3 text-primary d-block"></i>
            <h6 class="fw-bold">No Report Data Loaded</h6>
            <p class="small mb-0">Please enter a date from the top menu and click <strong>Generate</strong> to view the Daily Manufacturing Details.</p>
        </div>

    </div>

    <script src="js/reportMfgDetails.js"></script>

</body>
</html>