<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="batchProcessApp">
<head>
    <meta charset="UTF-8">
    <title>Multiple Day Process</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/batchProcess.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 400px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 30px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; color: #333; }
        .action-btn:hover { background-color: #e2e6ea; }
        .input-label { font-size: 0.95rem; font-weight: bold; color: #333; }
        .process-box { background-color: rgba(255,255,255,0.6); border: 1px solid #999; border-radius: 5px; padding: 25px; }
    </style>
</head>
<body ng-controller="BatchProcessController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">MULTIPLE DAY PROCESS / BATCH EXECUTION</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2" ng-click="executeProcess()" ng-disabled="isProcessing">Execute Process</button>
                    <button type="button" class="btn action-btn" ng-click="resetForm()" ng-disabled="isProcessing">Cancel</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    <div class="w-75 mx-auto process-box shadow-sm">
                        <form name="batchForm" novalidate>
                            
                            <h5 class="text-center text-primary mb-4 border-bottom pb-2">Select Date Range for Processing</h5>

                            <div class="row mb-4 align-items-center justify-content-center">
                                <label class="col-sm-3 text-end input-label">From Date :</label>
                                <div class="col-sm-4">
                                    <input type="date" class="form-control form-control-sm" ng-model="processReq.fromDate" ng-disabled="isProcessing" required>
                                </div>
                            </div>
                            
                            <div class="row mb-4 align-items-center justify-content-center">
                                <label class="col-sm-3 text-end input-label">To Date :</label>
                                <div class="col-sm-4">
                                    <input type="date" class="form-control form-control-sm" ng-model="processReq.toDate" ng-disabled="isProcessing" required>
                                </div>
                            </div>

                            <div class="row mb-4 align-items-center justify-content-center">
                                <label class="col-sm-3 text-end input-label">Process Module :</label>
                                <div class="col-sm-6">
                                    <select class="form-select form-select-sm" ng-model="processReq.processModule" ng-disabled="isProcessing">
                                        <option value="ALL">All Daily Modules (Full Recalculation)</option>
                                        <option value="CRUSHING">Daily Crushing & Recovery</option>
                                        <option value="STOCK">Material Stock & Inventory</option>
                                        <option value="LOSSES">Losses & Analysis Calculations</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-5" ng-show="isProcessing">
                                <div class="col-12 text-center">
                                    <p class="mb-1 fw-bold text-dark">{{ statusMessage }}</p>
                                    <div class="progress" style="height: 20px;">
                                        <div class="progress-bar progress-bar-striped bg-success" 
                                             ng-class="{'progress-bar-animated': progressPercentage < 100}"
                                             role="progressbar" 
                                             ng-style="{ 'width': progressPercentage + '%' }">
                                             {{ progressPercentage }}%
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>