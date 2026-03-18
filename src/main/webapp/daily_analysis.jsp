<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="contentpanel" id="analysis-panel" ng-controller="AnalysisController">
    
    <style>
        .erp-form-container {
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 4px;
            margin-bottom: 30px;
            overflow: hidden; 
        }
        .erp-form-header {
            background-color: #3bb4b4; 
            color: #ffffff; 
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
            border-bottom: 1px solid #33a0a0;
            letter-spacing: 0.5px;
        }
        .form-control-sm { font-size: 13px; border-radius: 2px; }
        .border-success { border-color: #28a745 !important; }
        
        .nav-tabs .nav-link { color: #657390; font-weight: 600; border: none; padding: 10px 20px; }
        .nav-tabs .nav-link.active { color: #3bb4b4; border-bottom: 3px solid #3bb4b4; background: transparent; }
        
        .table-container { border: 1px solid #e2e8f0; border-radius: 6px; overflow: hidden; }
        .table thead th { background-color: #f8fafc; font-size: 11px; text-transform: uppercase; color: #475569; }
        .table td { vertical-align: middle; padding: 6px 10px; }
        
        .grid-title { font-size: 12px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 8px; border-bottom: 1px solid #eee; padding-bottom: 5px; }
        
        /* Action Buttons */
        .btn { font-size: 13px; font-weight: 500; border-radius: 3px; }
        .btn-erp-submit { background-color: #6593b4; color: white; min-width: 120px; border: none; }
        .btn-erp-reset { background-color: #ffffff; color: #333; min-width: 120px; border: 1px solid #ccc; }
        .btn-erp-view { background-color: #e5a751; color: white; min-width: 120px; border: none; }
        .btn-erp-submit:hover, .btn-erp-view:hover { opacity: 0.9; color: white; }
        .btn-erp-reset:hover { background-color: #f0f0f0; }
    </style>

    <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded">
        
        <div class="erp-form-header px-3 py-2 fw-bold text-uppercase">
            <i class="fa fa-flask me-2"></i> DAILY DATA ANALYSIS & PROCESS LOG
        </div>
        
        <form name="analysisForm" class="p-4" novalidate>
            
            <div class="row mb-4 align-items-center bg-light p-3 border rounded mx-1 shadow-sm">
                <label class="col-sm-2 text-end text-muted small fw-bold text-uppercase">Analysis Date:<span class="text-danger">*</span></label>
                <div class="col-sm-3">
                    <input type="date" class="form-control form-control-sm border-success" ng-model="analysis.sampleDate" required>
                </div>
                <div class="col-sm-7 text-end">
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill border border-primary border-opacity-25" style="background-color: #e6f2ff; color: #0d6efd; border: 1px solid #b6d4fe;">
                        <i class="fa fa-info-circle me-1"></i> Data Entry Mode: Single Day
                    </span>
                </div>
            </div>

            <ul class="nav nav-tabs mb-4" id="analysisTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-bold text-secondary" id="screen1-tab" data-bs-toggle="tab" data-bs-target="#screen1" type="button" role="tab">
                        <i class="fa fa-clock-o me-2"></i>Losses & Time Account
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-bold text-secondary" id="screen2-tab" data-bs-toggle="tab" data-bs-target="#screen2" type="button" role="tab">
                        <i class="fa fa-flask me-2"></i>Process Product Analysis
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="analysisTabsContent">
                
                <div class="tab-pane fade show active" id="screen1" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="grid-title"><i class="fa fa-balance-scale me-1 text-info"></i> Crushing & Weight Data</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Parameter</th><th class="text-center">Weight (MT)</th></tr></thead>
                                    <tbody>
                                        <tr><td class="align-middle small fw-bold text-secondary">Filter Cake</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.fcWeight"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Member Cane</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.memberCane"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Non-Member Cane</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.nonMemberCane"></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="grid-title"><i class="fa fa-hourglass-half me-1 text-warning"></i> Time Management</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Operation</th><th class="text-center">Hours</th></tr></thead>
                                    <tbody>
                                        <tr><td class="align-middle small fw-bold text-secondary">Working Hours</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.workHours"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Mechanical Loss</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.lostMech"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Electrical Loss</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.lostElec"></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="grid-title"><i class="fa fa-recycle me-1 text-success"></i> Solid Waste Analysis</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Material</th><th class="text-center">Pol%</th><th class="text-center">Moist%</th></tr></thead>
                                    <tbody>
                                        <tr><td class="align-middle small fw-bold text-secondary">Bagasse</td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.bagassePol"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.bagasseMoist"></td>
                                        </tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Filter Cake</td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.fcPol"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.fcMoist"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row g-4 mt-1">
                        <div class="col-md-6">
                            <div class="grid-title"><i class="fa fa-sliders me-1 text-primary"></i> Efficiency Corrections</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Correction Type</th><th class="text-center">Percentage (%)</th></tr></thead>
                                    <tbody>
                                        <tr><td class="align-middle small fw-bold text-secondary">Dirt Correction</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.dirtCorrection"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Recovery Correction</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.recoveryCorrection"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Undetermined Losses</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.undetLosses"></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="grid-title"><i class="fa fa-thermometer-half me-1 text-danger"></i> Thermal Parameters</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Condenser Measurement</th><th class="text-center">Temp (°C)</th></tr></thead>
                                    <tbody>
                                        <tr><td class="align-middle small fw-bold text-secondary">Inlet Temperature</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.inletTemp"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Outlet Temperature</td><td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.outletTemp"></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="screen2" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="grid-title"><i class="fa fa-cubes me-1 text-info"></i> Sugar Production (Bags)</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Grade</th><th class="text-center">Units</th></tr></thead>
                                    <tbody>
                                        <tr><td class="align-middle small fw-bold text-secondary">L-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm text-end" ng-model="analysis.bagsL30_50"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">M-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm text-end" ng-model="analysis.bagsM30_50"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">S1-30 (50 Kg)</td><td><input type="number" class="form-control form-control-sm text-end" ng-model="analysis.bagsS130_50"></td></tr>
                                        <tr><td class="align-middle small fw-bold text-secondary">Raw Sugar (50 Kg)</td><td><input type="number" class="form-control form-control-sm text-end" ng-model="analysis.bagsRaw_50"></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="grid-title"><i class="fa fa-eyedropper me-1 text-primary"></i> Laboratory Analysis</div>
                            <div class="table-container shadow-sm">
                                <table class="table table-sm table-bordered bg-white mb-0">
                                    <thead><tr><th>Material</th><th class="text-center">Brix</th><th class="text-center">Pol</th><th class="text-center">Purity</th></tr></thead>
                                    <tbody>
                                        <tr>
                                            <td class="align-middle small fw-bold text-dark">Primary Juice</td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.pjBrix"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.pjPole"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end bg-light" ng-model="analysis.pjPurity" readonly></td>
                                        </tr>
                                        <tr>
                                            <td class="align-middle small fw-bold text-secondary">Mixed Juice</td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.mjBrix"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.mjPole"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.mjPurity"></td>
                                        </tr>
                                        <tr>
                                            <td class="align-middle small fw-bold text-secondary">Clear Juice</td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.cjBrix"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.cjPole"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.cjPurity"></td>
                                        </tr>
                                        <tr style="background-color: #fff9e6;">
                                            <td class="align-middle small fw-bold text-dark">Final Molasses</td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.fmBrix"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.fmPole"></td>
                                            <td><input type="number" step="0.01" class="form-control form-control-sm text-end" ng-model="analysis.fmPurity"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4 mb-2 bg-light py-3 border-top">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-erp-submit me-2" ng-click="saveData('save')" ng-disabled="analysisForm.$invalid">Save</button>
                    <button type="button" class="btn btn-erp-reset me-2" ng-click="clearForm()">Cancel / Reset</button>
                    <button type="button" class="btn btn-erp-view" ng-click="showFindBar = !showFindBar">Find Record</button>
                    
                    <button type="button" class="btn btn-outline-secondary px-3 ms-2" ng-click="saveData('update')">Change</button>
                    <button type="button" class="btn btn-outline-danger px-3 ms-2" ng-click="deleteData()">Delete</button>
                </div>
            </div>
            
            <div class="row mt-3 justify-content-center" ng-show="showFindBar">
                <div class="col-md-6 d-flex align-items-center bg-white p-3 border rounded shadow-sm">
                    <label class="fw-bold me-3 text-nowrap" style="font-size: 13px; color: #b22222;">Select Date to Find:</label>
                    <input type="date" class="form-control form-control-sm me-3 border-info" ng-model="analysis.sampleDate">
                    <button type="button" class="btn btn-sm text-white px-4 fw-bold" style="background-color: #6593b4;" ng-click="findData()">Ok</button>
                </div>
            </div>

        </form>
    </div>
</div>