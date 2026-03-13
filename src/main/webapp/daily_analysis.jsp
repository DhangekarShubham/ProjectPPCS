<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="analysisApp">
<head>
    <meta charset="UTF-8">
    <title>Daily Data Analysis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/dailyAnalysis.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); }
        .action-btn:hover { background-color: #e2e6ea; }
        .grid-title { font-size: 0.85rem; color: #000080; font-weight: bold; margin-bottom: 2px; }
        .table-container { background-color: white; border: 1px solid #999; height: 180px; overflow-y: auto; margin-bottom: 15px; }
        .table th { background-color: #f0f0f0; position: sticky; top: 0; font-size: 0.8rem; z-index: 1; padding: 4px; }
        .table td { padding: 2px 4px; font-size: 0.85rem; vertical-align: middle; }
        .table-striped tbody tr:nth-of-type(odd) { background-color: #e0ffff; }
        .nav-tabs .nav-link { background-color: #f0f0f0; color: #333; border: 1px solid #999; margin-right: 2px; font-weight: bold; }
        .nav-tabs .nav-link.active { background-color: #fff; color: #b22222; border-bottom-color: transparent; }
        .tab-content { background-color: #fff; padding: 15px; border: 1px solid #999; border-top: none; }
    </style>
</head>
<body ng-controller="AnalysisController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">DAILY DATA ANALYSIS</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">New</button>
                    <button type="button" class="btn action-btn">Find</button>
                    <button type="button" class="btn action-btn" ng-click="changeData()">Change</button>
                    <button type="button" class="btn action-btn" ng-click="saveData()">Save</button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()">Cancel</button>
                    <button type="button" class="btn action-btn">Delete</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    <form name="analysisForm" novalidate>
                        
                        <div class="row mb-3 align-items-center bg-white p-2 border rounded shadow-sm mx-0">
                            <label class="col-auto fw-bold text-dark mb-0">Sample Date</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm" ng-model="analysis.sampleDate" required>
                            </div>
                        </div>

                        <ul class="nav nav-tabs" id="analysisTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="screen1-tab" data-bs-toggle="tab" data-bs-target="#screen1" type="button" role="tab">Screen 1 (Losses & Time)</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="screen2-tab" data-bs-toggle="tab" data-bs-target="#screen2" type="button" role="tab">Screen 2 (Process Products)</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="analysisTabsContent">
                            
                            <div class="tab-pane fade show active" id="screen1" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="grid-title">Cane / Filter cake</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Cane / Filter Cake</th><th>Weight</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Filter Cake</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.fcWeight"></td></tr>
                                                    <tr><td>Member Cane Crushed</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.memberCane"></td></tr>
                                                    <tr><td>Non-Member Cane Crushed</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.nonMemberCane"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="grid-title">Time account</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Time account</th><th>Quantity</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Working Hours</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.workHours"></td></tr>
                                                    <tr><td>Hours Lost Mechanical</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.lostMech"></td></tr>
                                                    <tr><td>Hours Lost Electrical</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.lostElec"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="grid-title">Bagasse/FC/RS/WS</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Item</th><th>Pol</th><th>Moisture</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Bagasse</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagassePol"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagasseMoist"></td>
                                                    </tr>
                                                    <tr><td>Filter Cake</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.fcPol"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.fcMoist"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mt-2">
                                    <div class="col-md-6">
                                        <div class="grid-title">Undetermined losses/Dirt correction</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Losses/Correction</th><th>Quantity</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Dirt Correction</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.dirtCorrection"></td></tr>
                                                    <tr><td>Recovery Correction</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.recoveryCorrection"></td></tr>
                                                    <tr><td>Undetermined Losses</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.undetLosses"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="grid-title">Condenser Temp.</div>
                                        <div class="table-container shadow-sm">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Type</th><th>Temp.(oC)</th></tr></thead>
                                                <tbody>
                                                    <tr><td>Condenser Inlet Temp.</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.inletTemp"></td></tr>
                                                    <tr><td>Condenser Outlet Temp.</td><td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.outletTemp"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="screen2" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="grid-title">Process products (Bags)</div>
                                        <div class="table-container shadow-sm" style="height: 380px;">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Sugar Production</th><th>No. of Bags</th></tr></thead>
                                                <tbody>
                                                    <tr><td>L-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagsL30_50"></td></tr>
                                                    <tr><td>M-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagsM30_50"></td></tr>
                                                    <tr><td>S1-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagsS130_50"></td></tr>
                                                    <tr><td>L-30 (100 Kg)</td><td><input type="number" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagsL30_100"></td></tr>
                                                    <tr><td>Raw Sugar (50 Kg)</td><td><input type="number" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.bagsRaw_50"></td></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="col-md-8">
                                        <div class="grid-title">Process products (Analysis)</div>
                                        <div class="table-container shadow-sm" style="height: 380px;">
                                            <table class="table table-bordered table-striped mb-0">
                                                <thead><tr><th>Process products</th><th>Brix</th><th>Pole</th><th>Purity</th></tr></thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Primary Juice</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.pjBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.pjPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.pjPurity"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Mixed Juice</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.mjBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.mjPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.mjPurity"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Clear Juice</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.cjBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.cjPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.cjPurity"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Final Molasses</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.fmBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.fmPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.fmPurity"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>A - Massecuite</td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.aMassBrix"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.aMassPole"></td>
                                                        <td><input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="analysis.aMassPurity"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
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