<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="factoryApp">
<head>
    <meta charset="UTF-8">
    <title>Factory Information - Master</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/factory_information.js"></script>

    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); }
        .action-btn:hover { background-color: #e2e6ea; }
        .input-label { font-size: 0.85rem; font-weight: 500; color: #333; }
        .form-section { border: 1px solid #999; padding: 15px; border-radius: 4px; background-color: rgba(255,255,255,0.4); margin-bottom: 15px; }
    </style>
</head>
<body ng-controller="FactoryInfoController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">LAB FACTORY INFORMATION</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">New</button>
                    <button type="button" class="btn action-btn" ng-click="findFactory(factory.seasonYear)">Find</button>
                    <button type="button" class="btn action-btn" ng-click="updateFactory()">Change</button>
                    <button type="button" class="btn action-btn" ng-click="saveFactory()">Save</button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()">Cancel</button>
                    <button type="button" class="btn action-btn" ng-click="deleteFactory()">Delete</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    <form name="factoryForm" novalidate>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-section">
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Season Year</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.seasonYear" placeholder="e.g., 2025-2026" required></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Start Date</label>
                                        <div class="col-sm-4"><input type="date" class="form-control form-control-sm" ng-model="factory.startDate"></div>
                                        <label class="col-sm-2 text-end input-label">Start Time</label>
                                        <div class="col-sm-2"><input type="time" class="form-control form-control-sm" ng-model="factory.startTime"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Factory Name</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.factoryName"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Address</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.address"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Taluka</label>
                                        <div class="col-sm-3"><input type="text" class="form-control form-control-sm" ng-model="factory.taluka"></div>
                                        <label class="col-sm-2 text-end input-label">District</label>
                                        <div class="col-sm-3"><input type="text" class="form-control form-control-sm" ng-model="factory.district"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">State</label>
                                        <div class="col-sm-3"><input type="text" class="form-control form-control-sm" ng-model="factory.state"></div>
                                        <label class="col-sm-2 text-end input-label">PIN Code</label>
                                        <div class="col-sm-3"><input type="text" class="form-control form-control-sm" ng-model="factory.pinCode"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Phone No.</label>
                                        <div class="col-sm-3"><input type="text" class="form-control form-control-sm" ng-model="factory.phoneNo"></div>
                                        <label class="col-sm-2 text-end input-label">STD Code</label>
                                        <div class="col-sm-3"><input type="text" class="form-control form-control-sm" ng-model="factory.stdCode"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">E-Mail</label>
                                        <div class="col-sm-8"><input type="email" class="form-control form-control-sm" ng-model="factory.email"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Website</label>
                                        <div class="col-sm-8"><input type="url" class="form-control form-control-sm" ng-model="factory.website"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-section">
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Clarification Process</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.clarificationProcess"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Registration No</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.registrationNo"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">GST No.</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.gstNo"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">FSSAI No.</label>
                                        <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.fssaiNo"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Commission Rate</label>
                                        <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" ng-model="factory.commissionRate"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Division</label>
                                        <div class="col-sm-5"><input type="text" class="form-control form-control-sm" ng-model="factory.division"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Range</label>
                                        <div class="col-sm-5"><input type="text" class="form-control form-control-sm" ng-model="factory.range"></div>
                                    </div>
                                    <div class="row mb-2 align-items-center">
                                        <label class="col-sm-4 text-end input-label">Installed Capacity</label>
                                        <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" ng-model="factory.installedCapacity"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-1">
                            <div class="col-12">
                                <div class="form-section pb-1">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-4 text-end input-label">Managing Director</label>
                                                <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.managingDirector"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-4 text-end input-label">Chief Chemist</label>
                                                <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.chiefChemist"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-4 text-end input-label">Works Manager</label>
                                                <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.worksManager"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-4 text-end input-label">Lab Incharge</label>
                                                <div class="col-sm-8"><input type="text" class="form-control form-control-sm" ng-model="factory.labIncharge"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3 mb-2 align-items-center bg-white p-3 border rounded mx-1 shadow-sm">
                            <div class="col-md-5 text-end">
                                <label class="fw-bold me-2 text-dark">Enter Season Year</label>
                                <input type="text" class="form-control form-control-sm d-inline-block" style="width: 150px;" ng-model="searchSeasonYear">
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-light border fw-bold px-4 shadow-sm w-100" ng-click="findFactory(searchSeasonYear)">Find</button>
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