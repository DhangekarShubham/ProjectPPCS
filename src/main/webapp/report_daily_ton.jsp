<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="dailyTonApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Tonnage Report | Sugar ERP</title>

<style>
        /* --- PRINT CSS OVERRIDES --- */
        @media print {
            /* 1. Completely hide the search bar, navbars, and alerts */
            .no-print, .alert, nav, header, footer { 
                display: none !important; 
            }
            
            /* 2. Reset the page background to pure white */
            body, html {
                background-color: #ffffff !important;
                margin: 0 !important;
                padding: 0 !important;
            }

            /* 3. Make the report flow naturally (fixes the blank page bug) */
            #printableArea { 
                position: relative !important;
                left: 0 !important;
                top: 0 !important;
                width: 100% !important; 
                box-shadow: none !important; 
                border: none !important; 
                margin: 0 !important; 
                padding: 0 !important;
                display: block !important;
            }
            
            /* 4. Force browsers to print the black table borders and grey headers */
            .pdf-table { width: 100% !important; border-collapse: collapse !important; }
            .pdf-table th, .pdf-table td { border: 1px solid #000 !important; color: #000 !important; }
            .pdf-table th { 
                background-color: #f1f5f9 !important; 
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important; 
            }
        }
        
        /* --- SCREEN CSS --- */
        .report-header-title { font-size: 22px; font-weight: 800; text-align: center; color: #000; letter-spacing: 0.5px; }
        .report-header-subtitle { font-size: 16px; font-weight: bold; text-align: center; margin-bottom: 25px; color: #333; text-decoration: underline; }
        .report-meta-info { display: flex; justify-content: space-between; font-weight: bold; margin-bottom: 10px; font-size: 14px; color: #000; }
        
        .pdf-table { width: 100%; border-collapse: collapse; margin-bottom: 25px; }
        .pdf-table th, .pdf-table td { border: 1px solid #000; padding: 6px 10px; font-size: 13px; color: #000; }
        .pdf-table th { background-color: #f1f5f9; font-weight: bold; }
        .val-col { text-align: right; font-family: monospace; font-size: 14px; }
    </style>
</head>

<body ng-app="dailyTonApp">

<div class="contentpanel" ng-controller="DailyTonController">

    <!-- 🔹 Top Control Panel -->
    <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded no-print">
        
        <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
            <i class="fa fa-truck me-2"></i> Daily Tonnage Report
        </div>
        
        <div class="row align-items-center bg-light p-3 mx-0 border-bottom">
            
            <div class="col-md-4 d-flex align-items-center">
                 <label class="text-muted small fw-bold text-uppercase me-2 mb-0" style="white-space: nowrap;">Report Date:</label>
                
                <input type="date" class="form-control form-control-sm border-primary"
                       ng-model="selectedDate">
            </div>

            <div class="col-md-6">
                <button class="btn btn-sm btn-primary fw-bold px-4 me-2"
                        ng-click="generateReport()" style="background-color: #6593b4; border: none;">
                    Generate
                </button>

                <button class="btn btn-sm btn-warning text-white fw-bold px-4 me-2" style="background-color: #e5a751; border: none;"
                        ng-click="printReport()" ng-disabled="!isDataLoaded">
                    Print / PDF
                </button>

                <button type="button" class="btn btn-sm btn-light fw-bold px-4 border shadow-sm" ng-click="clearReport()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
            </div>
        </div>
    </div>

    <!-- 🔹 Report Section -->
    <div id="printableArea" class="erp-form-container mx-2 mt-4 p-5 bg-white shadow border rounded"
         ng-show="isDataLoaded">

        <div class="report-header-title">
            Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.
        </div>

        <div class="report-header-subtitle">
            Daily Cane Crushing (Tonnage) Report
        </div>

        <div class="report-meta-info">
            <div>Season {{ report.seasonYear }}</div>
            <div>Crop Day: {{ report.cropDay }}</div>
            <div>Date: {{ displayDate }}</div>
        </div>

        <!-- 🔹 Shift Table -->
        <table class="pdf-table">
            <thead>
                <tr>
                    <th>Shift</th>
                    <th>Cane (MT)</th>
                    <th>Hours</th>
                    <th>Rate</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Shift A</td>
                    <td class="val-col">{{ report.shiftACane | number:2 }}</td>
                    <td class="val-col">{{ report.shiftAHours }}</td>
                    <td class="val-col">{{ report.rateA | number:2 }}</td>
                </tr>
                <tr>
                    <td>Shift B</td>
                    <td class="val-col">{{ report.shiftBCane | number:2 }}</td>
                    <td class="val-col">{{ report.shiftBHours }}</td>
                    <td class="val-col">{{ report.rateB | number:2 }}</td>
                </tr>
                <tr>
                    <td>Shift C</td>
                    <td class="val-col">{{ report.shiftCCane | number:2 }}</td>
                    <td class="val-col">{{ report.shiftCHours }}</td>
                    <td class="val-col">{{ report.rateC | number:2 }}</td>
                </tr>
                <tr style="font-weight:bold;">
                    <td>Total Today</td>
                    <td class="val-col">{{ report.totalCaneToday }}</td>
                    <td class="val-col">{{ report.totalHoursToday }}</td>
                    <td class="val-col">{{ report.rateTotalToday }}</td>
                </tr>
            </tbody>
        </table>

        <!-- 🔹 Source Table -->
        <table class="pdf-table">
            <thead>
                <tr>
                    <th>Category</th>
                    <th>Today</th>
                    <th>To-Date</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Member Cane</td>
                    <td class="val-col">{{ report.memberCaneToday }}</td>
                    <td class="val-col">{{ report.memberCaneTodate }}</td>
                </tr>
                <tr>
                    <td>Non-Member Cane</td>
                    <td class="val-col">{{ report.nonMemberCaneToday }}</td>
                    <td class="val-col">{{ report.nonMemberCaneTodate }}</td>
                </tr>
                <tr>
                    <td>Bullock Cart</td>
                    <td class="val-col">{{ report.bullockCartToday }}</td>
                    <td class="val-col">{{ report.bullockCartTodate }}</td>
                </tr>
                <tr>
                    <td>Tractor</td>
                    <td class="val-col">{{ report.tractorToday }}</td>
                    <td class="val-col">{{ report.tractorTodate }}</td>
                </tr>
                <tr>
                    <td>Truck</td>
                    <td class="val-col">{{ report.truckToday }}</td>
                    <td class="val-col">{{ report.truckTodate }}</td>
                </tr>
            </tbody>
        </table>

        <!-- 🔹 Signature -->
        <div style="margin-top: 80px; display:flex; justify-content:space-between; text-align:center; font-weight:bold;">
            <div style="width:30%">Cane Yard Supervisor</div>
            <div style="width:30%">Chief Chemist</div>
            <div style="width:30%">Managing Director</div>
        </div>

    </div>

    <!--  Empty State -->
    <div class="alert alert-light w-75 mx-auto text-center border shadow-sm mt-5 text-muted" ng-hide="isDataLoaded">
            <i class="fa fa-info-circle fa-2x mb-3 text-primary d-block"></i>
            <h6 class="fw-bold">No Report Data Loaded</h6>
            <p class="small mb-0">Please enter a date from the top menu and click <strong>Generate</strong> to view the Daily Manufacturing Details.</p>
    </div>
</div>
</html>