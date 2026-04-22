<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    <div class="contentpanel" ng-controller="Rt8cStockEntryController">
        <style>
            .rt8c-form-wrapper {
                background-color: #f5f7fa; 
                padding-bottom: 50px;
                font-family: 'Inter', sans-serif;
            }
            
            .custom-panel {
                background-color: #ffffff;
                border-radius: 4px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                border: 1px solid #e9ecef;
                margin: 20px;
            }

            .panel-heading-custom {
                background-color: #48b3b3;
                color: #ffffff;
                font-size: 15px;
                font-weight: 700;
                padding: 12px 20px;
                letter-spacing: 0.5px;
                border-top-left-radius: 4px;
                border-top-right-radius: 4px;
            }

            .top-inputs-box {
                border: 1px solid #e9ecef;
                border-radius: 4px;
                padding: 20px;
                margin: 20px;
                background-color: #ffffff; 
                box-shadow: 0 1px 4px rgba(0,0,0,0.02);
            }
            
            .top-inputs-box label {
                color: #555;
                font-weight: 700;
                font-size: 11px;
                text-transform: uppercase;
                margin-bottom: 5px;
                display: block;
            }

            .top-inputs-box input {
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 6px 10px;
                font-size: 14px;
                width: 100%;
                transition: border-color 0.2s ease;
                background-color: #fff;
            }

            .top-inputs-box input:focus {
                outline: none;
                border-color: #48b3b3;
                box-shadow: 0 0 5px rgba(72, 179, 179, 0.4);
            }

            .border-green { border-color: #28a745 !important; }

            .data-row-container {
                padding: 10px 30px 30px 30px;
            }

            .data-label {
                color: #555;
                font-weight: 700;
                font-size: 12px;
                text-transform: uppercase;
                text-align: left;
            }

            .data-input {
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 6px 10px;
                background-color: #ffffff;
                text-align: right;
                width: 100%;
                font-weight: 600;
                color: #333;
                font-family: 'JetBrains Mono', monospace;
                transition: border-color 0.2s ease;
            }
            
            .data-input:focus {
                outline: none;
                border-color: #48b3b3;
                box-shadow: 0 0 5px rgba(72, 179, 179, 0.4);
            }

            .action-bar {
                background-color: #f8f9fa;
                padding: 20px;
                border-top: 1px solid #e9ecef;
                text-align: center;
                margin-top: 10px;
                border-bottom-left-radius: 4px;
                border-bottom-right-radius: 4px;
            }

            .btn-custom {
                font-size: 13px;
                font-weight: 600;
                padding: 8px 20px;
                border-radius: 3px;
                margin: 0 5px;
                cursor: pointer;
                transition: opacity 0.2s ease;
            }
            
            .btn-custom:hover { opacity: 0.9; }
            .btn-save { background-color: #6a95a8; color: white; border: none; }
            .btn-cancel { background-color: #ffffff; color: #333; border: 1px solid #ccc; }
            .btn-find { background-color: #e5a751; color: white; border: none; }
            .btn-change { background-color: #ffffff; color: #6a95a8; border: 1px solid #6a95a8; }
            .btn-delete { background-color: #ffffff; color: #dc3545; border: 1px solid #dc3545; }
        </style>

        <div class="rt8c-form-wrapper">
            <div class="custom-panel">
                
                <div class="panel-heading-custom">
                    <i class="fa fa-line-chart me-2"></i> RT-8 (C) TECHNICAL PERFORMANCE : DATA ENTRY
                </div>
                
                <form name="rt8cEntryForm" novalidate>
                    
                    <div class="top-inputs-box">
                        <div class="row align-items-end g-3 justify-content-center text-center">
                            <div class="col-md-2">
                                <label>Season Year</label>
                                <input type="text" class="form-control border-green text-center fw-bold" ng-model="rt8cEntry.seasonYear" placeholder="2025-2026" required>
                            </div>
                            <div class="col-md-2">
                                <label>Season Start Date</label>
                                <input type="date" class="form-control text-muted" ng-model="rt8cEntry.seasonStartDate">
                            </div>
                            <div class="col-md-2">
                                <label>Crushing End Date</label>
                                <input type="date" class="form-control text-muted" ng-model="rt8cEntry.crushingEndDate">
                            </div>
                            <div class="col-md-2">
                                <label>Crushing End Time</label>
                                <input type="time" class="form-control text-muted" ng-model="rt8cEntry.crushingEndTime">
                            </div>
                            <div class="col-md-2">
                                <label>Process End Date</label>
                                <input type="date" class="form-control text-muted" ng-model="rt8cEntry.processEndDate">
                            </div>
                            <div class="col-md-2">
                                <label>Process End Time</label>
                                <input type="time" class="form-control text-muted" ng-model="rt8cEntry.processEndTime">
                            </div>
                        </div>
                    </div>

                    <div class="data-row-container">
                        <div class="row g-5">
                            
                            <div class="col-md-6 border-end pe-4">
                                <div class="row mb-3 align-items-center" ng-repeat="field in leftColumnFields">
                                    <label class="col-sm-7 data-label ps-3">{{ field.label }}</label>
                                    <div class="col-sm-5">
                                        <input type="number" step="0.001" class="form-control data-input" placeholder="0.000" ng-model="rt8cEntry.data[field.model]">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6 ps-4">
                                <div class="row mb-3 align-items-center" ng-repeat="field in rightColumnFields">
                                    <label class="col-sm-7 data-label">{{ field.label }}</label>
                                    <div class="col-sm-5">
                                        <input type="number" step="0.001" class="form-control data-input" placeholder="0.000" ng-model="rt8cEntry.data[field.model]">
                                    </div>
                                </div> 
                            </div>

                        </div>
                    </div>
                    
                    <div class="action-bar">
                        <button type="button" class="btn-custom btn-save" ng-click="saveData('save')" ng-disabled="rt8cEntryForm.$invalid">Save Data</button>
                        <button type="button" class="btn-custom btn-cancel" ng-click="clearForm()">Cancel / New</button>
                        <button type="button" class="btn-custom btn-find" ng-click="findData()">Find Record</button>
                        <button type="button" class="btn-custom btn-change" ng-click="saveData('update')">Change (Update)</button>
                        <button type="button" class="btn-custom btn-delete" ng-click="deleteData()">Delete</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>