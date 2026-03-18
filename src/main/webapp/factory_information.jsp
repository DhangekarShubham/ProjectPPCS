<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="factoryApp">
<head>
    <meta charset="UTF-8">
    <title>Factory Information</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/factory_information.js"></script>
    
    <link href="css/forms.css" rel="stylesheet">
</head>
<body>

    <div class="contentpanel" id="factory-panel" ng-controller="FactoryInfoController">
        
        <style>
            body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
            .erp-form-container { background-color: #ffffff; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 4px; margin-bottom: 30px; overflow: hidden; }
            .erp-form-header { background-color: #e0e0e0; color: #b22222; padding: 10px 20px; font-size: 14px; font-weight: bold; text-transform: uppercase; border-bottom: 1px solid #c0c0c0; letter-spacing: 0.5px; }
            .erp-form-body { padding: 20px; }
            .label-right { text-align: right; font-size: 13px; color: #444; padding-top: 5px; font-weight: 600; }
            .required-asterisk { color: #dc3545; margin-left: 2px; }
            .form-control-sm { font-size: 13px; border-radius: 2px; }
            .border-success { border-color: #28a745 !important; }
            .border-danger { border-color: #dc3545 !important; background-color: #fff8f8; }
            .input-filled { border-color: #28a745 !important; background-color: #f4fdf6 !important; box-shadow: 0 0 0 0.1rem rgba(40, 167, 69, 0.15) !important; }
            .input-filled-icon { position: absolute; right: 25px; top: 50%; transform: translateY(-50%); color: #28a745; font-size: 12px; pointer-events: none; }
            .validation-container { position: relative; display: flex; align-items: center; }
            .error-text { color: #dc3545; font-size: 11px; margin-top: 2px; display: block; }
            .erp-btn-container { text-align: center; padding: 20px 0; border-top: 1px solid #eee; background-color: #fafafa; }
            .btn { font-size: 13px; font-weight: 500; border-radius: 3px; }
            .btn-erp-submit { background-color: #6593b4; color: white; min-width: 120px; border: none; }
            .btn-erp-reset { background-color: #ffffff; color: #333; min-width: 120px; border: 1px solid #ccc; }
            .btn-erp-view { background-color: #e5a751; color: white; min-width: 120px; border: none; }
            .btn-erp-submit:hover, .btn-erp-view:hover { opacity: 0.9; color: white; }
            .btn-erp-reset:hover { background-color: #f0f0f0; }
        </style>

        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded">
            
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                LAB FACTORY INFORMATION
            </div>
            
            <form name="factoryForm" class="p-4 erp-form-body" novalidate>
                
                <div class="row">
                    <div class="col-md-6 pe-md-4">
                        
                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Season Year<span class="required-asterisk">*</span>:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" name="seasonYear" class="form-control form-control-sm" 
                                       ng-model="factory.seasonYear" 
                                       ng-class="{'input-filled': factory.seasonYear}" 
                                       placeholder="e.g., 2025-2026" required>
                                <i class="fa fa-check input-filled-icon" ng-show="factory.seasonYear"></i>
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Start Date & Time:</label>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       placeholder="YYYY-MM-DD"
                                       onfocus="(this.type='date')" onblur="(this.type='text')"
                                       ng-model="factory.startDate" 
                                       ng-class="{'input-filled': factory.startDate}">
                            </div>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       placeholder="HH:MM"
                                       onfocus="(this.type='time')" onblur="(this.type='text')"
                                       ng-model="factory.startTime" 
                                       ng-class="{'input-filled': factory.startTime}">
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Factory Name<span class="required-asterisk">*</span>:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" name="factoryName" class="form-control form-control-sm" 
                                       ng-model="factory.factoryName" 
                                       ng-class="{'input-filled': factory.factoryName}" required>
                                <i class="fa fa-check input-filled-icon" ng-show="factory.factoryName"></i>
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Address:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.address" 
                                       ng-class="{'input-filled': factory.address}">
                                <i class="fa fa-check input-filled-icon" ng-show="factory.address"></i>
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Taluka / District:</label>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" placeholder="Taluka" 
                                       ng-model="factory.taluka" ng-class="{'input-filled': factory.taluka}">
                            </div>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" placeholder="District" 
                                       ng-model="factory.district" ng-class="{'input-filled': factory.district}">
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">State / PIN Code:</label>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" placeholder="State" 
                                       ng-model="factory.state" ng-class="{'input-filled': factory.state}">
                            </div>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" placeholder="PIN Code" 
                                       ng-model="factory.pinCode" ng-class="{'input-filled': factory.pinCode}">
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">E-Mail:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="email" class="form-control form-control-sm" 
                                       ng-model="factory.email" ng-class="{'input-filled': factory.email}">
                                <i class="fa fa-check input-filled-icon" ng-show="factory.email"></i>
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Website:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="url" class="form-control form-control-sm" 
                                       ng-model="factory.website" ng-class="{'input-filled': factory.website}">
                                <i class="fa fa-check input-filled-icon" ng-show="factory.website"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 ps-md-4 border-start">
                        
                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Clarification Process:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.clarificationProcess" ng-class="{'input-filled': factory.clarificationProcess}">
                                <i class="fa fa-check input-filled-icon" ng-show="factory.clarificationProcess"></i>
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Registration No:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.registrationNo" ng-class="{'input-filled': factory.registrationNo}">
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">GST No<span class="required-asterisk">*</span>:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" name="gstNo" class="form-control form-control-sm" 
                                       ng-model="factory.gstNo" ng-class="{'input-filled': factory.gstNo}" required>
                                <i class="fa fa-check input-filled-icon" ng-show="factory.gstNo"></i>
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Division / Range:</label>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" placeholder="Division" 
                                       ng-model="factory.division" ng-class="{'input-filled': factory.division}">
                            </div>
                            <div class="col-sm-4 position-relative">
                                <input type="text" class="form-control form-control-sm" placeholder="Range" 
                                       ng-model="factory.range" ng-class="{'input-filled': factory.range}">
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Installed Capacity:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="number" step="0.01" class="form-control form-control-sm" 
                                       ng-model="factory.installedCapacity" ng-class="{'input-filled': factory.installedCapacity != null}">
                            </div>
                        </div>

                        <hr class="text-muted mt-4 mb-3">
                        <h6 class="text-center text-muted text-uppercase mb-3" style="font-size: 12px; font-weight: bold;">Key Personnel</h6>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Managing Director:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.managingDirector" ng-class="{'input-filled': factory.managingDirector}">
                            </div>
                        </div>
                        
                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Works Manager:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.worksManager" ng-class="{'input-filled': factory.worksManager}">
                            </div>
                        </div>

                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Chief Chemist:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.chiefChemist" ng-class="{'input-filled': factory.chiefChemist}">
                            </div>
                        </div>
                        
                        <div class="row mb-2 align-items-center">
                            <label class="col-sm-4 label-right">Lab Incharge:</label>
                            <div class="col-sm-8 position-relative">
                                <input type="text" class="form-control form-control-sm" 
                                       ng-model="factory.labIncharge" ng-class="{'input-filled': factory.labIncharge}">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="erp-btn-container mt-4 pt-3 border-top text-center bg-light">
                    <button type="button" class="btn btn-erp-submit me-2" ng-click="saveFactory()" ng-disabled="factoryForm.$invalid">
                        <i class="fa fa-save me-1"></i> Save
                    </button>
                    <button type="button" class="btn btn-erp-reset me-2" ng-click="clearForm()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
                    <button type="button" class="btn btn-erp-view" ng-click="showFindBar = !showFindBar">
                        <i class="fa fa-search me-1"></i> Find
                    </button>
                    
                    <button type="button" class="btn btn-outline-secondary btn-sm ms-2" ng-show="factory.seasonYear" ng-click="updateFactory()">
                        <i class="fa fa-edit me-1"></i> Update
                    </button>
                    <button type="button" class="btn btn-outline-danger btn-sm ms-2" ng-show="factory.seasonYear" ng-click="deleteFactory()">
                        <i class="fa fa-trash me-1"></i> Delete
                    </button>
                </div>
                
                <div class="row mt-3 justify-content-center" ng-show="showFindBar">
                    <div class="col-md-6 d-flex align-items-center bg-white p-3 border rounded shadow-sm">
                        <label class="fw-bold me-3 text-nowrap" style="font-size: 13px;">Enter Season Year:</label>
                        <input type="text" class="form-control form-control-sm me-3 border-info" ng-model="searchSeasonYear" placeholder="YYYY-YYYY">
                        <button type="button" class="btn btn-sm btn-info text-white px-4 fw-bold" ng-click="findFactory(searchSeasonYear)">Find</button>
                    </div>
                </div>

            </form>
        </div>
        
        <script>
            if (typeof angular !== 'undefined' && typeof window.appContainerCompiled === 'undefined') {
                try {
                    var el = document.getElementById('factory-panel');
                    if (el && !angular.element(el).scope()) {
                        angular.bootstrap(el, ['factoryApp']);
                    }
                } catch(e) {}
            }
        </script>
        
    </div>
</body>
</html>