<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="mr" ng-app="mfgShortApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Crushing Report (Marathi) | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="js/reportMfgShort.js"></script>

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
        }

        /* ERP Layout Window */
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
            min-height: 800px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 10px; 
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
            font-size: 0.88rem;
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            transform: translateX(5px);
        }

        /* Main Workspace */
        .main-panel { background-color: var(--bg-light); padding: 30px; }

        /* Report Specific Styling (Maintaining your exact structure) */
        .report-paper { 
            background-color: white; 
            padding: 50px; 
            border: 1px solid #d1d5db; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            margin: 0 auto; 
            max-width: 950px; 
            color: #000;
        }

        .report-title { 
            text-align: center; 
            font-weight: 800; 
            font-size: 1.4rem; 
            margin-bottom: 5px; 
        }

        .report-subtitle { 
            text-align: center; 
            font-weight: 700; 
            font-size: 1.1rem; 
            margin-bottom: 15px; 
        }

        /* Marathi Typography & Numeric Mono-spacing */
        .marathi-text { font-family: 'Mangal', 'Arial Unicode MS', sans-serif; }
        
        .table-report { margin-bottom: 15px; width: 100%; border-collapse: collapse; border: 1.5px solid #000; }
        .table-report th { 
            background-color: #f3f4f6 !important; 
            border: 1px solid #000; 
            text-align: center; 
            padding: 8px; 
            font-size: 0.85rem; 
            font-weight: 800;
        }
        .table-report td { 
            border: 1px solid #000; 
            padding: 6px 12px; 
            font-size: 0.9rem; 
            font-family: 'JetBrains Mono', monospace; /* Professional alignment for numbers */
        }
        
        .text-label { font-family: 'Mangal', sans-serif !important; font-weight: 600; }

        @media print {
            body { background: white; }
            .navbar, .sidebar-panel, .btn-outline-dark, form, .alert { display: none !important; }
            .main-panel { padding: 0; background: white; }
            .app-window { box-shadow: none; margin: 0; border: none; }
            .window-header { display: none; }
            .report-paper { box-shadow: none; border: none; padding: 20px; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body ng-controller="MfgShortController">
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mt-3 mb-1">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small fw-bold">
                    <li class="breadcrumb-item"><a href="dashboard.jsp" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active text-muted">Marathi Reports</li>
                    <li class="breadcrumb-item active text-primary">Daily Crushing Short</li>
                </ol>
            </nav>
        </div>

        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-file-earmark-text-fill"></i> DAILY MANUFACTURING SHORT (MARATHI) REPORT ENGINE
            </div>
            
            <div class="row m-0 p-0">
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2 text-white" ng-click="printReport()">
                        <i class="bi bi-printer-fill text-info"></i> Print Report
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-file-earmark-pdf-fill text-danger"></i> Export to PDF
                    </button>
                    <button type="button" class="btn action-btn">
                        <i class="bi bi-file-earmark-excel-fill text-success"></i> Export to Excel
                    </button>
                    
                    <a href="dashboard.jsp" class="btn action-btn mt-5 bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                        <i class="bi bi-power"></i> Close Engine
                    </a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <form name="searchForm" class="mb-5 bg-white p-4 border rounded shadow-sm w-75 mx-auto" novalidate>
                        <div class="row align-items-center justify-content-center">
                            <label class="col-auto fw-bold text-muted text-uppercase small">Select Report Date:</label>
                            <div class="col-auto">
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white border-secondary"><i class="bi bi-calendar3"></i></span>
                                    <input type="date" class="form-control border-secondary" ng-model="selectedDate" required>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm" ng-click="generateReport()">
                                    <i class="bi bi-gear-wide-connected me-2"></i>GENERATE
                                </button>
                            </div>
                        </div>
                    </form>

                    <div id="printableArea" class="report-paper marathi-text shadow" ng-show="isDataLoaded">
                        <div class="text-center border-bottom border-3 border-dark mb-4 pb-2">
                            <h3 class="report-title">श्री. छत्रपती सहकारी साखर कारखाना लि., भवानीनगर, ता. इंदापूर जि. पुणे.</h3>
                            <h5 class="report-subtitle">डेली क्रशींग रिपोर्ट <br> (एकत्रीत संक्षिप्त अहवाल)</h5>
                        </div>
                        
                        <div class="row mb-3" style="font-size: 0.95rem; font-weight: bold;">
                            <div class="col-4">क्रॉपडे : <span class="text-primary">{{ reportData.cropDay }}</span></div>
                            <div class="col-4 text-center">हंगाम २०२५-२०२६</div>
                            <div class="col-4 text-end">दिनांक : {{ displayDate }}</div>
                        </div>

                        <table class="table table-report table-sm mb-4">
                            <thead>
                                <tr>
                                    <th rowspan="2" style="width: 5%;">अ. न.</th>
                                    <th rowspan="2" style="width: 25%;">तपशील</th>
                                    <th rowspan="2" style="width: 15%;">आज</th>
                                    <th colspan="2" style="width: 30%;">हंगाम २०२५-२०२६</th>
                                    <th colspan="2" style="width: 25%;">मागील हंगाम २०२४-२०२५</th>
                                </tr>
                                <tr>
                                    <th>आजपर्यंत</th>
                                    <th>%</th>
                                    <th>आज</th>
                                    <th>आजपर्यंत</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center" rowspan="5" style="vertical-align: top;">१.</td>
                                    <td class="text-label bg-light">ऊस गळीत (मे. टन)</td>
                                    <td class="bg-light"></td><td class="bg-light"></td><td class="bg-light"></td><td class="bg-light"></td><td class="bg-light"></td>
                                </tr>
                                <tr>
                                    <td class="text-label" style="padding-left: 20px;">सभासद</td>
                                    <td class="text-end fw-bold">{{ reportData.caneMemberToday | number:3 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ reportData.caneMemberTodate | number:3 }}</td>
                                    <td></td><td class="text-end">-</td><td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td class="text-label" style="padding-left: 20px;">बि. सभासद</td>
                                    <td class="text-end fw-bold">{{ reportData.caneNonMemberToday | number:3 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ reportData.caneNonMemberTodate | number:3 }}</td>
                                    <td></td><td class="text-end">-</td><td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td class="text-label" style="padding-left: 20px;">इतर</td>
                                    <td class="text-end fw-bold">{{ reportData.caneOtherToday | number:3 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ reportData.caneOtherTodate | number:3 }}</td>
                                    <td></td><td class="text-end">-</td><td class="text-end">-</td>
                                </tr>
                                <tr class="bg-light">
                                    <td class="text-label fw-bold" style="padding-left: 20px;">एकूण</td>
                                    <td class="text-end fw-bold">{{ reportData.caneTotalToday | number:3 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ reportData.caneTotalTodate | number:3 }}</td>
                                    <td></td><td class="text-end fw-bold">-</td><td class="text-end fw-bold">-</td>
                                </tr>

                                <tr>
                                    <td class="text-center" rowspan="7" style="vertical-align: top;">२.</td>
                                    <td class="text-label bg-light">साखर पोती (क्विंटल)</td>
                                    <td class="bg-light"></td><td class="bg-light"></td><td class="bg-light"></td><td class="bg-light"></td><td class="bg-light"></td>
                                </tr>
                                <tr>
                                    <td class="text-label" style="padding-left: 20px;">एल-३०</td>
                                    <td class="text-end">{{ reportData.sugarL30Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarL30Todate | number:2 }}</td>
                                    <td></td><td class="text-end">-</td><td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td class="text-label" style="padding-left: 20px;">एम-३०</td>
                                    <td class="text-end">{{ reportData.sugarM30Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarM30Todate | number:2 }}</td>
                                    <td></td><td class="text-end">-</td><td class="text-end">-</td>
                                </tr>
                                <tr>
                                    <td class="text-label" style="padding-left: 20px;">एस १-३०</td>
                                    <td class="text-end">{{ reportData.sugarS130Today | number:2 }}</td>
                                    <td class="text-end">{{ reportData.sugarS130Todate | number:2 }}</td>
                                    <td></td><td class="text-end">-</td><td class="text-end">-</td>
                                </tr>
                                <tr class="bg-light">
                                    <td class="text-label fw-bold" style="padding-left: 20px;">एकूण</td>
                                    <td class="text-end fw-bold">{{ reportData.sugarTotalToday | number:2 }}</td>
                                    <td class="text-end fw-bold text-primary">{{ reportData.sugarTotalTodate | number:2 }}</td>
                                    <td></td><td class="text-end fw-bold">-</td><td class="text-end fw-bold">-</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="row mt-5 pt-5">
                            <div class="col-4 text-center">
                                <div style="border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto;"></div>
                                <span class="fw-bold small">लॅब इंचार्ज</span>
                            </div>
                            <div class="col-4 text-center">
                                <div style="border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto;"></div>
                                <span class="fw-bold small">चीफ केमिस्ट</span>
                            </div>
                            <div class="col-4 text-center">
                                <div style="border-top: 1.5px solid #000; width: 80%; margin: 0 auto 5px auto;"></div>
                                <span class="fw-bold small">मॅनेजिंग डायरेक्टर</span>
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-custom w-75 mx-auto text-center border-0 shadow-sm" ng-hide="isDataLoaded" style="background: #eef2ff; color: #4338ca;">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        <strong>अहवाल सूचना:</strong> कृपया तारीख निवडा आणि संक्षिप्त मराठी अहवाल पाहण्यासाठी Generate वर क्लिक करा.
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>