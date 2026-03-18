<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="contentpanel" id="crushing-panel" ng-controller="CrushingController">
    
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
        .label-right {
            text-align: right; font-size: 13px; color: #444; padding-top: 5px; font-weight: 600;
        }
        
        /* Action Buttons */
        .btn { font-size: 13px; font-weight: 500; border-radius: 3px; }
        .btn-erp-submit { background-color: #6593b4; color: white; min-width: 120px; border: none; }
        .btn-erp-reset { background-color: #ffffff; color: #333; min-width: 120px; border: 1px solid #ccc; }
        .btn-erp-view { background-color: #e5a751; color: white; min-width: 120px; border: none; }
        .btn-erp-submit:hover, .btn-erp-view:hover { opacity: 0.9; color: white; }
        .btn-erp-reset:hover { background-color: #f0f0f0; }
        
        .calc-field { background-color: #f8f9fa !important; border-style: dashed; color: #0056b3; font-weight: bold; }
    </style>

    <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded">
        
        <div class="erp-form-header px-3 py-2 fw-bold text-uppercase">
            <i class="fa fa-tachometer me-2"></i> DAILY CRUSHING DATA
        </div>
        
        <form name="crushForm" class="p-4" novalidate>
            
            <div class="row mb-4 align-items-center justify-content-center">
                <div class="col-md-5 d-flex align-items-center mb-2">
                    <label class="label-right text-uppercase me-3" style="width: 140px;">Crushing Date:<span class="text-danger">*</span></label>
                    <input type="text" class="form-control form-control-sm border-success" 
                           style="max-width: 200px;" 
                           placeholder="YYYY-MM-DD"
                           onfocus="(this.type='date')" onblur="(this.type='text')"
                           ng-model="crushing.crushDate" required>
                </div>
                <div class="col-md-5 d-flex align-items-center mb-2">
                    <label class="label-right text-uppercase me-3" style="width: 140px;">Crop Day:<span class="text-danger">*</span></label>
                    <input type="number" class="form-control form-control-sm border-success" style="max-width: 200px;" ng-model="crushing.cropDay" required>
                </div>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    
                    <div class="row mb-3 border-bottom pb-2 bg-white">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-4 text-center text-primary small fw-bold text-uppercase">On Date</div>
                        <div class="col-sm-4 text-center text-primary small fw-bold text-uppercase">To Date</div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Cane Crushing:</label>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.001" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.caneOnDate" placeholder="0.000">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.001" class="form-control form-control-sm text-end calc-field" ng-model="crushing.caneToDate" readonly>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Sugar Production:</label>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.001" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.sugarOnDate" placeholder="0.000">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.001" class="form-control form-control-sm text-end calc-field" ng-model="crushing.sugarToDate" readonly>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Avg Sugar Percentage:</label>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.percentOnDate" placeholder="0.00">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end calc-field" ng-model="crushing.percentToDate" readonly>
                        </div>
                    </div>
                    
                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Mill Extraction Percentage:</label>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.millExtOnDate" placeholder="0.00">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end calc-field" ng-model="crushing.millExtToDate" readonly>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Reduced Mill Extraction:</label>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.reducedExtOnDate" placeholder="0.00">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end calc-field" ng-model="crushing.reducedExtToDate" readonly>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Mill Start:</label>
                        <div class="col-sm-4 px-3">
                            <input type="text" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.millStartOnDate">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="text" class="form-control form-control-sm text-end calc-field" ng-model="crushing.millStartToDate" readonly>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 label-right">Co-Generation (15MW) Export:</label>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end border-success fw-bold" ng-model="crushing.cogenOnDate" placeholder="0.00">
                        </div>
                        <div class="col-sm-4 px-3">
                            <input type="number" step="0.01" class="form-control form-control-sm text-end calc-field" ng-model="crushing.cogenToDate" readonly>
                        </div>
                    </div>

                </div>
            </div>

            <div class="row mt-4 mb-2 bg-light py-3 border-top">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-erp-submit me-2" ng-click="saveData('save')" ng-disabled="crushForm.$invalid">Save</button>
                    <button type="button" class="btn btn-erp-reset me-2" ng-click="clearForm()">Cancel</button>
                    <button type="button" class="btn btn-erp-view" ng-click="showFindBar = !showFindBar">Find</button>
                    
                    <button type="button" class="btn btn-outline-secondary px-3 ms-2" ng-click="saveData('update')">Change</button>
                    <button type="button" class="btn btn-outline-danger px-3 ms-2" ng-click="deleteData()">Delete</button>
                </div>
            </div>
            
            <div class="row mt-3 justify-content-center" ng-show="showFindBar">
                <div class="col-md-6 d-flex align-items-center bg-white p-3 border rounded shadow-sm">
                    <label class="fw-bold me-3 text-nowrap" style="font-size: 13px; color: #b22222;">Enter Crushing Date:</label>
                    <input type="text" class="form-control form-control-sm me-3 border-info" 
                           onfocus="(this.type='date')" onblur="(this.type='text')"
                           ng-model="crushing.crushDate" placeholder="DD/MM/YYYY">
                    <button type="button" class="btn btn-sm text-white px-4 fw-bold" style="background-color: #6593b4;" ng-click="findData()">Ok</button>
                </div>
            </div>

        </form>
    </div>
</div>