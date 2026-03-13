<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RT-8(C) Final Manufacturing Report</title>
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
        .report-paper { background-color: white; padding: 40px; border: 1px solid #ccc; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); margin: 0 auto; max-width: 950px; }
        .report-title { text-align: center; font-weight: bold; color: #000; margin-bottom: 5px; font-size: 1.3rem; }
        .report-subtitle { text-align: center; font-weight: bold; font-size: 1.1rem; margin-bottom: 10px; }
        .excise-header { text-align: center; font-weight: bold; font-size: 1.2rem; margin-bottom: 25px; text-decoration: underline; }
        
        .table-report { width: 100%; border-collapse: collapse; margin-bottom: 25px; }
        .table-report th { background-color: #f8f9fa !important; border: 1px solid #000; text-align: center; vertical-align: middle; padding: 6px; font-size: 0.85rem; }
        .table-report td { border: 1px solid #000; padding: 4px 8px; font-size: 0.85rem; }
        .section-header { background-color: #e9ecef !important; font-weight: bold; text-align: left !important; }
        
        @media print {
            body * { visibility: hidden; }
            #printableArea, #printableArea * { visibility: visible; }
            #printableArea { position: absolute; left: 0; top: 0; width: 100%; box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">RT-8(C) FINAL REPORT GENERATION</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-primary" onclick="window.print()">Print Report</button>
                    <button type="button" class="btn action-btn text-danger">Export to PDF</button>
                    <button type="button" class="btn action-btn text-success">Export to Excel</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <form action="GenerateRT8CServlet" method="GET" class="mb-4 bg-white p-3 border rounded shadow-sm w-75 mx-auto">
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-dark">Select Season Year:</label>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" name="seasonYear" required>
                                    <option value="2025-2026" selected>2025-2026</option>
                                    <option value="2024-2025">2024-2025</option>
                                </select>
                            </div>
                            <div class="col-auto ms-3">
                                <button type="submit" class="btn btn-sm btn-dark px-4 fw-bold">Generate</button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper">
                        <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                        <h5 class="report-subtitle">Tal. Indapur, Dist. Pune - 413 106</h5>
                        <div class="excise-header">FORM R.T. 8 (C) - FINAL MANUFACTURING REPORT</div>
                        
                        <div class="row mb-3" style="font-size: 0.95rem;">
                            <div class="col-6"><strong>Season:</strong> 2025-2026</div>
                            <div class="col-6 text-end"><strong>Date of Report:</strong> 30/04/2026</div>
                            <div class="col-6"><strong>Plant Capacity:</strong> 3500 TCD</div>
                            <div class="col-6 text-end"><strong>Total Crushing Days:</strong> 165</div>
                        </div>

                        <table class="table table-report table-sm">
                            <thead>
                                <tr>
                                    <th colspan="3" class="section-header">1. Milling & Technical Performance</th>
                                </tr>
                                <tr>
                                    <th style="width: 50%;">Particulars</th>
                                    <th style="width: 25%;">Current Season (2025-26)</th>
                                    <th style="width: 25%;">Previous Season (2024-25)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Total Cane Crushed (MT)</td>
                                    <td class="text-end">575,250.000</td>
                                    <td class="text-end">540,100.000</td>
                                </tr>
                                <tr>
                                    <td>Average Recovery % Cane</td>
                                    <td class="text-end">11.45</td>
                                    <td class="text-end">11.20</td>
                                </tr>
                                <tr>
                                    <td>Added Water % Fiber</td>
                                    <td class="text-end">235.50</td>
                                    <td class="text-end">240.10</td>
                                </tr>
                                <tr>
                                    <td>Mixed Juice % Cane</td>
                                    <td class="text-end">98.50</td>
                                    <td class="text-end">99.10</td>
                                </tr>
                                <tr>
                                    <td>Mill Extraction %</td>
                                    <td class="text-end">96.15</td>
                                    <td class="text-end">95.80</td>
                                </tr>
                                <tr>
                                    <td>Reduced Mill Extraction %</td>
                                    <td class="text-end">96.50</td>
                                    <td class="text-end">96.20</td>
                                </tr>
                                <tr>
                                    <td>Overall Extraction %</td>
                                    <td class="text-end">85.40</td>
                                    <td class="text-end">84.90</td>
                                </tr>
                                <tr>
                                    <td>Total Sugar Losses % Cane</td>
                                    <td class="text-end">2.05</td>
                                    <td class="text-end">2.15</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm">
                            <thead>
                                <tr>
                                    <th colspan="3" class="section-header">2. Bagasse Data Balance (MT)</th>
                                </tr>
                                <tr>
                                    <th style="width: 50%;">Particulars</th>
                                    <th style="width: 25%;">Current Season</th>
                                    <th style="width: 25%;">Previous Season</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Opening Balance at start of season</td>
                                    <td class="text-end">12,500.000</td>
                                    <td class="text-end">10,200.000</td>
                                </tr>
                                <tr>
                                    <td>Production of Bagasse during season</td>
                                    <td class="text-end">161,070.000</td>
                                    <td class="text-end">151,228.000</td>
                                </tr>
                                <tr class="fw-bold bg-light">
                                    <td>Total Bagasse Available</td>
                                    <td class="text-end">173,570.000</td>
                                    <td class="text-end">161,428.000</td>
                                </tr>
                                <tr>
                                    <td>Used as fuel for Sugar Mill Boiler</td>
                                    <td class="text-end">105,000.000</td>
                                    <td class="text-end">102,500.000</td>
                                </tr>
                                <tr>
                                    <td>Used as fuel for Co-Generation Unit</td>
                                    <td class="text-end">45,000.000</td>
                                    <td class="text-end">40,000.000</td>
                                </tr>
                                <tr>
                                    <td>Used for Vacuum/Oliver filter</td>
                                    <td class="text-end">1,500.000</td>
                                    <td class="text-end">1,428.000</td>
                                </tr>
                                <tr class="fw-bold bg-light">
                                    <td>Total Bagasse Used as Fuel/Process</td>
                                    <td class="text-end">151,500.000</td>
                                    <td class="text-end">143,928.000</td>
                                </tr>
                                <tr class="fw-bold text-success">
                                    <td>Bagasse Saved / Closing Balance</td>
                                    <td class="text-end">22,070.000</td>
                                    <td class="text-end">17,500.000</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm">
                            <thead>
                                <tr>
                                    <th colspan="3" class="section-header">3. Stores Consumption & Utilities</th>
                                </tr>
                                <tr>
                                    <th style="width: 50%;">Particulars</th>
                                    <th style="width: 25%;">Current Season</th>
                                    <th style="width: 25%;">Previous Season</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Lime Consumption % Cane (Process)</td>
                                    <td class="text-end">0.180</td>
                                    <td class="text-end">0.185</td>
                                </tr>
                                <tr>
                                    <td>Sulphur Consumption % Cane</td>
                                    <td class="text-end">0.055</td>
                                    <td class="text-end">0.060</td>
                                </tr>
                                <tr>
                                    <td>Lubricants: Oils (Litres)</td>
                                    <td class="text-end">14,250.00</td>
                                    <td class="text-end">15,100.00</td>
                                </tr>
                                <tr>
                                    <td>Lubricants: Greases (Kg)</td>
                                    <td class="text-end">4,120.00</td>
                                    <td class="text-end">4,350.00</td>
                                </tr>
                                <tr>
                                    <td>Total Electricity Generated (KWH)</td>
                                    <td class="text-end">18,500,000</td>
                                    <td class="text-end">17,200,000</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5 pt-3">
                            <div class="col-3 text-center fw-bold mt-5">Chief Chemist<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-3 text-center fw-bold mt-5">Chief Engineer<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-3 text-center fw-bold mt-5">Managing Director<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-3 text-center fw-bold mt-5">Central Excise<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature & Seal)</span></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>