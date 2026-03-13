<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RT-8(C) Technical Performance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 600px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 20px; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); }
        .action-btn:hover { background-color: #e2e6ea; }
        
        /* Form & Grid Styling */
        .input-label { font-size: 0.9rem; font-weight: bold; color: #333; }
        .form-section { background-color: rgba(255,255,255,0.7); border: 1px solid #999; padding: 15px; border-radius: 5px; height: 100%; }
        .section-title { font-size: 0.95rem; color: #000080; border-bottom: 2px solid #999; padding-bottom: 5px; margin-bottom: 15px; font-weight: bold; }
        
        /* Tabs Styling */
        .nav-tabs .nav-link { background-color: #f0f0f0; color: #333; border: 1px solid #999; margin-right: 2px; font-weight: bold; }
        .nav-tabs .nav-link.active { background-color: #fff; color: #b22222; border-bottom-color: transparent; }
        .tab-content { background-color: #fff; padding: 20px; border: 1px solid #999; border-top: none; min-height: 420px; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">RT-8(C) TECHNICAL PERFORMANCE ENTRY</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2">New</button>
                    <button type="button" class="btn action-btn">Find</button>
                    <button type="button" class="btn action-btn">Change</button>
                    <button type="button" class="btn action-btn">Save</button>
                    <button type="button" class="btn action-btn">Cancel</button>
                    <button type="button" class="btn action-btn">Delete</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    <form action="RT8CServlet" method="POST">
                        
                        <div class="row mb-3 align-items-center bg-white p-2 border rounded shadow-sm mx-0">
                            <label class="col-auto fw-bold text-dark mb-0">Report Date:</label>
                            <div class="col-auto">
                                <input type="date" class="form-control form-control-sm" name="reportDate" required>
                            </div>
                            <label class="col-auto fw-bold text-dark mb-0 ms-4">Season Year:</label>
                            <div class="col-auto">
                                <input type="text" class="form-control form-control-sm" name="seasonYear" value="2025-2026" readonly>
                            </div>
                        </div>

                        <ul class="nav nav-tabs" id="rt8cTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="agri-tab" data-bs-toggle="tab" data-bs-target="#agri" type="button" role="tab">Agri & Milling Stats</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="bagasse-tab" data-bs-toggle="tab" data-bs-target="#bagasse" type="button" role="tab">Bagasse Balance & Fuel</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="rt8cTabsContent">
                            
                            <div class="tab-pane fade show active" id="agri" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-section shadow-sm">
                                            <div class="section-title">Average Yield of Cane Per Hectare (MT)</div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-5 text-end input-label">Adsali</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control form-control-sm" name="yieldAdsali"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-5 text-end input-label">Plant</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control form-control-sm" name="yieldPlant"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-5 text-end input-label">Ratoon</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control form-control-sm" name="yieldRatoon"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center mt-3">
                                                <label class="col-sm-5 text-end input-label text-danger">Total Average Yield</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control form-control-sm bg-light" name="yieldTotal" readonly></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-section shadow-sm">
                                            <div class="section-title">Milling Performance Parameters</div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Average Preparatory Index</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="prepIndex"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Added Water % Fiber</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="waterPctFiber"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Bagasse % Cane</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="bagassePctCane"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Filter Cake % Cane</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="fcPctCane"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="bagasse" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-7">
                                        <div class="form-section shadow-sm">
                                            <div class="section-title">Bagasse Data Balance (MT)</div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Opening Balance (Start of Season)</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="bagasseOpening"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Production During Season</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="bagasseProduction"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label text-primary">Used in Sugar Plant Boiler</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="bagasseBoiler"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label text-primary">Used in Co-Generation Unit</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="bagasseCogen"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Baled Bagasse Sold</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="bagasseSold"></div>
                                            </div>
                                            <hr class="my-2">
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label text-success">Total Bagasse Saved</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm bg-light fw-bold" name="bagasseSaved" readonly placeholder="Auto-Calculated"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-5">
                                        <div class="form-section shadow-sm">
                                            <div class="section-title">Alternative Fuel Consumption</div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Coal % Cane</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="coalPct"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center">
                                                <label class="col-sm-6 text-end input-label">Firewood % Cane</label>
                                                <div class="col-sm-5"><input type="number" step="0.01" class="form-control form-control-sm" name="firewoodPct"></div>
                                            </div>
                                            <div class="row mb-2 align-items-center mt-5">
                                                <div class="col-12 text-center text-muted" style="font-size: 0.85rem;">
                                                    <i>*Note: Ensure all electrical and steam data is entered strictly from flow meter readings, not estimates, as per VSI guidelines.</i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Calculate Total Yield
        document.querySelectorAll('input[name="yieldAdsali"], input[name="yieldPlant"], input[name="yieldRatoon"]').forEach(input => {
            input.addEventListener('input', function() {
                const adsali = parseFloat(document.querySelector('input[name="yieldAdsali"]').value) || 0;
                const plant = parseFloat(document.querySelector('input[name="yieldPlant"]').value) || 0;
                const ratoon = parseFloat(document.querySelector('input[name="yieldRatoon"]').value) || 0;
                
                // Assuming simple average for UI purposes (Actual backend might require weighted average based on area)
                let activeFields = 0;
                if(adsali > 0) activeFields++;
                if(plant > 0) activeFields++;
                if(ratoon > 0) activeFields++;
                
                if(activeFields > 0) {
                    document.querySelector('input[name="yieldTotal"]').value = ((adsali + plant + ratoon) / activeFields).toFixed(2);
                } else {
                    document.querySelector('input[name="yieldTotal"]').value = '';
                }
            });
        });

        // Calculate Bagasse Saved (Production + Opening) - (Boiler + Cogen + Sold)
        document.querySelectorAll('input[name^="bagasse"]').forEach(input => {
            input.addEventListener('input', function() {
                const opening = parseFloat(document.querySelector('input[name="bagasseOpening"]').value) || 0;
                const production = parseFloat(document.querySelector('input[name="bagasseProduction"]').value) || 0;
                const boiler = parseFloat(document.querySelector('input[name="bagasseBoiler"]').value) || 0;
                const cogen = parseFloat(document.querySelector('input[name="bagasseCogen"]').value) || 0;
                const sold = parseFloat(document.querySelector('input[name="bagasseSold"]').value) || 0;
                
                const totalAvailable = opening + production;
                const totalUsed = boiler + cogen + sold;
                
                document.querySelector('input[name="bagasseSaved"]').value = (totalAvailable - totalUsed).toFixed(2);
            });
        });
    </script>
</body>
</html>