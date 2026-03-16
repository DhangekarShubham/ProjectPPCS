<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="stockApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Material Stock | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/materialStock.js"></script>

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
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

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
        .main-panel { background-color: #ffffff; padding: 30px; }

        .date-picker-card {
            background-color: #f8fafc;
            padding: 15px 25px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            margin-bottom: 25px;
        }

        /* Table Design */
        .table-container { 
            background-color: white; 
            border: 1px solid var(--border-color); 
            border-radius: 10px;
            height: 450px; 
            overflow-y: auto; 
            box-shadow: 0 4px 10px rgba(0,0,0,0.02);
        }

        .table thead th { 
            background-color: #f8fafc; 
            border-bottom: 2px solid var(--border-color);
            color: #64748b;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 12px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .table tbody td { padding: 12px 15px; vertical-align: middle; border-color: #f1f5f9; }

        .material-name { font-weight: 600; color: #334155; }

        .stock-input {
            border-radius: 6px;
            border: 1px solid #d1d5db;
            text-align: right;
            font-weight: 600;
            color: var(--primary-blue);
            transition: all 0.2s;
        }

        .stock-input:focus {
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            border-color: var(--primary-blue);
            background-color: #eff6ff;
        }

        .stock-input[readonly] {
            background-color: #f1f5f9;
            color: #94a3b8;
            border-style: dashed;
        }

        /* Custom Scrollbar */
        .table-container::-webkit-scrollbar { width: 8px; }
        .table-container::-webkit-scrollbar-track { background: #f1f5f9; }
        .table-container::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
    </style>
</head>
<body ng-controller="StockController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Transaction</li>
                    <li class="breadcrumb-item active">Material Stock</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-box-seam-fill"></i> MATERIAL INVENTORY & STOCK ENTRY
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn mt-2" ng-click="clearForm()">
                        <i class="bi bi-plus-lg"></i> New Entry
                    </button>
                    <button type="button" class="btn action-btn" ng-click="findData()">
                        <i class="bi bi-search"></i> Find Record
                    </button>
                    <button type="button" class="btn action-btn" ng-click="saveData('update')">
                        <i class="bi bi-pencil-square"></i> Change
                    </button>
                    <button type="button" class="btn action-btn" ng-click="saveData('save')">
                        <i class="bi bi-cloud-arrow-up-fill"></i> Save Stock
                    </button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()">
                        <i class="bi bi-x-circle"></i> Cancel
                    </button>
                    <button type="button" class="btn action-btn" ng-click="deleteData()">
                        <i class="bi bi-trash3"></i> Delete
                    </button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-auto bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close App
                    </a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <form name="stockForm" novalidate>
                        
                        <div class="date-picker-card d-flex align-items-center shadow-sm">
                            <i class="bi bi-calendar-check me-3 text-primary fs-5"></i>
                            <div style="width: 250px;">
                                <label class="small fw-bold text-muted mb-1 d-block">Stock Valuation Date</label>
                                <input type="date" class="form-control" ng-model="sampleDate" required>
                            </div>
                            <div class="ms-4 text-muted small">
                                <i class="bi bi-info-circle me-1"></i> Ensure all quantities are verified against physical ledger.
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-lg-10">
                                <div class="table-container shadow-sm">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 40%;">Material / Product Name</th>
                                                <th style="width: 30%;" class="text-end">Quantity (Qtls)</th>
                                                <th style="width: 30%;" class="text-end">Volume (HL)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in stockList">
                                                <td class="material-name">
                                                    <i class="bi bi-tag-fill text-muted me-2 small"></i>
                                                    <input type="hidden" ng-model="item.materialId">
                                                    {{ item.materialName }}
                                                </td>
                                                <td>
                                                    <div class="d-flex justify-content-end">
                                                        <input type="number" step="0.01" 
                                                               class="form-control form-control-sm stock-input w-75" 
                                                               ng-model="item.quantity" 
                                                               ng-readonly="item.materialName.includes('Volume')"
                                                               placeholder="{{ item.materialName.includes('Volume') ? '—' : '0.00' }}">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex justify-content-end">
                                                        <input type="number" step="0.01" 
                                                               class="form-control form-control-sm stock-input w-75" 
                                                               ng-model="item.volume" 
                                                               placeholder="0.00">
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="mt-3 p-3 bg-light rounded border d-flex align-items-center">
                                    <i class="bi bi-shield-check text-success fs-4 me-3"></i>
                                    <span class="small text-secondary">
                                        <strong>Validation Note:</strong> Quantity in Quintals (Qtls) is mandatory for solid materials. Volume in Hectoliters (HL) applies to liquid juice/molasses stock.
                                    </span>
                                </div>
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