<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RT-7(C) Monthly Statutory Report</title>
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
        
        .table-report { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
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
            <div class="window-header">RT-7(C) MONTHLY REPORT GENERATION</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-primary" onclick="window.print()">Print Report</button>
                    <button type="button" class="btn action-btn text-danger">Export to PDF</button>
                    <button type="button" class="btn action-btn text-success">Export to Excel</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <form action="GenerateRT7CServlet" method="GET" class="mb-4 bg-white p-3 border rounded shadow-sm w-75 mx-auto">
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-dark">Report Month:</label>
                            <div class="col-auto">
                                <input type="month" class="form-control form-control-sm" name="reportMonth" value="2025-12" required>
                            </div>
                            <div class="col-auto ms-3">
                                <button type="submit" class="btn btn-sm btn-dark px-4 fw-bold">Generate</button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper">
                        <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                        <h5 class="report-subtitle">Tal. Indapur, Dist. Pune - 413 106</h5>
                        <div class="excise-header">FORM R.T. 7 (C)</div>
                        
                        <div class="row mb-3" style="font-size: 0.95rem;">
                            <div class="col-6"><strong>Season:</strong> 2025-2026</div>
                            <div class="col-6 text-end"><strong>Month:</strong> December 2025</div>
                            <div class="col-6"><strong>GST No:</strong> 27AAAAA0000A1Z5</div>
                            <div class="col-6 text-end"><strong>Date of Report:</strong> 01/01/2026</div>
                        </div>

                        <table class="table table-report table-sm">
                            <thead>
                                <tr>
                                    <th colspan="3" class="section-header">1. Manufacturing Summary</th>
                                </tr>
                                <tr>
                                    <th style="width: 50%;">Particulars</th>
                                    <th style="width: 25%;">For the Month</th>
                                    <th style="width: 25%;">To-Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Cane Crushed (MT)</td>
                                    <td class="text-end">105,420.000</td>
                                    <td class="text-end">350,890.500</td>
                                </tr>
                                <tr>
                                    <td>Sugar Bagged (Qtls)</td>
                                    <td class="text-end">118,500.00</td>
                                    <td class="text-end">395,200.00</td>
                                </tr>
                                <tr>
                                    <td>Sugar in Process (Qtls)</td>
                                    <td class="text-end">1,250.00</td>
                                    <td class="text-end">1,250.00</td>
                                </tr>
                                <tr class="fw-bold">
                                    <td>Total Net Sugar Made (Qtls)</td>
                                    <td class="text-end">119,750.00</td>
                                    <td class="text-end">396,450.00</td>
                                </tr>
                                <tr class="fw-bold text-primary">
                                    <td>Recovery % Cane</td>
                                    <td class="text-end">11.36</td>
                                    <td class="text-end">11.29</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm mt-3">
                            <thead>
                                <tr>
                                    <th colspan="7" class="section-header">2. Statement of In-Process Stock (End of Month)</th>
                                </tr>
                                <tr>
                                    <th style="width: 25%;">Material</th>
                                    <th style="width: 15%;">Volume (HL)</th>
                                    <th style="width: 12%;">Sp. Gr.</th>
                                    <th style="width: 12%;">Brix %</th>
                                    <th style="width: 12%;">Pol %</th>
                                    <th style="width: 12%;">Purity %</th>
                                    <th style="width: 12%;">Available Sugar (Qtls)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Clear Juice</td>
                                    <td class="text-end">450.00</td>
                                    <td class="text-end">1.06</td>
                                    <td class="text-end">15.50</td>
                                    <td class="text-end">13.20</td>
                                    <td class="text-end">85.16</td>
                                    <td class="text-end">45.20</td>
                                </tr>
                                <tr>
                                    <td>Unsulphited Syrup</td>
                                    <td class="text-end">120.00</td>
                                    <td class="text-end">1.28</td>
                                    <td class="text-end">55.40</td>
                                    <td class="text-end">46.50</td>
                                    <td class="text-end">83.93</td>
                                    <td class="text-end">180.50</td>
                                </tr>
                                <tr>
                                    <td>Sulphited Syrup</td>
                                    <td class="text-end">350.00</td>
                                    <td class="text-end">1.28</td>
                                    <td class="text-end">56.10</td>
                                    <td class="text-end">47.20</td>
                                    <td class="text-end">84.13</td>
                                    <td class="text-end">545.80</td>
                                </tr>
                                <tr>
                                    <td>A-Massecuite</td>
                                    <td class="text-end">280.00</td>
                                    <td class="text-end">1.48</td>
                                    <td class="text-end">92.50</td>
                                    <td class="text-end">78.50</td>
                                    <td class="text-end">84.86</td>
                                    <td class="text-end">278.50</td>
                                </tr>
                                <tr>
                                    <td>C-Massecuite</td>
                                    <td class="text-end">410.00</td>
                                    <td class="text-end">1.52</td>
                                    <td class="text-end">98.50</td>
                                    <td class="text-end">58.20</td>
                                    <td class="text-end">59.08</td>
                                    <td class="text-end">200.00</td>
                                </tr>
                                <tr class="fw-bold bg-light">
                                    <td colspan="6" class="text-end">Total Sugar in Process (Qtls):</td>
                                    <td class="text-end">1,250.00</td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table table-report table-sm mt-3">
                            <thead>
                                <tr>
                                    <th colspan="5" class="section-header">3. Final Sugar Account (Qtls)</th>
                                </tr>
                                <tr>
                                    <th style="width: 25%;">Grade</th>
                                    <th style="width: 15%;">Opening Balance</th>
                                    <th style="width: 20%;">Produced this Month</th>
                                    <th style="width: 20%;">Cleared / Dispatched</th>
                                    <th style="width: 20%;">Closing Balance</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>L-30</td>
                                    <td class="text-end">25,000.00</td>
                                    <td class="text-end">12,500.00</td>
                                    <td class="text-end">10,000.00</td>
                                    <td class="text-end">27,500.00</td>
                                </tr>
                                <tr>
                                    <td>M-30</td>
                                    <td class="text-end">120,000.00</td>
                                    <td class="text-end">90,000.00</td>
                                    <td class="text-end">45,000.00</td>
                                    <td class="text-end">165,000.00</td>
                                </tr>
                                <tr>
                                    <td>S1-30</td>
                                    <td class="text-end">18,000.00</td>
                                    <td class="text-end">15,000.00</td>
                                    <td class="text-end">5,000.00</td>
                                    <td class="text-end">28,000.00</td>
                                </tr>
                                <tr>
                                    <td>Brown Sugar</td>
                                    <td class="text-end">1,200.00</td>
                                    <td class="text-end">1,000.00</td>
                                    <td class="text-end">0.00</td>
                                    <td class="text-end">2,200.00</td>
                                </tr>
                                <tr class="fw-bold bg-light">
                                    <td class="text-end">TOTAL:</td>
                                    <td class="text-end">164,200.00</td>
                                    <td class="text-end">118,500.00</td>
                                    <td class="text-end">60,000.00</td>
                                    <td class="text-end text-primary">222,700.00</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5 pt-3">
                            <div class="col-4 text-center fw-bold mt-5">Chief Chemist<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-4 text-center fw-bold mt-5">Managing Director<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature)</span></div>
                            <div class="col-4 text-center fw-bold mt-5">Inspector, Central Excise<br><span style="font-weight: normal; font-size: 0.85rem;">(Signature & Seal)</span></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>