<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daily Analysis Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 700px; border-right: 2px solid #888; }
        .main-panel { background-color: #e9ecef; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; }
        .action-btn:hover { background-color: #e2e6ea; }
        
        /* Report Specific Styling */
        .report-paper { background-color: white; padding: 30px; border: 1px solid #ccc; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); margin: 0 auto; max-width: 950px; }
        .report-title { text-align: center; font-weight: bold; color: #000; margin-bottom: 5px; font-size: 1.3rem; }
        .report-subtitle { text-align: center; font-weight: bold; font-size: 1.1rem; margin-bottom: 20px; text-decoration: underline; }
        
        .table-report { width: 100%; border-collapse: collapse; margin-bottom: 15px; }
        .table-report th { background-color: #f8f9fa !important; border: 1px solid #000; text-align: center; vertical-align: middle; padding: 5px; font-size: 0.85rem; }
        .table-report td { border: 1px solid #000; padding: 4px 6px; font-size: 0.85rem; }
        .section-header { background-color: #e9ecef !important; font-weight: bold; text-align: center !important; font-size: 0.9rem; }
        
        @media print {
            body * { visibility: hidden; }
            #printableArea, #printableArea * { visibility: visible; }
            #printableArea { position: absolute; left: 0; top: 0; width: 100%; box-shadow: none; border: none; padding: 0; }
            /* Force tables to stay together on page breaks if possible */
            .break-inside-avoid { page-break-inside: avoid; }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">DAILY ANALYSIS REPORT GENERATION</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-primary" onclick="window.print()">Print Report</button>
                    <button type="button" class="btn action-btn text-danger">Export to PDF</button>
                    <button type="button" class="btn action-btn text-success">Export to Excel</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <form action="GenerateDailyAnalysisServlet" method="GET" class="mb-4 bg-white p-3 border rounded shadow-sm w-75 mx-auto">
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-dark">Select Date:</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm" name="reportDate" required>
                            </div>
                            <div class="col-auto ms-3">
                                <button type="submit" class="btn btn-sm btn-dark px-4 fw-bold">Generate</button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper">
                        <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                        <h5 class="report-subtitle">Daily Laboratory Analysis Report</h5>
                        
                        <div class="row mb-3" style="font-size: 0.95rem;">
                            <div class="col-6"><strong>Season:</strong> 2025-2026</div>
                            <div class="col-6 text-end"><strong>Date:</strong> 15/12/2025</div>
                        </div>

                        <div class="row break-inside-avoid">
                            <div class="col-md-6">
                                <table class="table table-report table-sm">
                                    <thead>
                                        <tr><th colspan="2" class="section-header">Time Account & Cane</th></tr>
                                        <tr><th>Particulars</th><th>Value</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Working Hours</td><td class="text-end">21.50</td></tr>
                                        <tr><td>Hours Lost Mechanical</td><td class="text-end">1.50</td></tr>
                                        <tr><td>Hours Lost Electrical</td><td class="text-end">0.50</td></tr>
                                        <tr><td>Hours Lost Process</td><td class="text-end">0.50</td></tr>
                                        <tr><td>Member Cane Crushed (MT)</td><td class="text-end">3,050.00</td></tr>
                                        <tr><td>Non-Member Cane (MT)</td><td class="text-end">250.00</td></tr>
                                        <tr class="fw-bold bg-light"><td>Total Cane Crushed (MT)</td><td class="text-end">3,300.00</td></tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-md-6">
                                <table class="table table-report table-sm">
                                    <thead>
                                        <tr><th colspan="2" class="section-header">Corrections, Losses & Temp</th></tr>
                                        <tr><th>Particulars</th><th>Value</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Dirt Correction</td><td class="text-end">0.55</td></tr>
                                        <tr><td>Recovery Correction</td><td class="text-end">0.00</td></tr>
                                        <tr><td>Undetermined Losses</td><td class="text-end">0.18</td></tr>
                                        <tr><td>Filter Cake Weight (MT)</td><td class="text-end">132.50</td></tr>
                                        <tr><td>Condenser Inlet Temp (°C)</td><td class="text-end">32.50</td></tr>
                                        <tr><td>Condenser Outlet Temp (°C)</td><td class="text-end">45.20</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row break-inside-avoid mt-2">
                            <div class="col-md-6">
                                <table class="table table-report table-sm">
                                    <thead>
                                        <tr><th colspan="3" class="section-header">By-Product Analysis</th></tr>
                                        <tr><th>Item</th><th>Pol %</th><th>Moisture %</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>Bagasse</td><td class="text-end">2.15</td><td class="text-end">49.50</td></tr>
                                        <tr><td>Filter Cake</td><td class="text-end">1.85</td><td class="text-end">70.20</td></tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-md-6">
                                <table class="table table-report table-sm">
                                    <thead>
                                        <tr><th colspan="2" class="section-header">Sugar Production (Bags)</th></tr>
                                        <tr><th>Grade</th><th>No. of Bags</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>L-30 (50 Kg)</td><td class="text-end">1,200</td></tr>
                                        <tr><td>M-30 (50 Kg)</td><td class="text-end">4,500</td></tr>
                                        <tr><td>S1-30 (50 Kg)</td><td class="text-end">850</td></tr>
                                        <tr><td>Raw Sugar (50 Kg)</td><td class="text-end">0</td></tr>
                                        <tr class="fw-bold bg-light"><td>Total Bags</td><td class="text-end">6,550</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row break-inside-avoid mt-2">
                            <div class="col-12">
                                <table class="table table-report table-sm">
                                    <thead>
                                        <tr><th colspan="4" class="section-header">Process Products Analysis</th></tr>
                                        <tr>
                                            <th style="width: 40%;">Product Name</th>
                                            <th style="width: 20%;">Brix %</th>
                                            <th style="width: 20%;">Pol %</th>
                                            <th style="width: 20%;">Purity %</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Primary Juice</td>
                                            <td class="text-end">19.85</td>
                                            <td class="text-end">16.80</td>
                                            <td class="text-end">84.63</td>
                                        </tr>
                                        <tr>
                                            <td>Mixed Juice</td>
                                            <td class="text-end">14.50</td>
                                            <td class="text-end">11.90</td>
                                            <td class="text-end">82.06</td>
                                        </tr>
                                        <tr>
                                            <td>Clear Juice</td>
                                            <td class="text-end">15.10</td>
                                            <td class="text-end">12.45</td>
                                            <td class="text-end">82.45</td>
                                        </tr>
                                        <tr>
                                            <td>A - Massecuite</td>
                                            <td class="text-end">92.50</td>
                                            <td class="text-end">78.50</td>
                                            <td class="text-end">84.86</td>
                                        </tr>
                                        <tr>
                                            <td>Final Molasses</td>
                                            <td class="text-end">86.10</td>
                                            <td class="text-end">27.01</td>
                                            <td class="text-end">31.37</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="row mt-5 pt-3">
                            <div class="col-4 text-center fw-bold mt-5">Lab Chemist<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-4 text-center fw-bold mt-5">Chief Chemist<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-4 text-center fw-bold mt-5">Managing Director<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>