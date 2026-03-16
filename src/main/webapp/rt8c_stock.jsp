<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Technical Performance | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-blue: #2563eb;
            --sidebar-dark: #1e293b;
            --bg-light: #f1f5f9;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-main);
            font-size: 0.88rem;
        }

        /* Unified App Window */
        .app-window { 
            background: #ffffff; 
            border-radius: 12px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-top: 25px;
            border: none;
        }

        .window-header { 
            background-color: #ffffff; 
            padding: 18px 25px; 
            font-weight: 700; 
            border-bottom: 1px solid var(--border-color); 
            color: var(--text-main);
            display: flex;
            align-items: center;
            letter-spacing: 0.5px;
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Industry Sidebar */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 650px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 12px; 
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1); 
            color: #cbd5e1;
            text-align: left;
            padding: 10px 15px;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            border-radius: 8px;
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            transform: translateX(5px);
        }

        /* Main Analysis Workspace */
        .main-panel { background-color: #ffffff; padding: 30px; }

        .filter-strip {
            background-color: #f8fafc;
            padding: 15px 25px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            margin-bottom: 25px;
        }

        /* Modern Tabs */
        .nav-tabs { border-bottom: 2px solid var(--border-color); }
        .nav-tabs .nav-link { 
            border: none; 
            color: #64748b; 
            font-weight: 600; 
            padding: 12px 25px;
        }
        .nav-tabs .nav-link.active { 
            color: var(--primary-blue); 
            border-bottom: 3px solid var(--primary-blue); 
            background: transparent;
        }

        /* Card Form Styling */
        .form-section { 
            border: 1px solid var(--border-color); 
            padding: 25px; 
            border-radius: 12px; 
            background-color: #ffffff; 
            height: 100%;
            transition: box-shadow 0.3s ease;
        }
        
        .form-section:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.03); }

        .section-title { 
            font-size: 0.75rem; 
            color: #64748b; 
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--border-color); 
            padding-bottom: 10px; 
            margin-bottom: 20px; 
            font-weight: 700; 
            display: flex;
            align-items: center;
        }

        .section-title i { color: var(--primary-blue); margin-right: 8px; }

        .input-label { font-size: 0.8rem; font-weight: 600; color: #475569; }

        .form-control {
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-weight: 600;
            text-align: right;
            color: var(--primary-blue);
        }

        .form-control:focus {
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            border-color: var(--primary-blue);
        }

        .readonly-calc { 
            background-color: #f8fafc !important; 
            border-style: dashed;
            color: #dc2626 !important; /* Visual alert for calculated totals */
        }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Transaction</li>
                    <li class="breadcrumb-item active text-primary">Technical Performance</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-graph-up-arrow"></i> RT-8(C) ANNUAL TECHNICAL PERFORMANCE & FUEL AUDIT
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2"><i class="bi bi-file-earmark-plus"></i> New Record</button>
                    <button type="button" class="btn action-btn"><i class="bi bi-search"></i> Find Record</button>
                    <button type="button" class="btn action-btn"><i class="bi bi-pencil-square"></i> Change</button>
                    <button type="button" class="btn action-btn shadow-sm"><i class="bi bi-cloud-arrow-up-fill"></i> Save Performance</button>
                    <button type="button" class="btn action-btn"><i class="bi bi-x-circle"></i> Cancel</button>
                    <button type="button" class="btn action-btn text-danger"><i class="bi bi-trash3"></i> Delete</button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-auto bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close App
                    </a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <form action="RT8CServlet" method="POST">
                        
                        <div class="filter-strip d-flex align-items-center">
                            <div class="me-4" style="width: 220px;">
                                <label class="small fw-bold text-muted mb-1 d-block text-uppercase">Valuation Date</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="bi bi-calendar-event"></i></span>
                                    <input type="date" class="form-control" name="reportDate" required>
                                </div>
                            </div>
                            <div style="width: 180px;">
                                <label class="small fw-bold text-muted mb-1 d-block text-uppercase">Crushing Season</label>
                                <input type="text" class="form-control form-control-sm bg-light fw-bold" name="seasonYear" value="2025-2026" readonly>
                            </div>
                            <div class="ms-auto text-muted small">
                                <i class="bi bi-info-circle me-1"></i> Form data for seasonal technical efficiency monitoring.
                            </div>
                        </div>

                        <ul class="nav nav-tabs mb-4" id="rt8cTabs" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" id="agri-tab" data-bs-toggle="tab" data-bs-target="#agri" type="button"><i class="bi bi-tree me-2"></i>Agri & Milling Efficiency</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" id="bagasse-tab" data-bs-toggle="tab" data-bs-target="#bagasse" type="button"><i class="bi bi-fuel-pump me-2"></i>Bagasse & Fuel Audit</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="rt8cTabsContent">
                            
                            <div class="tab-pane fade show active" id="agri" role="tabpanel">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="form-section">
                                            <div class="section-title"><i class="bi bi-patch-check"></i>Cane Yield per Hectare (MT)</div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-5 input-label">Adsali Variety</label>
                                                <div class="col-sm-7"><input type="number" step="0.01" class="form-control" name="yieldAdsali" placeholder="0.00"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-5 input-label">Plant Variety</label>
                                                <div class="col-sm-7"><input type="number" step="0.01" class="form-control" name="yieldPlant" placeholder="0.00"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-5 input-label">Ratoon Variety</label>
                                                <div class="col-sm-7"><input type="number" step="0.01" class="form-control" name="yieldRatoon" placeholder="0.00"></div>
                                            </div>
                                            <div class="row mt-4 pt-3 border-top border-light">
                                                <label class="col-sm-5 input-label text-danger">TOTAL AVG YIELD</label>
                                                <div class="col-sm-7"><input type="number" step="0.01" class="form-control readonly-calc" name="yieldTotal" readonly></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-section">
                                            <div class="section-title"><i class="bi bi-gear-wide-connected"></i>Milling Performance</div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Preparatory Index (%)</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="prepIndex" placeholder="0.00"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Added Water % Fiber</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="waterPctFiber" placeholder="0.00"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Bagasse % Cane</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="bagassePctCane" placeholder="0.00"></div>
                                            </div>
                                            <div class="row mb-0 align-items-center">
                                                <label class="col-sm-6 input-label">Filter Cake % Cane</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="fcPctCane" placeholder="0.00"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="bagasse" role="tabpanel">
                                <div class="row g-4">
                                    <div class="col-md-7">
                                        <div class="form-section">
                                            <div class="section-title"><i class="bi bi-calculator"></i>Bagasse Data Balance (MT)</div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Opening Seasonal Balance</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="bagasseOpening"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Produced During Crushing</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="bagasseProduction"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label text-primary">Sugar Plant Boiler Fuel</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="bagasseBoiler"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label text-primary">Co-Generation Unit Fuel</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="bagasseCogen"></div>
                                            </div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Baled Bagasse (Sold/Stock)</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="bagasseSold"></div>
                                            </div>
                                            <div class="row mt-4 pt-3 border-top border-light">
                                                <label class="col-sm-6 input-label text-success fw-bold">TOTAL BAGASSE SAVED (MT)</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control readonly-calc fw-bold text-success" name="bagasseSaved" readonly></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-5">
                                        <div class="form-section">
                                            <div class="section-title"><i class="bi bi-fire"></i>Alternative Fuel Consumption</div>
                                            <div class="row mb-3 align-items-center">
                                                <label class="col-sm-6 input-label">Coal % Cane</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="coalPct"></div>
                                            </div>
                                            <div class="row mb-4 align-items-center">
                                                <label class="col-sm-6 input-label">Firewood % Cane</label>
                                                <div class="col-sm-6"><input type="number" step="0.01" class="form-control" name="firewoodPct"></div>
                                            </div>
                                            
                                            <div class="mt-5 p-3 bg-light rounded border border-warning border-opacity-25 small text-muted">
                                                <i class="bi bi-shield-exclamation text-warning me-2 fs-5"></i>
                                                <strong>VSI Guidelines:</strong> Data must strictly originate from flow meter logs. Estimates for electrical/steam data are prohibited.
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
        // Automatic Calculation Logic for Industry UI
        document.querySelectorAll('input[name="yieldAdsali"], input[name="yieldPlant"], input[name="yieldRatoon"]').forEach(input => {
            input.addEventListener('input', function() {
                const adsali = parseFloat(document.querySelector('input[name="yieldAdsali"]').value) || 0;
                const plant = parseFloat(document.querySelector('input[name="yieldPlant"]').value) || 0;
                const ratoon = parseFloat(document.querySelector('input[name="yieldRatoon"]').value) || 0;
                
                let activeFields = 0;
                if(adsali > 0) activeFields++;
                if(plant > 0) activeFields++;
                if(ratoon > 0) activeFields++;
                
                const yieldTotalField = document.querySelector('input[name="yieldTotal"]');
                if(activeFields > 0) {
                    yieldTotalField.value = ((adsali + plant + ratoon) / activeFields).toFixed(2);
                } else {
                    yieldTotalField.value = '';
                }
            });
        });

        document.querySelectorAll('input[name^="bagasse"]').forEach(input => {
            input.addEventListener('input', function() {
                const opening = parseFloat(document.querySelector('input[name="bagasseOpening"]').value) || 0;
                const prod = parseFloat(document.querySelector('input[name="bagasseProduction"]').value) || 0;
                const boiler = parseFloat(document.querySelector('input[name="bagasseBoiler"]').value) || 0;
                const cogen = parseFloat(document.querySelector('input[name="bagasseCogen"]').value) || 0;
                const sold = parseFloat(document.querySelector('input[name="bagasseSold"]').value) || 0;
                
                const totalSaved = (opening + prod) - (boiler + cogen + sold);
                document.querySelector('input[name="bagasseSaved"]').value = totalSaved.toFixed(2);
            });
        });
    </script>
</body>
</html>