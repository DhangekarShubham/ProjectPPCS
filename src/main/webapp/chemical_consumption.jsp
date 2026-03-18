<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="contentpanel" id="chemical-panel" ng-controller="ChemicalController">
    
    <style>
        .erp-form-container {
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 4px;
            margin-bottom: 30px;
        }
        .erp-form-header {
            background-color: #3bb4b4; 
            color: #ffffff; 
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
            border-bottom: 1px solid #33a0a0;
        }
        .table-sticky-header {
            height: 400px;
            overflow-y: auto;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
        }
        .table-sticky-header thead th {
            position: sticky;
            top: 0;
            background-color: #f8fafc;
            z-index: 10;
            border-bottom: 2px solid #cbd5e1;
            font-size: 11px;
            text-transform: uppercase;
            color: #475569;
        }
        .volume-input {
            text-align: right;
            font-weight: 600;
            color: #2563eb;
            border: 1px solid #d1d5db;
        }
        .volume-input:focus {
            background-color: #eff6ff;
            border-color: #3bb4b4;
            box-shadow: none;
        }
        /* Action Buttons */
        .btn-erp { font-size: 13px; font-weight: 500; min-width: 100px; }
        .btn-save { background-color: #6593b4; color: white; border: none; }
        .btn-find { background-color: #e5a751; color: white; border: none; }
    </style>

    <div class="erp-form-container mt-3 mx-2 border">
        
        <div class="erp-form-header px-3 py-2">
            <i class="fa fa-flask me-2"></i> DAILY CHEMICAL CONSUMPTION LOG
        </div>
        
        <form name="chemForm" class="p-4" novalidate>
            
            <div class="row mb-4 align-items-center bg-light p-3 border rounded mx-1 shadow-sm">
                <label class="col-sm-3 text-end text-muted small fw-bold text-uppercase">Consumption Date:<span class="text-danger">*</span></label>
                <div class="col-sm-3">
                    <input type="date" class="form-control form-control-sm border-success" ng-model="sampleDate" required>
                </div>
                <div class="col-sm-6 text-end text-muted small">
                    <span class="badge bg-info bg-opacity-10 text-info px-3 py-2 rounded-pill border border-info border-opacity-25" style="background-color: #f0f9ff; color: #0284c7; border: 1px solid #bae6fd;">
                        <i class="fa fa-info-circle me-1"></i> Data recorded in Metric Tons (MT)
                    </span>
                </div>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-md-11 col-lg-9">
                    
                    <div class="table-sticky-header shadow-sm bg-white">
                        <table class="table table-hover table-sm table-bordered mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-3 py-2">Chemical / Material Name</th>
                                    <th class="text-center py-2" style="width: 250px;">Volume Consumed</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="chem in chemicalList">
                                    <td class="align-middle fw-bold text-secondary small ps-3">
                                        <i class="fa fa-caret-right text-muted me-2"></i>
                                        {{ chem.materialName }}
                                    </td>
                                    <td class="pe-3 py-1">
                                        <div class="input-group input-group-sm">
                                            <input type="number" step="0.001" 
                                                   class="form-control volume-input" 
                                                   ng-model="chem.volumeConsumed" 
                                                   placeholder="0.000">
                                            <span class="input-group-text bg-light text-muted small" style="font-size: 10px;">{{chem.unitName || 'MT'}}</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="chemicalList.length == 0">
                                    <td colspan="2" class="text-center py-5 text-muted">
                                        <i class="fa fa-spinner fa-spin me-2"></i> Loading Chemical Master...
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row mt-4 mb-2 bg-light py-3 border-top">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-erp btn-save px-4 me-2" ng-click="saveData('save')" ng-disabled="chemForm.$invalid">
                        <i class="fa fa-save me-1"></i> Save Data
                    </button>
                    <button type="button" class="btn btn-erp btn-light border px-4 me-2" ng-click="clearForm()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
                    <button type="button" class="btn btn-erp btn-find px-4 me-2" ng-click="findData()">
                        <i class="fa fa-search me-1"></i> Find Record
                    </button>
                    
                    <button type="button" class="btn btn-erp btn-outline-secondary px-3 ms-2" ng-click="saveData('update')">
                        <i class="fa fa-edit me-1"></i> Change
                    </button>
                    <button type="button" class="btn btn-erp btn-outline-danger px-3 ms-2" ng-click="deleteData()">
                        <i class="fa fa-trash me-1"></i> Delete
                    </button>
                </div>
            </div>

        </form>
    </div>
</div>