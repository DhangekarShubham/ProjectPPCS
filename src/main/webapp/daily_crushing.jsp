<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="crushingApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Crushing Data | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/dailyCrushing.js"></script>

    <style>
        :root {
            --primary-blue: #2563eb;
            --sidebar-dark: #1e293b;
            --bg-light: #f1f5f9;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
            --calc-bg: #f8fafc;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-main);
            font-size: 0.9rem;
        }

        /* App Window Styling */
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

        /* Sidebar Styling */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 550px; 
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

        /* Main Form Panel */
        .main-panel { background-color: #ffffff; padding: 40px; }

        .data-entry-card {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        }

        .input-label { 
            font-size: 0.8rem; 
            font-weight: 700; 
            color: #64748b; 
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .column-heading {
            font-size: 0.75rem;
            font-weight: 800;
            color: var(--primary-blue);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 2px solid #eff6ff;
        }

        .form-control {
            border-radius: 6px;
            border: 1px solid #d1d5db;
            padding: 8px 12px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        /* Calculated Field Styling */
        .readonly-calc {
            background-color: var(--calc-bg) !important;
            color: var(--primary-blue);
            border-style: dashed;
            cursor: not-allowed;
        }

        .percent-calc {
            color: #dc2626; /* Red for percentage highlights */
        }

        .date-section {
            background: #f8fafc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            border: 1px solid var(--border-color);
        }
    </style>
</head>
<body ng-controller="CrushingController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Transaction</li>
                    <li class="breadcrumb-item active">Daily Crushing</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-speedometer2"></i> DAILY CRUSHING & PRODUCTION LOG
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">
                        <i class="bi bi-file-earmark-plus"></i> New
                    </button>
                    <button type="button" class="btn action-btn" ng-click="findData()">
                        <i class="bi bi-search"></i> Find
                    </button>
                    <button type="button" class="btn action-btn" ng-click="saveData('update')">
                        <i class="bi bi-pencil-square"></i> Change
                    </button>
                    <button type="button" class="btn action-btn" ng-click="saveData('save')">
                        <i class="bi bi-floppy-fill"></i> Save
                    </button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()">
                        <i class="bi bi-x-circle"></i> Cancel
                    </button>
                    <button type="button" class="btn action-btn" ng-click="deleteData()">
                        <i class="bi bi-trash"></i> Delete
                    </button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-auto bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close Log
                    </a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <form name="crushForm" novalidate class="mx-auto" style="max-width: 900px;">
                        
                        <div class="date-section row shadow-sm align-items-center">
                            <div class="col-md-6">
                                <label class="input-label mb-2 d-block">Crushing Date</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-calendar-check text-primary"></i></span>
                                    <input type="date" class="form-control" ng-model="crushing.crushDate" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="input-label mb-2 d-block">Crop Day Number</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-hash text-primary"></i></span>
                                    <input type="number" class="form-control" ng-model="crushing.cropDay" placeholder="e.g. 45" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="data-entry-card">
                            <div class="row mb-4">
                                <div class="col-sm-4"></div>
                                <div class="col-sm-4 text-center">
                                    <div class="column-heading">Current (On Date)</div>
                                </div>
                                <div class="col-sm-4 text-center">
                                    <div class="column-heading">Cumulative (To Date)</div>
                                </div>
                            </div>
                            
                            <div class="row mb-4 align-items-center">
                                <div class="col-sm-4">
                                    <label class="input-label"><i class="bi bi-truck me-2"></i>Cane Crushed (MT)</label>
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" step="0.001" class="form-control text-end" ng-model="crushing.caneOnDate" placeholder="0.000">
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" step="0.001" class="form-control text-end readonly-calc" ng-model="crushing.caneToDate" readonly>
                                </div>
                            </div>
                            
                            <div class="row mb-4 align-items-center">
                                <div class="col-sm-4">
                                    <label class="input-label"><i class="bi bi-box-seam me-2"></i>Sugar Produced (Qtls)</label>
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" step="0.001" class="form-control text-end" ng-model="crushing.sugarOnDate" placeholder="0.000">
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" step="0.001" class="form-control text-end readonly-calc" ng-model="crushing.sugarToDate" readonly>
                                </div>
                            </div>
                            
                            <hr class="my-4 opacity-50">

                            <div class="row mb-2 align-items-center">
                                <div class="col-sm-4">
                                    <label class="input-label"><i class="bi bi-percent me-2"></i>Avg Sugar Recovery</label>
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" step="0.01" class="form-control text-end" ng-model="crushing.percentOnDate" placeholder="0.00">
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" step="0.01" class="form-control text-end readonly-calc percent-calc" ng-model="crushing.percentToDate" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 p-3 border rounded bg-light small text-muted">
                            <i class="bi bi-info-circle-fill me-2 text-primary"></i>
                            <strong>Note:</strong> Cumulative "To Date" values are automatically calculated based on previous records for the current season.
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>