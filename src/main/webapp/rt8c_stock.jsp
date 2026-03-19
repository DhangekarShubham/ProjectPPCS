<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Technical Performance RT-8(C)</title>
</head>
<body>

    <div class="contentpanel" ng-controller="RT8CController">
        
        <link href="css/forms.css" rel="stylesheet">
        <script src="js/rt8c.js"></script>

        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded">
            
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                <i class="fa fa-line-chart me-2"></i> RT8 (C) : Screen No.1
            </div>
            
            <form name="rt8cForm" class="p-4" novalidate>
                
                <div class="bg-light p-3 border rounded shadow-sm mb-4">
                    <div class="row g-3 align-items-center justify-content-center text-center">
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Year</label>
                            <input type="text" class="form-control form-control-sm border-success text-center fw-bold" ng-model="rt8c.seasonYear" placeholder="Enter Season Year" required>
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Start Date</label>
                            <input type="date" class="form-control form-control-sm" ng-model="rt8c.seasonStartDate">
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Crushing End Date</label>
                            <input type="date" class="form-control form-control-sm" ng-model="rt8c.crushingEndDate">
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Crushing End Time</label>
                            <input type="time" class="form-control form-control-sm" ng-model="rt8c.crushingEndTime">
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Process End Date</label>
                            <input type="date" class="form-control form-control-sm" ng-model="rt8c.processEndDate">
                        </div>
                        <div class="col-md-2">
                            <label class="text-muted small fw-bold d-block mb-1">Season Process End Time</label>
                            <input type="time" class="form-control form-control-sm" ng-model="rt8c.processEndTime">
                        </div>
                    </div>
                </div>

                <div class="bg-white p-4 shadow-sm border rounded">
                    <div class="row g-5">
                        
                        <div class="col-md-6 border-end pe-4">
                            <div class="row mb-3 align-items-center" ng-repeat="field in [
                                {label: 'Own Estate Cane', model: 'ownEstateCane'},
                                {label: 'Gate Cane', model: 'gateCane'},
                                {label: 'Out Station Cane', model: 'outStationCane'},
                                {label: 'Area Harvested', model: 'areaHarvested'},
                                {label: 'Other than Rail Cane', model: 'otherThanRailCane'},
                                {label: 'Cane Provided By Members', model: 'caneMembers'},
                                {label: 'Cane Provided By Non Members', model: 'caneNonMembers'},
                                {label: 'Area Under Farm', model: 'areaUnderFarm'},
                                {label: 'Area Under Cane', model: 'areaUnderCane'},
                                {label: 'Rori Sugar Bags', model: 'roriSugarBags'},
                                {label: 'Extra Fuel Inte of Std Bag % cane', model: 'extraFuelStdBagPct'},
                                {label: 'Process Steam % Cane', model: 'processSteamPct'}
                            ]">
                                <label class="col-sm-7 text-start text-muted small fw-bold ps-3">{{ field.label }}</label>
                                <div class="col-sm-5">
                                    <input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt8c.data[field.model]">
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 ps-4">
                            <div class="row mb-3 align-items-center" ng-repeat="field in [
                                {label: 'Average Yeild Per Hectare', model: 'avgYieldPerHectare'},
                                {label: 'Average Yeild Per Hectare Adsali', model: 'avgYieldAdsali'},
                                {label: 'Average Yeild Per Hectare Plant', model: 'avgYieldPlant'},
                                {label: 'Average Yeild Per Hectare Ratoon', model: 'avgYieldRatoon'},
                                {label: 'Average Preparatory Index', model: 'avgPrepIndex'},
                                {label: 'Average Temperature of Added Water', model: 'avgTempAddedWater'},
                                {label: 'Bagasse used as Fuel', model: 'bagasseUsedFuel'},
                                {label: 'Bagasse used for Sugar Plant', model: 'bagasseUsedSugarPlant'},
                                {label: 'Bagasse used for by Products.', model: 'bagasseUsedByProducts'},
                                {label: 'Bagasse used for Co - Generation', model: 'bagasseUsedCogen'},
                                {label: 'Bagasse used for oliver', model: 'bagasseUsedOliver'},
                                {label: 'Bagasse Sold', model: 'bagasseSold'}
                            ]">
                                <label class="col-sm-7 text-start text-muted small fw-bold">{{ field.label }}</label>
                                <div class="col-sm-5">
                                    <input type="number" step="0.001" class="form-control form-control-sm text-end" placeholder="0.000" ng-model="rt8c.data[field.model]">
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                
                <div class="row mt-4 mb-2 bg-light py-3 border-top">
                    <div class="col-12 text-center">
                        <button type="button" class="btn btn-primary px-4 me-2" ng-click="saveData('save')" ng-disabled="rt8cForm.$invalid" style="background-color: #6593b4; border: none;">Save Data</button>
                        <button type="button" class="btn btn-light px-4 border me-2" ng-click="clearForm()">Cancel / New</button>
                        <button type="button" class="btn btn-warning px-4 text-white" ng-click="findData()" style="background-color: #e5a751; border: none;">Find Record</button>
                        
                        <button type="button" class="btn btn-outline-secondary px-3 ms-2" ng-click="saveData('update')">Change (Update)</button>
                        <button type="button" class="btn btn-outline-danger px-3 ms-2" ng-click="deleteData()">Delete</button>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>
</html>