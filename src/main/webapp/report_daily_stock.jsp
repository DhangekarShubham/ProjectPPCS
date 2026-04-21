<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="contentpanel" ng-controller="StockReportController">
    <style>
        /* --- PRINT CSS OVERRIDES --- */
        @media print {
            .no-print, .alert, nav, header, footer { display: none !important; }
            body, html { background-color: #ffffff !important; margin: 0 !important; padding: 0 !important; }
            #printableArea { position: relative !important; left: 0 !important; top: 0 !important; width: 100% !important; box-shadow: none !important; border: none !important; margin: 0 !important; padding: 0 !important; display: block !important; }
            .pdf-table { width: 100% !important; border-collapse: collapse !important; }
            .pdf-table th, .pdf-table td { border: 1px solid #000 !important; color: #000 !important; }
            .pdf-table th { background-color: #f1f5f9 !important; -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
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

    <div class="container-fluid px-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1 no-print">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Inventory Reports</li>
                    <li class="breadcrumb-item active text-primary">Daily Stock Ledger</li>
                </ol>
            </nav>
        </div>

        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded no-print">
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                <i class="fa fa-file-text-o me-2"></i> DAILY STOCK LEDGER REPORT GENERATION
            </div>
           
            <div class="main-panel">
                <div class="row align-items-center bg-light p-3 mx-0 border-bottom">
                    <div class="col-md-4 d-flex align-items-center">
                        <label class="text-muted small fw-bold text-uppercase me-2 mb-0" style="white-space: nowrap;">Select Valuation Date:</label>
                        <input type="date" class="form-control form-control-sm border-primary" ng-model="selectedDate">
                    </div>
                    <div class="col-md-8">
                        <button type="button" class="btn btn-sm btn-primary fw-bold px-4 me-2 shadow-sm" ng-click="generateReport()" style="background-color: #6593b4; border: none;">
                            <i class="fa fa-cogs me-1"></i> Generate Ledger
                        </button>
                        <button type="button" class="btn btn-sm btn-warning fw-bold px-4 text-white shadow-sm" ng-click="printReport()" style="background-color: #e5a751; border: none;" ng-disabled="!isDataLoaded">
                            <i class="fa fa-print me-1"></i> Print / PDF
                        </button>
                        <button type="button" class="btn btn-sm btn-light fw-bold px-4 border shadow-sm" ng-click="clearReport()">
                            <i class="fa fa-refresh me-1"></i> Reset
                        </button>
<!--                         <button type="button" class="btn btn-sm btn-dark fw-bold px-4 shadow-sm ms-2" ng-click="testClick()">TEST ANGULAR</button>
 -->                    </div>
                </div>
            </div>
        </div>

        <div id="printableArea" class="report-paper shadow mt-4 p-4 bg-white" ng-show="isDataLoaded">
            <div class="text-center border-bottom border-3 border-dark mb-4 pb-2">
                <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                <h5 class="report-subtitle">Daily Product & By-Product Stock Ledger</h5>
            </div>
            
            <div class="row mb-3" style="font-size: 0.9rem; font-weight: bold;">
                <div class="col-4">CRUSHING SEASON: {{ sugarList.length > 0 ? sugarList[0].seasonYear : '' }}</div>
                <div class="col-4 text-center">UNIT: 01 (COMBINE)</div>
                <div class="col-4 text-end">LEDGER DATE: {{ displayDate }}</div>
            </div>

            <table class="pdf-table mb-0">
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
                        <td class="bg-dark text-white fw-bold text-center" colspan="7">1.0 FINAL SUGAR STOCKS (FINISHED GOODS)</td>
                    </tr>
                    <tr ng-repeat="sugar in sugarList">
                        <td class="text-center">{{ sugar.rowNumber }}</td>
                        <td class="fw-bold">{{ sugar.productName }}</td>
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
                        <td class="bg-dark text-white fw-bold text-center" colspan="7">2.0 BY-PRODUCTS & RESIDUAL STOCKS</td>
                    </tr>
                    <tr ng-repeat="byprod in byProductList">
                        <td class="text-center">{{ byprod.rowNumber }}</td>
                        <td class="fw-bold">{{ byprod.productName }}</td>
                        <td class="text-center">{{ byprod.unit }}</td>
                        <td class="text-end">{{ byprod.openingBalance | number:3 }}</td>
                        <td class="text-end">{{ byprod.productionToday | number:3 }}</td>
                        <td class="text-end">{{ byprod.dispatchSale | number:3 }}</td>
                        <td class="text-end fw-bold">{{ byprod.closingBalance | number:3 }}</td>
                    </tr>
                </tbody>
            </table>
            
            <div class="row text-center mt-5 pt-4">
                <div class="col-3"><div style="border-top: 1px solid #000; width: 80%; margin: 0 auto;"></div><br>STORE KEEPER</div>
                <div class="col-3"><div style="border-top: 1px solid #000; width: 80%; margin: 0 auto;"></div><br>CHIEF CHEMIST</div>
                <div class="col-3"><div style="border-top: 1px solid #000; width: 80%; margin: 0 auto;"></div><br>CHIEF ACCOUNTANT</div>
                <div class="col-3"><div style="border-top: 1px solid #000; width: 80%; margin: 0 auto;"></div><br>MANAGING DIRECTOR</div>
            </div>
        </div>
        
        <div class="alert alert-light w-75 mx-auto text-center border shadow-sm mt-5 text-muted no-print" ng-hide="isDataLoaded">
            <i class="fa fa-info-circle fa-2x mb-3 text-primary d-block"></i>
            <h6 class="fw-bold">No Report Data Loaded</h6>
            <p class="small mb-0">Please enter a date from the top menu and click <strong>Generate</strong> to view the Daily Manufacturing Details.</p>
        </div>

    </div>
</div>