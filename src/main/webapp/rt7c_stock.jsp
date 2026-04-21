<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="contentpanel" ng-controller="Rt7cStockEntryController">
    <style>
        .rt7c-form-wrapper {
            background-color: #f5f7fa; 
            padding-bottom: 50px;
            font-family: 'Inter', sans-serif;
        }
        
        .custom-panel {
            background-color: #ffffff;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
            margin: 20px;
        }

        .panel-heading-custom {
            background-color: #48b3b3;
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            padding: 12px 20px;
            letter-spacing: 0.5px;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }

        .top-inputs-box {
            border: 1px solid #e9ecef;
            border-radius: 4px;
            padding: 20px;
            margin: 20px;
        }
        
        .top-inputs-box label {
            color: #555;
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 5px;
            display: block;
        }

        .top-inputs-box input {
            border: 1px solid #ced4da;
            border-radius: 3px;
            padding: 5px 10px;
            font-size: 14px;
            width: 100%;
        }

        .border-green { border-color: #28a745 !important; }
        .border-blue { border-color: #0d6efd !important; }

        .nav-tabs-custom {
            border-bottom: 1px solid #dee2e6;
            margin: 0 20px 20px 20px;
        }
        
        .nav-tabs-custom .nav-link {
            color: #555;
            font-weight: 600;
            border: none;
            border-bottom: 2px solid transparent;
            padding: 10px 20px;
            background: transparent;
        }
        
        .nav-tabs-custom .nav-link.active {
            color: #333;
            border-bottom: 2px solid #dee2e6;
        }

        .table-wrapper {
            margin: 0 20px;
            border: 1px solid #e9ecef;
            border-radius: 4px;
            overflow-x: auto;
        }

        .table-custom { margin-bottom: 0; width: 100%; border-collapse: collapse; }
        .table-custom th {
            color: #666;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
        }
        .table-custom th.text-center { text-align: center; }
        
        .table-custom td {
            vertical-align: middle;
            padding: 8px 12px;
            border-bottom: 1px solid #f1f3f5;
            font-size: 13px;
            font-weight: 600;
            color: #555;
        }
        
        /* 🟢 FIXED: Input Box Visibility CSS 🟢 */
        .table-custom input {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 6px 10px;
            background-color: #ffffff;
            text-align: right;
            width: 100%;
            font-weight: 600;
            color: #333;
            font-family: 'JetBrains Mono', monospace;
            transition: border-color 0.2s ease;
        }
        
        .table-custom input:focus {
            outline: none;
            border-color: #48b3b3;
            box-shadow: 0 0 5px rgba(72, 179, 179, 0.4);
        }
        
        .table-custom input[readonly] {
            background-color: #f1f5f9;
            color: #64748b;
            border-color: #e2e8f0;
            cursor: not-allowed;
        }

        .action-bar {
            background-color: #f8f9fa;
            padding: 20px;
            border-top: 1px solid #e9ecef;
            text-align: center;
            margin-top: 30px;
        }

        .btn-custom {
            font-size: 13px;
            font-weight: 600;
            padding: 8px 20px;
            border-radius: 3px;
            margin: 0 5px;
            cursor: pointer;
        }
        
        .btn-save { background-color: #6a95a8; color: white; border: none; }
        .btn-cancel { background-color: #ffffff; color: #333; border: 1px solid #ccc; }
        .btn-find { background-color: #e5a751; color: white; border: none; }
        .btn-change { background-color: #ffffff; color: #6a95a8; border: 1px solid #6a95a8; }
        .btn-delete { background-color: #ffffff; color: #dc3545; border: 1px solid #dc3545; }
    </style>

    <div class="rt7c-form-wrapper">
        <div class="custom-panel">
            
            <div class="panel-heading-custom">
                <i class="fa fa-book me-2"></i> RT-7 (C) STOCK DATA ENTRY
            </div>
            
            <form name="rt7EntryForm" novalidate>
                
                <div class="top-inputs-box">
                    <div class="row align-items-end g-3">
                        <div class="col-md-2">
                            <label>Rt7c Number</label>
                            <input type="text" class="border-green fw-bold" ng-model="rt7cEntry.rt7cNumber" required>
                        </div>
                        <div class="col-md-2">
                            <label>Season Year</label>
                            <input type="text" class="border-green" ng-model="rt7cEntry.seasonYear" placeholder="2025-2026" required>
                        </div>
                        <div class="col-md-2">
                            <label>Start Date</label>
                            <input type="date" class="text-muted" ng-model="rt7cEntry.startDate">
                        </div>
                        <div class="col-md-2">
                            <label>End Date</label>
                            <input type="date" class="text-muted" ng-model="rt7cEntry.endDate">
                        </div>
                        <div class="col-md-2">
                            <label>Stock Date<span class="text-danger">*</span></label>
                            <input type="date" class="border-blue" ng-model="rt7cEntry.stockDate" required>
                        </div>
                        <div class="col-md-2">
                            <label>Actual Date</label>
                            <input type="date" class="text-muted" ng-model="rt7cEntry.actualDate">
                        </div>
                    </div>
                </div>

                <ul class="nav nav-tabs nav-tabs-custom" id="rt7cTabs" role="tablist">
                    <li class="nav-item" role="presentation"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#screen1" type="button">Screen 1</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#screen2" type="button">Screen 2</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#screen3" type="button">Screen 3</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#screen4" type="button">Screen 4</button></li>
                </ul>

                <div class="tab-content" id="rt7cTabsContent">
                    
                    <div class="tab-pane fade show active" id="screen1" role="tabpanel">
                        <div class="table-wrapper">
                            <table class="table-custom">
                                <thead>
                                    <tr>
                                        <th style="width: 28%; padding-left: 20px;">MATERIAL</th>
                                        <th class="text-center" style="width: 18%;">VOLUME(HL)</th>
                                        <th class="text-center" style="width: 18%;">BRIX %</th>
                                        <th class="text-center" style="width: 18%;">POL %</th>
                                        <th class="text-center" style="width: 18%;">PURITY %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="mat in ['Clear Juice', 'Syrup', 'Unsulphited Syrup', 'A - Massecuite', 'B - Massecuite', 'C - Massecuite', 'Other - Massecuite', 'A - Light - Molasses', 'B - Light - Molasses', 'C - Light - Molasses', 'Other - Light - Molasses']">
                                        <td style="padding-left: 20px;">{{ mat | uppercase }}</td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen1[mat].volume"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen1[mat].brixPercent" ng-change="calculatePurity(rt7cEntry.screen1[mat])"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen1[mat].polPercent" ng-change="calculatePurity(rt7cEntry.screen1[mat])"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen1[mat].purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="screen2" role="tabpanel">
                        <div class="table-wrapper">
                            <table class="table-custom">
                                <thead>
                                    <tr>
                                        <th style="width: 28%; padding-left: 20px;">MATERIAL</th>
                                        <th class="text-center" style="width: 18%;">VOLUME(HL)</th>
                                        <th class="text-center" style="width: 18%;">BRIX %</th>
                                        <th class="text-center" style="width: 18%;">POL %</th>
                                        <th class="text-center" style="width: 18%;">PURITY %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="mat in ['A - Heavy - Molasses', 'B - Heavy - Molasses', 'Other - Heavy - Molasses', 'C - seed', 'B - seed', 'Dry seed', 'C - Grain', 'B - Grain', 'Other - Molasses', 'B - After - Worker', 'C - Fore - Worker', 'Final - Molasses', 'C - After - Worker', 'Unbagged - Sugar']">
                                        <td style="padding-left: 20px;">{{ mat | uppercase }}</td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen2[mat].volume"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen2[mat].brixPercent" ng-change="calculatePurity(rt7cEntry.screen2[mat])"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen2[mat].polPercent" ng-change="calculatePurity(rt7cEntry.screen2[mat])"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen2[mat].purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="screen3" role="tabpanel">
                        <div class="p-4 mx-3">
                            <div class="row g-4">
                                <div class="col-md-6 border-end pe-4">
                                    <div class="row mb-3 align-items-center" ng-repeat="mat in ['Prev - Season - Material - Quantity', 'Prev - Season - Material - Brix', 'Prev - Season - Material - Pol', 'Prev - Season - Mat - FM - Brix', 'Prev - Season - Mat - FM - Pol', 'Prev - Season - Sugar - Quantity', 'Prev - Season - Sugar - Brix', 'Prev - Season - Sugar - Pol', 'Prev - Season - Sugar - FM - Brix', 'Prev - Season - Sugar - FM - Pol', 'Rs - Prc of - Material', 'Ash - Prc of - Material', 'Rs - Prc of - Sugar', 'Ash - Prc of - Sugar']">
                                        <label class="col-sm-7 text-end fw-bold mb-0" style="color:#555; font-size:12px;">{{ mat | uppercase }}</label>
                                        <div class="col-sm-5"><input type="number" step="0.001" class="form-control form-control-sm border" ng-model="rt7cEntry.screen3[mat].volume"></div>
                                    </div>
                                </div>
                                <div class="col-md-6 ps-4">
                                    <div class="row mb-3 align-items-center" ng-repeat="mat in ['Rori - Sugar - Quantity', 'Rori - Sugar - Pol', 'Bagasse - Saved', 'Lime - Kiln - Gas - CO2 %', 'Feed - Water - Temp', 'Feed - Water - PH', 'Clear - Juice - Temp', 'Clear - Juice - PH', 'Rs - Prc of - Raw - Sugar', 'Ash - Prc of - Raw - Sugar', 'Reducement - Sugar', 'Reducement - Material', 'Tons of - Pol in - Rori Sugar']">
                                        <label class="col-sm-6 text-end fw-bold mb-0" style="color:#555; font-size:12px;">{{ mat | uppercase }}</label>
                                        <div class="col-sm-5"><input type="number" step="0.001" class="form-control form-control-sm border" ng-model="rt7cEntry.screen3[mat].volume"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="screen4" role="tabpanel">
                        <div class="table-wrapper">
                            <table class="table-custom">
                                <thead>
                                    <tr>
                                        <th style="width: 28%; padding-left: 20px;">MATERIAL</th>
                                        <th class="text-center" style="width: 18%;">VOLUME/QTY</th>
                                        <th class="text-center" style="width: 18%;">BRIX %</th>
                                        <th class="text-center" style="width: 18%;">POL %</th>
                                        <th class="text-center" style="width: 18%;">PURITY %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="mat in ['Prev - Brown - Sugar - Quantity', 'Prev - BISS - Sugar - Quantity', 'PSeason - Sugar - Quantity (4)', 'PSeason - Sugar - Quantity (5)', 'Prev - Season - FM of - Brow', 'Prev - Season - FM of - BISS', 'Prev - Season - FM of - (4)', 'Prev - Season - FM of - (5)', 'PAN - A', 'PAN - B', 'PAN - C', 'PAN - D']">
                                        <td style="padding-left: 20px;">{{ mat | uppercase }}</td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen4[mat].volume"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen4[mat].brixPercent" ng-change="calculatePurity(rt7cEntry.screen4[mat])"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen4[mat].polPercent" ng-change="calculatePurity(rt7cEntry.screen4[mat])"></td>
                                        <td><input type="number" step="0.001" ng-model="rt7cEntry.screen4[mat].purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </div>

                <div class="action-bar">
                    <button type="button" class="btn-custom btn-save" ng-click="saveData('save')" ng-disabled="rt7EntryForm.$invalid">Save</button>
                    <button type="button" class="btn-custom btn-cancel" ng-click="clearForm()">Cancel / New</button>
                    <button type="button" class="btn-custom btn-find" ng-click="findData()">Find</button>
                    <button type="button" class="btn-custom btn-change" ng-click="saveData('update')">Change</button>
                    <button type="button" class="btn-custom btn-delete" ng-click="deleteData()">Delete</button>
                </div>

            </form>
        </div>
    </div>
</div>