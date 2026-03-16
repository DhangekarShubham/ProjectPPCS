<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="batchProcessApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Execution | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/batchProcess.js"></script>

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
            font-size: 0.9rem;
        }

        /* App Window Layout */
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
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Industry Sidebar */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 500px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 12px; 
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1); 
            color: #cbd5e1;
            text-align: left;
            padding: 12px 15px;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            border-radius: 8px;
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover:not(:disabled) { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            transform: translateX(5px);
        }

        .action-btn:disabled { opacity: 0.5; cursor: not-allowed; }

        /* Main Processing Area */
        .main-panel { background-color: #ffffff; padding: 40px; }

        .process-card { 
            background: #ffffff; 
            border: 1px solid var(--border-color); 
            border-radius: 12px; 
            padding: 35px; 
            max-width: 650px; 
            margin: 0 auto;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        }

        .input-label { 
            font-size: 0.8rem; 
            font-weight: 700; 
            color: #64748b; 
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
            display: block;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #d1d5db;
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            border-color: var(--primary-blue);
        }

        /* Modern Progress Bar */
        .progress {
            height: 12px;
            background-color: #e2e8f0;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .progress-bar {
            background-color: var(--primary-blue);
            transition: width 0.4s ease;
        }

        .status-badge {
            font-size: 0.75rem;
            padding: 5px 12px;
            border-radius: 20px;
            background: #eff6ff;
            color: var(--primary-blue);
            font-weight: 600;
        }
    </style>
</head>
<body ng-controller="BatchProcessController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Master</li>
                    <li class="breadcrumb-item active">Batch Execution</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-cpu-fill"></i> SYSTEM ENGINE - MULTIPLE DAY BATCH PROCESS
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2" ng-click="executeProcess()" ng-disabled="isProcessing">
                        <i class="bi bi-play-circle-fill"></i> Run Process
                    </button>
                    <button type="button" class="btn action-btn" ng-click="resetForm()" ng-disabled="isProcessing">
                        <i class="bi bi-x-circle"></i> Cancel
                    </button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-5 bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close App
                    </a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <div class="process-card">
                        <div class="text-center mb-4">
                            <h5 class="fw-bold mb-1">Recalculation Engine</h5>
                            <p class="text-muted small">Select a period and module to refresh system calculations</p>
                        </div>

                        <form name="batchForm" novalidate>
                            
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="input-label">From Date</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="bi bi-calendar-event text-muted"></i></span>
                                        <input type="date" class="form-control" ng-model="processReq.fromDate" ng-disabled="isProcessing" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="input-label">To Date</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="bi bi-calendar-check text-muted"></i></span>
                                        <input type="date" class="form-control" ng-model="processReq.toDate" ng-disabled="isProcessing" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label class="input-label">Select Processing Module</label>
                                <select class="form-select" ng-model="processReq.processModule" ng-disabled="isProcessing">
                                    <option value="ALL">Full Recalculation (Global Update)</option>
                                    <option value="CRUSHING">Daily Crushing & Recovery Logs</option>
                                    <option value="STOCK">Inventory & Material Valuation</option>
                                    <option value="LOSSES">Technical Analysis & Losses</option>
                                </select>
                                <div class="mt-2 small text-muted">
                                    <i class="bi bi-info-circle me-1"></i> Running "ALL" will update dependent cumulative figures.
                                </div>
                            </div>

                            <div class="mt-5 pt-4 border-top" ng-show="isProcessing || progressPercentage > 0">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="status-badge">
                                        <i class="bi bi-arrow-repeat spin me-1"></i> {{ statusMessage }}
                                    </span>
                                    <span class="fw-bold text-primary">{{ progressPercentage }}%</span>
                                </div>
                                <div class="progress shadow-sm">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated" 
                                         role="progressbar" 
                                         ng-style="{ 'width': progressPercentage + '%' }">
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-warning mt-4 py-2 border-0 rounded-3 small" ng-if="!isProcessing">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                Note: This process may take several minutes depending on the date range.
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>