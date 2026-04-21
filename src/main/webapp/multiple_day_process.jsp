<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="contentpanel ng-cloak" ng-controller="BatchProcessController">
    <style>
        .batch-wrapper { 
            background-color: #f5f7fa; 
            padding: 30px 20px 60px 20px; 
            font-family: 'Inter', sans-serif; 
            min-height: 80vh;
        }
        
        .custom-panel { 
            background-color: #ffffff; 
            border-radius: 6px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); 
            border: 1px solid #e9ecef; 
            margin: 0 auto; 
            max-width: 750px; /* Centered compact layout */
        }
        
        .panel-heading-custom { 
            background-color: #48b3b3; /* Matched Sugar ERP Theme */
            color: #ffffff; 
            font-size: 15px; 
            font-weight: 700; 
            padding: 15px 20px; 
            letter-spacing: 0.5px; 
            border-top-left-radius: 5px; 
            border-top-right-radius: 5px; 
            text-transform: uppercase; 
        }
        
        .form-content { 
            padding: 30px 40px; 
        }
        
        .input-label { 
            color: #555; 
            font-weight: 700; 
            font-size: 12px; 
            text-transform: uppercase; 
            margin-bottom: 8px; 
            display: block; 
            letter-spacing: 0.5px; 
        }
        
        .custom-input, .custom-select { 
            border: 1px solid #ced4da; 
            border-radius: 4px; 
            padding: 10px 15px; 
            font-size: 14px; 
            width: 100%; 
            transition: all 0.2s ease; 
            font-weight: 600; 
            color: #333; 
            background-color: #fff;
        }
        
        .custom-input:focus, .custom-select:focus { 
            outline: none; 
            border-color: #48b3b3; 
            box-shadow: 0 0 5px rgba(72, 179, 179, 0.4); 
        }
        
        .action-bar { 
            background-color: #f8f9fa; 
            padding: 20px; 
            border-top: 1px solid #e9ecef; 
            text-align: center; 
            border-bottom-left-radius: 5px; 
            border-bottom-right-radius: 5px; 
        }
        
        .btn-custom { 
            font-size: 13px; 
            font-weight: 700; 
            padding: 10px 28px; 
            border-radius: 4px; 
            margin: 0 8px; 
            cursor: pointer; 
            transition: all 0.2s ease; 
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
        }
        
        .btn-custom:hover { opacity: 0.9; transform: translateY(-1px); }
        .btn-run { background-color: #48b3b3; color: white; border: none; box-shadow: 0 2px 5px rgba(72, 179, 179, 0.3); }
        .btn-run:disabled { background-color: #a0d8d8; cursor: not-allowed; transform: none; box-shadow: none; }
        .btn-cancel { background-color: #ffffff; color: #555; border: 1px solid #ced4da; }
        
        /* Modern Progress Bar */
        .progress-container { 
            background-color: #f8f9fa; 
            border: 1px solid #e9ecef; 
            border-radius: 6px; 
            padding: 20px; 
            margin-top: 30px; 
        }
        
        .progress { 
            height: 12px; 
            border-radius: 10px; 
            background-color: #e2e8f0; 
            overflow: hidden; 
            margin-top: 12px; 
        }
        
        .progress-bar { 
            background-color: #48b3b3; 
            transition: width 0.4s ease; 
        }
        
        .status-text { font-size: 13px; font-weight: 700; color: #48b3b3; text-transform: uppercase; }
        .percentage-text { font-size: 15px; font-weight: 800; color: #1e293b; }
        
        .warning-box { 
            background-color: #fff3cd; 
            border-left: 4px solid #ffc107; 
            padding: 12px 15px; 
            border-radius: 4px; 
            font-size: 12px; 
            font-weight: 600; 
            color: #856404; 
            margin-top: 25px; 
            letter-spacing: 0.3px;
        }

        [ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak { display: none !important; }
    </style>

    <div class="batch-wrapper">
        <div class="mb-4 text-center">
            <h4 class="fw-bold" style="color: #1e293b; letter-spacing: 0.5px;">SYSTEM ENGINE</h4>
            <p class="text-muted small fw-bold">MULTIPLE DAY BATCH RECALCULATION PROCESS</p>
        </div>

        <div class="custom-panel">
            <div class="panel-heading-custom">
                <i class="fa fa-cogs me-2"></i> Batch Execution Setup
            </div>
            
            <form name="batchForm" novalidate>
                <div class="form-content">
                    
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <label class="input-label">From Date</label>
                            <input type="date" class="custom-input" ng-model="processReq.fromDate" ng-disabled="isProcessing" required>
                        </div>
                        <div class="col-md-6">
                            <label class="input-label">To Date</label>
                            <input type="date" class="custom-input" ng-model="processReq.toDate" ng-disabled="isProcessing" required>
                        </div>
                    </div>
                    
                    <div class="mb-2">
                        <label class="input-label">Select Processing Module</label>
                        <select class="custom-select" ng-model="processReq.processModule" ng-disabled="isProcessing">
                            <option value="ALL">Full Recalculation (Global Update)</option>
                            <option value="CRUSHING">Daily Crushing & Recovery Logs</option>
                            <option value="STOCK">Inventory & Material Valuation</option>
                            <option value="LOSSES">Technical Analysis & Losses</option>
                        </select>
                    </div>

                    <div class="warning-box" ng-if="!isProcessing">
                        <i class="fa fa-exclamation-triangle me-2"></i>
                        Note: Running "Full Recalculation" may take several minutes depending on the date range. Please do not close the browser while processing.
                    </div>

                    <div class="progress-container" ng-show="isProcessing || progressPercentage > 0">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="status-text">
                                <i class="fa fa-spinner fa-spin me-2" ng-show="isProcessing"></i> 
                                {{ statusMessage || 'Initializing Process...' }}
                            </span>
                            <span class="percentage-text">{{ progressPercentage || 0 }}%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped progress-bar-animated" 
                                 role="progressbar" 
                                 ng-style="{ 'width': progressPercentage + '%' }">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="action-bar">
                    <button type="button" class="btn-custom btn-run" ng-click="executeProcess()" ng-disabled="isProcessing || batchForm.$invalid">
                        <i class="fa fa-play-circle me-1"></i> Run Process
                    </button>
                    <button type="button" class="btn-custom btn-cancel" ng-click="resetForm()" ng-disabled="isProcessing">
                        <i class="fa fa-times-circle me-1"></i> Cancel / Reset
                    </button>
                </div>
                
            </form>
        </div>
    </div>
</div>