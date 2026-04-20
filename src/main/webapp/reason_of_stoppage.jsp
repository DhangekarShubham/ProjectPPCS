<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="contentpanel" id="stoppage-panel" ng-controller="StoppageController">
    
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
        .info-badge {
            background-color: #fffbeb;
            border: 1px solid #fde68a;
            color: #92400e;
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 0.8rem;
        }
        .form-label-custom {
            font-size: 0.75rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .btn-erp { font-size: 13px; font-weight: 500; min-width: 110px; }
        .btn-save { background-color: #6593b4; color: white; border: none; }
        .btn-find { background-color: #e5a751; color: white; border: none; }
        
        .readonly-ref {
            background-color: #f8fafc !important;
            border-style: dashed !important;
            font-weight: bold;
            color: #2563eb;
        }
    </style>

    <div class="erp-form-container mt-3 mx-2 border">
        
        <div class="erp-form-header px-3 py-2">
            <i class="fa fa-exclamation-triangle me-2"></i> DOWNTIME LOG - REASON OF STOPPAGE
        </div>
       <!--  <h1>{{ 5 + 5 }}</h1> -->
        <form name="stoppageForm" class="p-4" novalidate>
            
            <div class="row mb-4 align-items-center bg-light p-3 border rounded mx-1 shadow-sm">
                <div class="col-md-6 d-flex align-items-center">
                    <label class="form-label-custom me-3" style="width: 140px;">Stoppage Ref No:</label>
                    <input type="text" class="form-control form-control-sm readonly-ref" 
                           style="max-width: 200px;" ng-model="stoppage.stoppageId" 
                           readonly placeholder="[SYSTEM GENERATED]">
                </div>
                
                <div class="col-md-6 d-flex align-items-center">
                    <label class="form-label-custom me-3" style="width: 140px;">Stoppage Date:<span class="text-danger">*</span></label>
                    <input type="date" class="form-control form-control-sm border-success" 
                           style="max-width: 200px;" ng-model="stoppage.stoppageDate" required>
                </div>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    
                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-3 text-end form-label-custom">Total Downtime (Hrs):<span class="text-danger">*</span></label>
                        <div class="col-sm-4">
                            <div class="input-group input-group-sm">
                                <input type="number" step="0.01" class="form-control border-success text-end fw-bold" 
                                       ng-model="stoppage.totalTime" placeholder="0.00" required>
                                <span class="input-group-text bg-light text-muted" style="font-size: 10px;">DECIMAL HR</span>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="info-badge">
                                <i class="fa fa-info-circle me-1"></i> Decimal hours (e.g. 1.25 = 1hr 15m)
                            </div>
                        </div>
                    </div>

                    <hr class="text-muted my-4 opacity-25">

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-3 text-end form-label-custom">Operational Category:</label>
                        <div class="col-sm-6">
                            <select class="form-select form-select-sm border-success" ng-model="stoppage.categoryCode">
                                <option value="" disabled>-- Select Downtime Category --</option>
                                <option value="MECHANICAL">Mechanical (Equipment Failure)</option>
                                <option value="ELECTRICAL">Electrical (Power/Motor Issue)</option>
                                <option value="PROCESS">Process (Cleaning/Boiling)</option>
                                <option value="CANE_SHORTAGE">Cane Supply Shortage</option>
                                <option value="RAIN">Weather / Rain Impact</option>
                                <option value="MISC">Miscellaneous</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-3 text-end form-label-custom">Reason (English):</label>
                        <div class="col-sm-9">
                            <div class="input-group input-group-sm">
                                <span class="input-group-text bg-light"><i class="fa fa-comment-o text-muted"></i></span>
                                <input type="text" class="form-control border-success" 
                                       ng-model="stoppage.reasonEng" placeholder="Describe the cause of stoppage...">
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-3 text-end form-label-custom">Reason (मराठीत):</label>
                        <div class="col-sm-9">
                            <div class="input-group input-group-sm">
                                <span class="input-group-text bg-light"><i class="fa fa-language text-muted"></i></span>
                                <input type="text" class="form-control border-success" 
                                       ng-model="stoppage.reasonMar" placeholder="येथे मराठीत कारण लिहा...">
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="row mt-4 mb-2 bg-light py-3 border-top">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-erp btn-save px-4 me-2" 
                            ng-click="saveData('save')" ng-disabled="stoppageForm.$invalid">
                        <i class="fa fa-save me-1"></i> Save Log
                    </button>
                    <button type="button" class="btn btn-erp btn-light border px-4 me-2" ng-click="clearForm()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
                    <button type="button" class="btn btn-erp btn-find px-4 text-white me-2" ng-click="findData()">
                        <i class="fa fa-search me-1"></i> Find Record
                    </button>
                  
                    
                    <button type="button" class="btn btn-erp btn-outline-secondary px-3 ms-2" 
                            ng-show="stoppage.stoppageId" ng-click="saveData('update')">
                        <i class="fa fa-edit me-1"></i> Change
                    </button>
                    <button type="button" class="btn btn-erp btn-outline-danger px-3 ms-2" 
                            ng-show="stoppage.stoppageId" ng-click="deleteData()">
                        <i class="fa fa-trash me-1"></i> Delete
                    </button>
                </div>
            </div>

        </form>
    </div>
</div>