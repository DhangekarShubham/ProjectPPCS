<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="contentpanel" id="stock-panel" ng-controller="StockController">
    
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
            height: 450px;
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
        .stock-input-field {
            text-align: right;
            font-weight: 600;
            color: #2563eb;
            border: 1px solid #d1d5db;
        }
        .stock-input-field:focus {
            background-color: #eff6ff;
            border-color: #3bb4b4;
            box-shadow: none;
        }
        .stock-input-field[readonly] {
            background-color: #f8fafc;
            color: #cbd5e1;
            border-style: dashed;
        }
        /* Action Buttons */
        .btn-erp { font-size: 13px; font-weight: 500; min-width: 110px; }
        .btn-save { background-color: #6593b4; color: white; border: none; }
        .btn-find { background-color: #e5a751; color: white; border: none; }
    </style>

    <div class="erp-form-container mt-3 mx-2 border">
        
        <div class="erp-form-header px-3 py-2">
            <i class="fa fa-cubes me-2"></i> MATERIAL INVENTORY & STOCK ENTRY
        </div>
        
        <form name="stockForm" class="p-4" novalidate>
            
            <div class="row mb-4 align-items-center bg-light p-3 border rounded mx-1 shadow-sm">
                <label class="col-sm-3 text-end text-muted small fw-bold text-uppercase">Stock Valuation Date:<span class="text-danger">*</span></label>
                <div class="col-sm-3">
                    <input type="date" class="form-control form-control-sm border-success" ng-model="sampleDate" required>
                </div>
                <div class="col-sm-6 text-end text-muted small">
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill border border-primary border-opacity-25" style="background-color: #f0f9ff; color: #0284c7; border: 1px solid #bae6fd;">
                        <i class="fa fa-info-circle me-1"></i> Physical ledger verification recommended
                    </span>
                </div>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    
                    <div class="table-sticky-header shadow-sm bg-white">
                        <table class="table table-hover table-sm table-bordered mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-3 py-2">Material / Product Name</th>
                                    <th class="text-center py-2" style="width: 25%;">Quantity (Qtls)</th>
                                    <th class="text-center py-2" style="width: 25%;">Volume (HL)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="item in stockList">
                                    <td class="align-middle fw-bold text-secondary small ps-3">
                                        <i class="fa fa-tag text-muted me-2 small"></i>
                                        {{ item.materialName }}
                                    </td>
                                    <td class="px-3 py-1">
                                        <input type="number" step="0.01" 
                                               class="form-control form-control-sm stock-input-field" 
                                               ng-model="item.quantity" 
                                               ng-readonly="item.materialName.includes('Volume')"
                                               placeholder="{{ item.materialName.includes('Volume') ? '—' : '0.00' }}">
                                    </td>
                                    <td class="px-3 py-1">
                                        <input type="number" step="0.01" 
                                               class="form-control form-control-sm stock-input-field" 
                                               ng-model="item.volume" 
                                               placeholder="0.00">
                                    </td>
                                </tr>
                                <tr ng-if="stockList.length == 0">
                                    <td colspan="3" class="text-center py-5 text-muted">
                                        <i class="fa fa-spinner fa-spin me-2"></i> Loading Material Master...
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="mt-3 p-2 bg-light rounded border d-flex align-items-center">
                        <i class="fa fa-shield text-success fs-5 me-3 ms-2"></i>
                        <span class="small text-secondary">
                            <strong>Validation:</strong> Qtls for solids (Sugar/Bags), HL for liquids (Juice/Molasses).
                        </span>
                    </div>
                </div>
            </div>

            <div class="row mt-4 mb-2 bg-light py-3 border-top">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-erp btn-save px-4 me-2" ng-click="saveData('save')" ng-disabled="stockForm.$invalid">
                        <i class="fa fa-save me-1"></i> Save Stock
                    </button>
                    <button type="button" class="btn btn-erp btn-light border px-4 me-2" ng-click="clearForm()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
                    <button type="button" class="btn btn-erp btn-find px-4 text-white me-2" ng-click="findData()">
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