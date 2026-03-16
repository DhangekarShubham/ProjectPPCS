<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="stoppageApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reason of Stoppage | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/stoppageReason.js"></script>

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
        
        .window-header i { color: #dc2626; margin-right: 12px; }

        /* Sidebar Styling */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 600px; 
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

        .entry-card {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            max-width: 850px;
        }

        .input-label { 
            font-size: 0.8rem; 
            font-weight: 700; 
            color: #64748b; 
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control, .form-select {
            border-radius: 6px;
            border: 1px solid #d1d5db;
            padding: 8px 12px;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        .readonly-id {
            background-color: #f8fafc !important;
            color: var(--primary-blue);
            font-weight: 700;
            border-style: dashed;
        }

        .info-note {
            background-color: #fffbeb;
            border: 1px solid #fde68a;
            color: #92400e;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 0.85rem;
        }
    </style>
</head>
<body ng-controller="StoppageController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Transaction</li>
                    <li class="breadcrumb-item active">Reason of Stoppage</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-exclamation-octagon-fill"></i> DOWNTIME LOG - REASON OF STOPPAGE
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">
                        <i class="bi bi-file-earmark-plus"></i> New Log
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
                        <i class="bi bi-power"></i> Close App
                    </a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <form name="stoppageForm" novalidate class="entry-card">
                        
                        <div class="row mb-4">
                            <div class="col-md-5">
                                <label class="input-label mb-2 d-block">Stoppage Reference No.</label>
                                <input type="text" class="form-control readonly-id" ng-model="stoppage.stoppageId" readonly placeholder="[SYSTEM GENERATED]">
                            </div>
                            <div class="col-md-5 offset-md-1">
                                <label class="input-label mb-2 d-block">Stoppage Date</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-calendar-x text-danger"></i></span>
                                    <input type="date" class="form-control" ng-model="stoppage.stoppageDate" required>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-5">
                                <label class="input-label mb-2 d-block">Total Downtime (Hours)</label>
                                <div class="input-group">
                                    <input type="number" step="0.01" class="form-control" ng-model="stoppage.totalTime" placeholder="0.00">
                                    <span class="input-group-text bg-light">DECIMAL HR</span>
                                </div>
                            </div>
                            <div class="col-md-6 offset-md-1 d-flex align-items-center">
                                <div class="info-note">
                                    <i class="bi bi-info-circle-fill me-2"></i> Use decimal for minutes (e.g., 1 hr 15 min = 1.25).
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 opacity-50">

                        <div class="mb-4">
                            <label class="input-label mb-2 d-block">Stoppage Reason (English Description)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-chat-left-text text-muted"></i></span>
                                <input type="text" class="form-control" ng-model="stoppage.reasonEng" placeholder="Describe the cause of stoppage...">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="input-label mb-2 d-block">Stoppage Reason (मराठीत कारण)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-translate text-muted"></i></span>
                                <input type="text" class="form-control" ng-model="stoppage.reasonMar" placeholder="येथे मराठीत कारण लिहा...">
                            </div>
                        </div>

                        <div class="mb-2">
                            <label class="input-label mb-2 d-block">Operational Category</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-tags text-primary"></i></span>
                                <select class="form-select" ng-model="stoppage.categoryCode">
                                    <option value="" disabled selected>-- Select Downtime Category --</option>
                                    <option value="MECHANICAL">Mechanical (Equipment Failure)</option>
                                    <option value="ELECTRICAL">Electrical (Power/Motor Issue)</option>
                                    <option value="PROCESS">Process (Cleaning/Boiling)</option>
                                    <option value="CANE_SHORTAGE">Cane Supply Shortage</option>
                                    <option value="RAIN">Weather / Rain Impact</option>
                                    <option value="MISC">Miscellaneous</option>
                                </select>
                            </div>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>