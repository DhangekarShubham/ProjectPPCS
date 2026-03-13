<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="stoppageApp">
<head>
    <meta charset="UTF-8">
    <title>Reason of Stoppage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/stoppageReason.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 500px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 30px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); }
        .action-btn:hover { background-color: #e2e6ea; }
        .input-label { font-size: 0.9rem; font-weight: 500; color: #333; }
    </style>
</head>
<body ng-controller="StoppageController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <div class="row app-window mx-2">
            <div class="window-header">REASON OF STOPPAGE</div>
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
                    <form name="stoppageForm" novalidate class="w-75">
                        
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 text-end input-label">Stoppage Number</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control form-control-sm bg-light fw-bold" ng-model="stoppage.stoppageId" readonly placeholder="Auto Generated">
                            </div>
                        </div>
                        
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 text-end input-label">Stoppage Date</label>
                            <div class="col-sm-4">
                                <input type="date" class="form-control form-control-sm border-secondary" ng-model="stoppage.stoppageDate" required>
                            </div>
                        </div>
                        
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 text-end input-label">Total Time</label>
                            <div class="col-sm-4">
                                <input type="number" step="0.01" class="form-control form-control-sm border-secondary" ng-model="stoppage.totalTime" placeholder="e.g. 1.25">
                            </div>
                            <div class="col-sm-3 input-label text-dark fst-italic">(Decimal Hours)</div>
                        </div>
                        
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 text-end input-label">Reason (English)</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control form-control-sm" ng-model="stoppage.reasonEng" placeholder="e.g., Donally Chute Jam">
                            </div>
                        </div>
                        
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 text-end input-label">Reason (Marathi)</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control form-control-sm" ng-model="stoppage.reasonMar" placeholder="मराठी कारण">
                            </div>
                        </div>
                        
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 text-end input-label">Stoppage Category</label>
                            <div class="col-sm-5">
                                <select class="form-select form-select-sm border-secondary" ng-model="stoppage.categoryCode">
                                    <option value="MECHANICAL">Mechanical (Hours Lost)</option>
                                    <option value="ELECTRICAL">Electrical (Hours Lost)</option>
                                    <option value="PROCESS">Process (Evaporator Cleaning, etc)</option>
                                    <option value="CANE_SHORTAGE">Cane Shortage</option>
                                    <option value="RAIN">Rain</option>
                                    <option value="MISC">Miscellaneous</option>
                                </select>
                            </div>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>