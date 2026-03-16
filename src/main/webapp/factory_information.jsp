<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="factoryApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Factory Information | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/factory_information.js"></script>

    <style>
        :root {
            --primary-blue: #2563eb;
            --bg-light: #f1f5f9;
            --card-border: #e2e8f0;
            --text-dark: #1e293b;
            --sidebar-dark: #1e293b;
            --input-focus: #3b82f6;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-dark);
            font-size: 0.9rem;
        }

        /* App Container Layout */
        .app-window { 
            background: #ffffff; 
            border: none;
            border-radius: 12px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-top: 20px;
        }

        .window-header { 
            background-color: #ffffff; 
            padding: 15px 25px; 
            font-weight: 700; 
            border-bottom: 1px solid var(--card-border); 
            color: var(--text-dark);
            display: flex;
            align-items: center;
        }

        .window-header i { color: var(--primary-blue); margin-right: 10px; }

        /* Sidebar Branding */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 700px; 
        }

        /* Action Buttons */
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
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            border-color: var(--primary-blue);
            transform: translateX(5px);
        }

        .btn-close-app { background: #ef4444 !important; color: white !important; margin-top: 40px; }

        /* Form Styling */
        .main-panel { background-color: #ffffff; padding: 30px; }

        .form-section { 
            border: 1px solid var(--card-border); 
            padding: 20px; 
            border-radius: 8px; 
            background-color: #ffffff; 
            margin-bottom: 20px; 
            transition: border 0.3s ease;
        }
        
        .form-section:hover { border-color: #cbd5e1; }

        .section-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 15px;
            letter-spacing: 0.5px;
            display: block;
        }

        .input-label { 
            font-size: 0.8rem; 
            font-weight: 600; 
            color: #475569; 
            margin-bottom: 4px;
        }

        .form-control-sm {
            border-radius: 6px;
            border: 1px solid #d1d5db;
            padding: 0.5rem 0.75rem;
            transition: all 0.2s ease;
        }

        .form-control-sm:focus {
            border-color: var(--input-focus);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        /* Search Footer */
        .search-strip {
            background-color: #f8fafc;
            border-top: 1px solid var(--card-border);
            padding: 20px;
            border-radius: 0 0 12px 12px;
        }

        .btn-search {
            background-color: var(--primary-blue);
            color: white;
            font-weight: 600;
            border: none;
        }

        .btn-search:hover { background-color: #1d4ed8; color: white; }
    </style>
</head>
<body ng-controller="FactoryInfoController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active">Master</li>
                    <li class="breadcrumb-item active">Factory Information</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-building-gear"></i> LAB FACTORY INFORMATION MASTER
            </div>

            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn" ng-click="clearForm()"><i class="bi bi-file-earmark-plus"></i> New</button>
                    <button type="button" class="btn action-btn" ng-click="findFactory(factory.seasonYear)"><i class="bi bi-search"></i> Find</button>
                    <button type="button" class="btn action-btn" ng-click="updateFactory()"><i class="bi bi-pencil-square"></i> Change</button>
                    <button type="button" class="btn action-btn" ng-click="saveFactory()"><i class="bi bi-floppy"></i> Save</button>
                    <button type="button" class="btn action-btn" ng-click="clearForm()"><i class="bi bi-x-circle"></i> Cancel</button>
                    <button type="button" class="btn action-btn" ng-click="deleteFactory()"><i class="bi bi-trash"></i> Delete</button>
                    
                    <a href="dashboard.jsp" class="btn action-btn btn-close-app mt-auto"><i class="bi bi-power"></i> Close App</a>
                </div>

                <div class="flex-grow-1 main-panel">
                    <form name="factoryForm" novalidate>
                        
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-section">
                                    <span class="section-title">General Information</span>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="input-label">Season Year</label>
                                            <input type="text" class="form-control form-control-sm" ng-model="factory.seasonYear" placeholder="e.g., 2025-2026" required>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="input-label">Start Date</label>
                                            <input type="date" class="form-control form-control-sm" ng-model="factory.startDate">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="input-label">Start Time</label>
                                            <input type="time" class="form-control form-control-sm" ng-model="factory.startTime">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="input-label">Factory Name</label>
                                        <input type="text" class="form-control form-control-sm" ng-model="factory.factoryName">
                                    </div>
                                    <div class="mb-3">
                                        <label class="input-label">Complete Address</label>
                                        <input type="text" class="form-control form-control-sm" ng-model="factory.address">
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4"><label class="input-label">Taluka</label><input type="text" class="form-control form-control-sm" ng-model="factory.taluka"></div>
                                        <div class="col-md-4"><label class="input-label">District</label><input type="text" class="form-control form-control-sm" ng-model="factory.district"></div>
                                        <div class="col-md-4"><label class="input-label">PIN Code</label><input type="text" class="form-control form-control-sm" ng-model="factory.pinCode"></div>
                                    </div>
                                    <div class="row mb-1">
                                        <div class="col-md-6"><label class="input-label">E-Mail</label><input type="email" class="form-control form-control-sm" ng-model="factory.email"></div>
                                        <div class="col-md-6"><label class="input-label">Website</label><input type="url" class="form-control form-control-sm" ng-model="factory.website"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-5">
                                <div class="form-section">
                                    <span class="section-title">Regulatory & Technical</span>
                                    <div class="mb-2">
                                        <label class="input-label">Clarification Process</label>
                                        <input type="text" class="form-control form-control-sm" ng-model="factory.clarificationProcess">
                                    </div>
                                    <div class="mb-2">
                                        <label class="input-label">GST Registration No.</label>
                                        <input type="text" class="form-control form-control-sm" ng-model="factory.gstNo">
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-6"><label class="input-label">Division</label><input type="text" class="form-control form-control-sm" ng-model="factory.division"></div>
                                        <div class="col-6"><label class="input-label">Range</label><input type="text" class="form-control form-control-sm" ng-model="factory.range"></div>
                                    </div>
                                    <div class="mb-0">
                                        <label class="input-label">Installed Capacity (TCD)</label>
                                        <input type="number" step="0.01" class="form-control form-control-sm" ng-model="factory.installedCapacity">
                                    </div>
                                </div>
                                
                                <div class="form-section">
                                    <span class="section-title">Key Personnel</span>
                                    <div class="row mb-2">
                                        <div class="col-6"><label class="input-label">Managing Director</label><input type="text" class="form-control form-control-sm" ng-model="factory.managingDirector"></div>
                                        <div class="col-6"><label class="input-label">Works Manager</label><input type="text" class="form-control form-control-sm" ng-model="factory.worksManager"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6"><label class="input-label">Chief Chemist</label><input type="text" class="form-control form-control-sm" ng-model="factory.chiefChemist"></div>
                                        <div class="col-6"><label class="input-label">Lab Incharge</label><input type="text" class="form-control form-control-sm" ng-model="factory.labIncharge"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="search-strip row align-items-center">
                            <div class="col-md-4 text-end text-muted small fw-bold">QUICK SEASON LOOKUP:</div>
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-calendar3"></i></span>
                                    <input type="text" class="form-control border-start-0" placeholder="Enter Year..." ng-model="searchSeasonYear">
                                    <button class="btn btn-search px-4" type="button" ng-click="findFactory(searchSeasonYear)">FIND</button>
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