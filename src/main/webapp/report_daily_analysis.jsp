<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="analysisApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Analysis Report | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> <style>
        /* --- PRINT CSS OVERRIDES --- */
        @media print {
            .no-print, .alert, nav, header, footer { 
                display: none !important; 
            }
            body, html {
                background-color: #ffffff !important;
                margin: 0 !important;
                padding: 0 !important;
            }
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
            .pdf-table { width: 100% !important; border-collapse: collapse !important; }
            .pdf-table th, .pdf-table td { border: 1px solid #000 !important; color: #000 !important; }
            .pdf-table th, .section-header { 
                background-color: #f1f5f9 !important; 
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important; 
            }
            .section-header {
                background-color: #000 !important;
                color: #fff !important;
            }
        }
        
        /* --- SCREEN & REPORT STYLING --- */
        :root { --primary-blue: #2563eb; --bg-light: #f1f5f9; --text-main: #1e293b; }
        body { background-color: var(--bg-light); font-family: 'Inter', sans-serif; color: var(--text-main); }
        
        .report-header-title { font-size: 22px; font-weight: 800; text-align: center; color: #000; letter-spacing: 0.5px; margin-bottom: 5px; }
        .report-header-subtitle { font-size: 16px; font-weight: bold; text-align: center; margin-bottom: 25px; color: #333; text-decoration: underline; }
        .report-meta-info { display: flex; justify-content: space-between; font-weight: bold; margin-bottom: 15px; font-size: 14px; color: #000; }
        
        .pdf-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; border: 1.5px solid #000; }
        .pdf-table th, .pdf-table td { border: 1px solid #000; padding: 6px 10px; font-size: 13px; color: #000; }
        .pdf-table th { background-color: #f8fafc; text-align: center; font-weight: bold; text-transform: uppercase; }
        
        .section-header { background-color: #000 !important; color: #fff !important; font-weight: bold; text-align: center !important; text-transform: uppercase; font-size: 14px; padding: 8px !important; }
        .val-col { text-align: right; font-family: 'JetBrains Mono', monospace; font-weight: bold; }
        .label-col { font-weight: 600; color: #333; }
        
        .signature-line { border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto; }
        
        /* Hide Angular curly braces before load */
        [ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
            display: none !important;
        }
    </style>
</head>
<body>

    <div class="contentpanel ng-cloak" ng-controller="AnalysisController">
        
        <div class="container-fluid mt-3 mb-4 no-print">
            <div class="card shadow-sm border-0">
                <div class="card-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                    <i class="fa fa-file-text-o me-2"></i> Analytical Report Engine
                </div>
                
                <div class="card-body bg-light p-3 border-bottom d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center" style="width: 40%;">
                        <label class="text-muted small fw-bold text-uppercase me-3 mb-0" style="white-space: nowrap;">Report Date:</label>
                        
                        
                        <div class="input-group input-group-sm shadow-sm">
                            <input type="text" class="form-control border-primary text-center fw-bold text-primary" 
                                   placeholder="DD/MM/YYYY" ng-model="manualDateText" ng-change="syncFromText()" maxlength="10">
                            <input type="date" class="form-control border-primary px-1" 
                                   ng-model="searchDate" ng-change="syncFromPicker()" 
                                   style="max-width: 40px; cursor: pointer;">
                        </div>
                        
                        
                    </div>

                    <div>
                        <button type="button" class="btn btn-sm btn-primary fw-bold px-4 me-2 shadow-sm" ng-click="findData()" style="background-color: #6593b4; border: none;">
                            <i class="fa fa-cogs me-1"></i> Generate
                        </button>
                        <button type="button" class="btn btn-sm btn-warning fw-bold px-4 text-white shadow-sm" ng-click="printReport()" style="background-color: #e5a751; border: none;" ng-disabled="!isDataLoaded">
                            <i class="fa fa-print me-1"></i> Print / PDF
                        </button>
                        <button type="button" class="btn btn-sm btn-light fw-bold px-4 border shadow-sm" ng-click="clearForm()">
                            <i class="fa fa-refresh me-1"></i> Reset
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mt-4 p-5 bg-white shadow border rounded" id="printableArea" ng-show="isDataLoaded">
            
            <div class="report-header-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</div>
            <div class="report-header-subtitle">Daily Laboratory Analysis Report</div>
            
            <div class="report-meta-info">
                <div>CRUSHING SEASON: {{ analysis.seasonYear || '2025-2026' }}</div>
                <div>REPORT DATE: {{ displayDate }}</div>
            </div>

            <div class="row g-3">
                <div class="col-md-6">
                    <table class="pdf-table">
                        <thead>
                            <tr><th colspan="2" class="section-header">Time & Throughput</th></tr>
                            <tr><th>Particulars</th><th class="text-end" style="width: 30%;">Value</th></tr>
                        </thead>
                        <tbody>
                            <tr><td class="label-col">Actual Working Hours</td><td class="val-col">{{ formatNumber(analysis.workingHours) }}</td></tr>
                            <tr><td class="label-col">Total Lost Hours</td><td class="val-col">{{ formatNumber(analysis.lostHours) }}</td></tr>
                            <tr><td class="label-col">Member Cane (MT)</td><td class="val-col">{{ formatNumber(analysis.memberCane) }}</td></tr>
                            <tr><td class="label-col">Non-Member Cane (MT)</td><td class="val-col">{{ formatNumber(analysis.nonMemberCane) }}</td></tr>
                            <tr style="border-top: 2px solid #000;"><td class="label-col fw-bold">Total Crushed (MT)</td><td class="val-col text-primary">{{ formatNumber(analysis.totalCrushed) }}</td></tr>
                        </tbody>
                    </table>
                </div>

                <div class="col-md-6">
                    <table class="pdf-table">
                        <thead>
                            <tr><th colspan="2" class="section-header">Corrections & Recovery</th></tr>
                            <tr><th>Particulars</th><th class="text-end" style="width: 30%;">Value</th></tr>
                        </thead>
                        <tbody>
                            <tr><td class="label-col">Dirt Correction (%)</td><td class="val-col">{{ formatNumber(analysis.dirtCorrection) }}</td></tr>
                            <tr><td class="label-col">Recovery Correction</td><td class="val-col">{{ formatNumber(analysis.recoveryCorrection) }}</td></tr>
                            <tr><td class="label-col">Undetermined Losses</td><td class="val-col">{{ formatNumber(analysis.undeterminedLosses) }}</td></tr>
                            <tr><td class="label-col">Condenser Inlet (°C)</td><td class="val-col">{{ formatNumber(analysis.condenserInlet) }}</td></tr>
                            <tr><td class="label-col">Condenser Outlet (°C)</td><td class="val-col">{{ formatNumber(analysis.condenserOutlet) }}</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row g-3 mt-1">
                <div class="col-md-6">
                    <table class="pdf-table">
                        <thead>
                            <tr><th colspan="3" class="section-header">By-Product Analysis</th></tr>
                            <tr><th>Item</th><th class="text-end">Pol %</th><th class="text-end">Moist %</th></tr>
                        </thead>
                        <tbody>
                            <tr><td class="label-col">Bagasse</td><td class="val-col">{{ formatNumber(analysis.bagassePol) }}</td><td class="val-col">{{ formatNumber(analysis.bagasseMoist) }}</td></tr>
                            <tr><td class="label-col">Filter Cake</td><td class="val-col">{{ formatNumber(analysis.filterCakePol) }}</td><td class="val-col">{{ formatNumber(analysis.filterCakeMoist) }}</td></tr>
                        </tbody>
                    </table>
                </div>

                <div class="col-md-6">
                    <table class="pdf-table">
                        <thead>
                            <tr><th colspan="2" class="section-header">Sugar Production (Bags)</th></tr>
                            <tr><th>Grade</th><th class="text-end">Units</th></tr>
                        </thead>
                        <tbody>
                            <tr><td class="label-col">M-30 (50 Kg)</td><td class="val-col">{{ formatInt(analysis.sugarM30) }}</td></tr>
                            <tr><td class="label-col">S1-30 (50 Kg)</td><td class="val-col">{{ formatInt(analysis.sugarS130) }}</td></tr>
                            <tr style="border-top: 2px solid #000;"><td class="label-col fw-bold">Total Bags</td><td class="val-col text-primary">{{ formatInt(analysis.totalBags) }}</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row mt-1">
                <div class="col-12">
                    <table class="pdf-table"> 
                        <thead>
                            <tr><th colspan="4" class="section-header">Process Products Analysis</th></tr>
                            <tr>
                                <th style="width: 40%; text-align: left; padding-left: 15px;">Product Name</th>
                                <th class="text-end">Brix %</th>
                                <th class="text-end">Pol %</th>
                                <th class="text-end">Purity %</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td class="label-col" style="padding-left: 15px;">Primary Juice</td><td class="val-col">{{ formatNumber(analysis.pjBrix) }}</td><td class="val-col">{{ formatNumber(analysis.pjPole) }}</td><td class="val-col">{{ formatNumber(analysis.pjPurity) }}</td></tr>
                            <tr><td class="label-col" style="padding-left: 15px;">Mixed Juice</td><td class="val-col">{{ formatNumber(analysis.mjBrix) }}</td><td class="val-col">{{ formatNumber(analysis.mjPole) }}</td><td class="val-col">{{ formatNumber(analysis.mjPurity) }}</td></tr>
                            <tr><td class="label-col" style="padding-left: 15px;">Clear Juice</td><td class="val-col">{{ formatNumber(analysis.cjBrix) }}</td><td class="val-col">{{ formatNumber(analysis.cjPole) }}</td><td class="val-col">{{ formatNumber(analysis.cjPurity) }}</td></tr>
                            <tr><td class="label-col" style="padding-left: 15px;">Final Molasses</td><td class="val-col">{{ formatNumber(analysis.fmBrix) }}</td><td class="val-col">{{ formatNumber(analysis.fmPole) }}</td><td class="val-col">{{ formatNumber(analysis.fmPurity) }}</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div style="margin-top: 60px; display: flex; justify-content: space-between; text-align: center; font-weight: bold; font-size: 13px; color: #000;">
                <div style="width: 30%;"><div class="signature-line"></div>LAB CHEMIST</div>
                <div style="width: 30%;"><div class="signature-line"></div>CHIEF CHEMIST</div>
                <div style="width: 30%;"><div class="signature-line"></div>MANAGING DIRECTOR</div>
            </div>

        </div>

        <div class="alert alert-light w-75 mx-auto text-center border shadow-sm mt-5 text-muted no-print" ng-hide="isDataLoaded">
            <i class="fa fa-info-circle fa-2x mb-3 text-primary d-block"></i>
            <h6 class="fw-bold">No Report Data Loaded</h6>
            <p class="small mb-0">Please select an Analysis Date and click <strong>Generate</strong> to view the records.</p>
        </div>

    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportDailyAnalysis.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>