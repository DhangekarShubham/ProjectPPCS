<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RT-7(C) Stock Entry</title>
</head>
<body>

    <div class="contentpanel" ng-controller="RT7CController">
        
        <link href="css/forms.css" rel="stylesheet">
        <script src="js/rt7cStock.js"></script>

        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded">
            
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                <i class="fa fa-book me-2"></i> RT-7 (C) STOCK DATA ENTRY
            </div>
            
            <form name="rt7Form" class="p-4" novalidate>
                
                <div class="bg-light p-3 border rounded shadow-sm mb-4">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Rt7c Number</label>
                            <input type="text" class="form-control form-control-sm border-success fw-bold" ng-model="rt7c.rt7cNumber" required>
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Year</label>
                            <input type="text" class="form-control form-control-sm border-success" ng-model="rt7c.seasonYear" placeholder="2018-2019" required>
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Start Date</label>
                            <input type="date" class="form-control form-control-sm" ng-model="rt7c.startDate">
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">End Date</label>
                            <input type="date" class="form-control form-control-sm" ng-model="rt7c.endDate">
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Stock Date<span class="text-danger">*</span></label>
                            <input type="date" class="form-control form-control-sm border-primary" ng-model="rt7c.stockDate" required>
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Actual Date</label>
                            <input type="date" class="form-control form-control-sm" ng-model="rt7c.actualDate">
                        </div>
                    </div>
                </div>

                <ul class="nav nav-tabs mb-3" id="rt7cTabs" role="tablist">
                    <li class="nav-item" role="presentation"><button class="nav-link active fw-bold text-secondary" data-bs-toggle="tab" data-bs-target="#screen1" type="button">Screen 1</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link fw-bold text-secondary" data-bs-toggle="tab" data-bs-target="#screen2" type="button">Screen 2</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link fw-bold text-secondary" data-bs-toggle="tab" data-bs-target="#screen3" type="button">Screen 3</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link fw-bold text-secondary" data-bs-toggle="tab" data-bs-target="#screen4" type="button">Screen 4</button></li>
                </ul>

                <div class="tab-content" id="rt7cTabsContent">
                    
                    <div class="tab-pane fade show active" id="screen1" role="tabpanel">
                        <div class="table-responsive shadow-sm border rounded bg-white">
                            <table class="table table-hover table-sm table-bordered mb-0">
                                <thead class="bg-light" style="position: sticky; top: 0; z-index: 10;">
                                    <tr>
                                        <th class="text-muted small text-uppercase" style="width: 25%;">Material</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">Volume(HL)</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">Brix %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">POL %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 21%;">Purity %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="mat in ['Clear Juice', 'Syrup', 'Unsulphited Syrup', 'A - Massecuite', 'B - Massecuite', 'C - Massecuite', 'Other - Massecuite', 'A - Light - Molasses', 'B - Light - Molasses', 'C - Light - Molasses', 'Other - Light - Molasses']">
                                        <td class="align-middle fw-bold text-secondary small ps-3">{{ mat }}</td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen1[mat].volume"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen1[mat].brixPercent" ng-change="calculatePurity(rt7c.screen1[mat])"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen1[mat].polPercent" ng-change="calculatePurity(rt7c.screen1[mat])"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end bg-light" placeholder="0.000" ng-model="rt7c.screen1[mat].purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="screen2" role="tabpanel">
                        <div class="table-responsive shadow-sm border rounded bg-white">
                            <table class="table table-hover table-sm table-bordered mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="text-muted small text-uppercase" style="width: 25%;">Material</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">Volume(HL)</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">Brix %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">POL %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 21%;">Purity %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="mat in ['A - Heavy - Molasses', 'B - Heavy - Molasses', 'Other - Heavy - Molasses', 'C - seed', 'B - seed', 'Dry seed', 'C - Grain', 'B - Grain', 'Other - Molasses', 'B - After - Worker', 'C - Fore - Worker', 'Final - Molasses', 'C - After - Worker', 'Unbagged - Sugar']">
                                        <td class="align-middle fw-bold text-secondary small ps-3">{{ mat }}</td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen2[mat].volume"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen2[mat].brixPercent" ng-change="calculatePurity(rt7c.screen2[mat])"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen2[mat].polPercent" ng-change="calculatePurity(rt7c.screen2[mat])"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end bg-light" placeholder="0.000" ng-model="rt7c.screen2[mat].purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="screen3" role="tabpanel">
                        <div class="bg-white p-4 shadow-sm border rounded">
                            <div class="row g-4">
                                <div class="col-md-6 border-end pe-4">
                                    <div class="row mb-2 align-items-center" ng-repeat="mat in ['Prev - Season - Material - Quantity', 'Prev - Season - Material - Brix', 'Prev - Season - Material - Pol', 'Prev - Season - Mat - FM - Brix', 'Prev - Season - Mat - FM - Pol', 'Prev - Season - Sugar - Quantity', 'Prev - Season - Sugar - Brix', 'Prev - Season - Sugar - Pol', 'Prev - Season - Sugar - FM - Brix', 'Prev - Season - Sugar - FM - Pol', 'Rs - Prc of - Material', 'Ash - Prc of - Material', 'Rs - Prc of - Sugar', 'Ash - Prc of - Sugar']">
                                        <label class="col-sm-7 text-end text-muted small fw-bold">{{ mat }}</label>
                                        <div class="col-sm-5"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen3[mat].volume"></div>
                                    </div>
                                </div>
                                <div class="col-md-6 ps-4">
                                    <div class="row mb-2 align-items-center" ng-repeat="mat in ['Rori - Sugar - Quantity', 'Rori - Sugar - Pol', 'Bagasse - Saved', 'Lime - Kiln - Gas - CO2 %', 'Feed - Water - Temp', 'Feed - Water - PH', 'Clear - Juice - Temp', 'Clear - Juice - PH', 'Rs - Prc of - Raw - Sugar', 'Ash - Prc of - Raw - Sugar', 'Reducement - Sugar', 'Reducement - Material', 'Tons of - Pol in - Rori Sugar']">
                                        <label class="col-sm-6 text-end text-muted small fw-bold">{{ mat }}</label>
                                        <div class="col-sm-5"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen3[mat].volume"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="screen4" role="tabpanel">
                        <div class="table-responsive shadow-sm border rounded bg-white">
                            <table class="table table-hover table-sm table-bordered mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="text-muted small text-uppercase" style="width: 25%;">Material</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">Volume/Qty</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">Brix %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%;">POL %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 21%;">Purity %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="mat in ['Prev - Brown - Sugar - Quantity', 'Prev - BISS - Sugar - Quantity', 'PSeason - Sugar - Quantity (4)', 'PSeason - Sugar - Quantity (5)', 'Prev - Season - FM of - Brow', 'Prev - Season - FM of - BISS', 'Prev - Season - FM of - (4)', 'Prev - Season - FM of - (5)', 'PAN - A', 'PAN - B', 'PAN - C', 'PAN - D']">
                                        <td class="align-middle fw-bold text-secondary small ps-3">{{ mat }}</td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen4[mat].volume"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen4[mat].brixPercent" ng-change="calculatePurity(rt7c.screen4[mat])"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt7c.screen4[mat].polPercent" ng-change="calculatePurity(rt7c.screen4[mat])"></td>
                                        <td class="px-2"><input type="number" step="0.001" class="form-control form-control-sm text-end bg-light" placeholder="0.000" ng-model="rt7c.screen4[mat].purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </div>

                <div class="row mt-4 mb-2 bg-light py-3 border-top">
                    <div class="col-12 text-center">
                        <button type="button" class="btn btn-primary px-4 me-2" ng-click="saveData('save')" ng-disabled="rt7Form.$invalid" style="background-color: #6593b4; border: none;">Save</button>
                        <button type="button" class="btn btn-light px-4 border me-2" ng-click="clearForm()">Cancel / New</button>
                        <button type="button" class="btn btn-warning px-4 text-white" ng-click="findData()" style="background-color: #e5a751; border: none;">Find</button>
                        <button type="button" class="btn btn-outline-secondary px-3 ms-2" ng-click="saveData('update')">Change</button>
                        <button type="button" class="btn btn-outline-danger px-3 ms-2" ng-click="deleteData()">Delete</button>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>
</html>