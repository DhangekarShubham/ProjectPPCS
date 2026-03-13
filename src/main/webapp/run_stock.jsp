<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="runStockApp">
<head>
    <meta charset="UTF-8">
    <title>Run Stock Entry</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/runStock.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 500px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); }
        .action-btn:hover { background-color: #e2e6ea; }
        
        .table-container { background-color: white; border: 1px solid #999; height: 380px; overflow-y: auto; margin-bottom: 15px; }
        .table th { background-color: #f0f0f0; position: sticky; top: 0; font-size: 0.85rem; z-index: 1; padding: 6px; border-bottom: 2px solid #999; }
        .table td { padding: 4px; font-size: 0.85rem; vertical-align: middle; }
        .table-striped tbody tr:nth-of-type(odd) { background-color: #e0ffff; }
        .input-grid { width: 100%; border: none; background-color: transparent; outline: none; padding: 2px 4px; }
        .input-grid:focus { background-color: #fffacd; border: 1px solid #000; }
    </style>
</head>
<body ng-controller="RunStockController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">RUN STOCK</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">New</button>
                    <button type="button" class="btn action-btn" ng-click="findData()">Find</button>
                    <button type="button" class="btn action-btn" ng-click="saveData('update')">Change</button>
                    <button type="button" class="btn action-btn" ng-click="saveData('save')">Save</button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()">Cancel</button>
                    <button type="button" class="btn action-btn" ng-click="deleteData()">Delete</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    <form name="runStockForm" novalidate>
                        
                        <div class="row mb-3 align-items-center bg-white p-2 border rounded shadow-sm mx-0" style="max-width: 300px;">
                            <label class="col-auto fw-bold text-dark mb-0">Sample Date:</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm border-secondary" ng-model="sampleDate" required>
                            </div>
                        </div>

                        <div class="table-container shadow-sm">
                            <table class="table table-bordered table-striped mb-0">
                                <thead>
                                    <tr>
                                        <th style="width: 30%;">Material Name</th>
                                        <th style="width: 15%;">Volume (HL)</th>
                                        <th style="width: 15%;">Sp. Gravity</th>
                                        <th style="width: 13%;">Brix %</th>
                                        <th style="width: 13%;">Pol %</th>
                                        <th style="width: 14%;">Purity %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="item in stockList">
                                        <td class="fw-bold text-secondary">
                                            <input type="hidden" ng-model="item.materialId">
                                            {{item.materialName}}
                                        </td>
                                        <td><input type="number" step="0.01" class="input-grid" ng-model="item.volume"></td>
                                        <td><input type="number" step="0.01" class="input-grid" ng-model="item.spGravity"></td>
                                        
                                        <td><input type="number" step="0.01" class="input-grid" ng-model="item.brixPercent" ng-change="calculatePurity(item)"></td>
                                        <td><input type="number" step="0.01" class="input-grid" ng-model="item.polPercent" ng-change="calculatePurity(item)"></td>
                                        
                                        <td><input type="number" step="0.01" class="input-grid fw-bold text-danger bg-light" ng-model="item.purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>