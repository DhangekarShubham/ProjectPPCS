<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="chemicalApp">
<head>
    <meta charset="UTF-8">
    <title>Chemical Consumption</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/chemicalConsumption.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 500px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); }
        .action-btn:hover { background-color: #e2e6ea; }
        .table-container { background-color: white; border: 1px solid #999; height: 350px; overflow-y: auto; }
        .table th { background-color: #f0f0f0; position: sticky; top: 0; }
        .table-striped tbody tr:nth-of-type(odd) { background-color: #e0ffff; }
    </style>
</head>
<body ng-controller="ChemicalController">
    <jsp:include page="includes/navbar.jsp" /> 

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">CHEMICAL CONSUMPTION</div>
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
                    <form name="chemForm" novalidate>
                        <div class="row mb-3 align-items-center">
                            <label class="col-auto fw-bold text-dark mb-0">Select Date:</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control form-control-sm border-secondary shadow-sm" ng-model="sampleDate" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-8">
                                <div class="table-container shadow-sm">
                                    <table class="table table-bordered table-sm table-striped mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 70%;">Chemical Name</th>
                                                <th style="width: 30%;">Volume</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="chem in chemicalList">
                                                <td class="fw-bold text-secondary">
                                                    <input type="hidden" ng-model="chem.materialId">
                                                    {{ chem.materialName }}
                                                </td>
                                                <td>
                                                    <input type="number" step="0.01" class="form-control form-control-sm bg-transparent border-0" ng-model="chem.volumeConsumed" placeholder="0.00">
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
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