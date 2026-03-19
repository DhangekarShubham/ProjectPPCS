<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Run Stock Entry</title>
</head>
<body>

    <div class="contentpanel" ng-controller="RunStockController">
        
        <link href="css/forms.css" rel="stylesheet">
        <script src="js/runStock.js"></script>

        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded">
            
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                <i class="fa fa-tint me-2"></i> RUN Stock : Screen No.1
            </div>
            
            <form name="runStockForm" class="p-4" novalidate>
                
                <div class="row mb-4 align-items-center bg-light p-3 border rounded mx-1 shadow-sm">
                    <div class="col-md-2">
                        <label class="text-muted small fw-bold text-uppercase d-block mb-1 text-center">Run Number</label>
                        <input type="text" class="form-control form-control-sm border-primary text-center fw-bold" ng-model="header.runNumber" required>
                    </div>
                    <div class="col-md-2">
                        <label class="text-muted small fw-bold text-uppercase d-block mb-1 text-center">Season Year</label>
                        <input type="text" class="form-control form-control-sm text-center text-primary fw-bold" ng-model="header.seasonYear" placeholder="Emter Season Year" required>
                    </div>
                    <div class="col-md-2">
                        <label class="text-muted small fw-bold text-uppercase d-block mb-1 text-center">Start Date</label>
                        <input type="date" class="form-control form-control-sm" ng-model="header.startDate">
                    </div>
                    <div class="col-md-2">
                        <label class="text-muted small fw-bold text-uppercase d-block mb-1 text-center">End Date</label>
                        <input type="date" class="form-control form-control-sm" ng-model="header.endDate">
                    </div>
                    <div class="col-md-2">
                        <label class="text-muted small fw-bold text-uppercase d-block mb-1 text-center">Stock Date<span class="text-danger">*</span></label>
                        <input type="date" class="form-control form-control-sm border-success" ng-model="header.stockDate" required>
                    </div>
                    <div class="col-md-2">
                        <label class="text-muted small fw-bold text-uppercase d-block mb-1 text-center">Actual Date</label>
                        <input type="date" class="form-control form-control-sm" ng-model="header.actualDate">
                    </div>
                </div>
                
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="table-responsive shadow-sm border rounded bg-white" style="height: 420px; overflow-y: auto;">
                            <table class="table table-hover table-sm table-bordered mb-0">
                                <thead class="bg-light" style="position: sticky; top: 0; z-index: 10;">
                                    <tr>
                                        <th class="text-muted small text-uppercase" style="width: 28%; background-color: #f8fafc; padding-left: 15px;">Material Name</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%; background-color: #f8fafc;">Volume (HL)</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%; background-color: #f8fafc;">Brix %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%; background-color: #f8fafc;">Pol %</th>
                                        <th class="text-muted small text-uppercase text-center" style="width: 18%; background-color: #f8fafc;">Purity %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="item in stockList">
                                        <td class="align-middle fw-bold text-secondary small ps-3">
                                            <input type="hidden" ng-model="item.materialId">
                                            <i class="fa fa-flask text-primary me-2 small"></i>
                                            {{item.materialName}}
                                        </td>
                                        <td class="px-2"><input type="number" step="any" class="form-control form-control-sm text-end" ng-model="item.volume" placeholder="0.00"></td>
                                        
                                        <td class="px-2"><input type="number" step="any" class="form-control form-control-sm text-end" ng-model="item.brixPercent" ng-change="calculatePurity(item)" placeholder="0.00"></td>
                                        <td class="px-2"><input type="number" step="any" class="form-control form-control-sm text-end" ng-model="item.polPercent" ng-change="calculatePurity(item)" placeholder="0.00"></td>
                                        
                                        <td class="px-2"><input type="number" step="any" class="form-control form-control-sm text-end bg-light text-danger fw-bold border-0 border-bottom" style="cursor: not-allowed;" ng-model="item.purityPercent" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="mt-2 text-end text-muted small fst-italic">
                            <i class="fa fa-info-circle me-1 text-primary"></i> Purity % is auto-calculated as (Pol / Brix) * 100.
                        </div>
                    </div>
                </div>

                <div class="row mt-4 align-items-center p-3 border rounded mx-1 shadow-sm" style="background-color: #fffbeb; border-color: #fde68a;">
                    <div class="col-md-4 d-flex align-items-center">
                         <label class="text-end fw-bold small text-dark me-2 mb-0" style="width: 140px;">Enter Season Year:</label>
                         <input type="text" class="form-control form-control-sm border-warning" ng-model="search.seasonYear" placeholder="e.g. 2018-2019" style="max-width: 150px;">
                    </div>
                    <div class="col-md-4 d-flex align-items-center">
                         <label class="text-end fw-bold small text-dark me-2 mb-0" style="width: 140px;">Enter Run Number:</label>
                         <input type="text" class="form-control form-control-sm border-warning" ng-model="search.runNumber" style="max-width: 150px;">
                    </div>
                    <div class="col-md-2">
                         <button type="button" class="btn btn-sm btn-secondary fw-bold px-4 shadow-sm" ng-click="findDataBySearch()">Ok</button>
                    </div>
                </div>

                <div class="row mt-3 mb-2 bg-light py-3 border-top">
                    <div class="col-12 text-center">
                        <button type="button" class="btn btn-primary px-4 me-2" ng-click="saveData('save')" style="background-color: #6593b4; border: none;">Save Entry</button>                        
                        <button type="button" class="btn btn-light px-4 border me-2" ng-click="clearForm()">Cancel / Reset</button>
                        
                        <button type="button" class="btn btn-outline-secondary px-3 ms-2" ng-click="saveData('update')">Change (Update)</button>
                        <button type="button" class="btn btn-outline-danger px-3 ms-2" ng-click="deleteData()">Delete</button>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>
</html>