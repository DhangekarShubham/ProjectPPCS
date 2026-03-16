<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #6366f1;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
        }

        body { 
            background-color: var(--bg-color); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-main);
            margin: 0;
        }

        /* Modern Hero Section */
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, #1a252f 100%);
            padding: 80px 0 120px 0;
            color: white;
            border-radius: 0 0 50px 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .factory-title { 
            font-weight: 700;
            letter-spacing: -1px;
            text-transform: uppercase;
            font-size: 2.2rem;
        }

        .badge-module {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255,255,255,0.3);
            padding: 8px 20px;
            border-radius: 50px;
            font-size: 0.9rem;
            text-transform: uppercase;
            font-weight: 600;
            display: inline-block;
            margin-top: 15px;
        }

        /* Interactive Dashboard Cards */
        .stats-container {
            margin-top: -60px;
        }

        .custom-card {
            background: var(--card-bg);
            border: none;
            border-radius: 16px;
            padding: 30px 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            height: 100%;
            display: block;
            text-decoration: none !important;
        }

        .custom-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border-bottom: 4px solid var(--accent-color);
        }

        .icon-box {
            width: 60px;
            height: 60px;
            background: #eef2ff;
            color: var(--accent-color);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            margin: 0 auto 20px auto;
            font-size: 1.8rem;
        }

        .card-title {
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .card-desc {
            font-size: 0.9rem;
            color: var(--text-muted);
            line-height: 1.4;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <header class="hero-section text-center">
        <div class="container">
            <h1 class="factory-title">Shri. Chhatrapati S.S.K. Ltd.</h1>
            <p class="opacity-75">Bhavaninagar, Maharashtra</p>
            <div class="badge-module">
                <i class="bi bi-cpu-fill me-2"></i> Chemical Control Module
            </div>
            <div class="mt-3 text-white-50 small">System: Sugar Chemical Mill 1</div>
        </div>
    </header>

    <main class="container stats-container">
        <div class="row g-4 justify-content-center">
            
            <div class="col-md-3">
                <a href="factoryMaster.jsp" class="custom-card text-center">
                    <div class="icon-box">
                        <i class="bi bi-building"></i>
                    </div>
                    <h5 class="card-title">Factory Master</h5>
                    <p class="card-desc">Configure factory settings, seasons, and capacities.</p>
                </a>
            </div>

            <div class="col-md-3">
                <a href="dailyAnalysis.jsp" class="custom-card text-center">
                    <div class="icon-box">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                    <h5 class="card-title">Daily Analysis</h5>
                    <p class="card-desc">Record juice analysis, crushing logs, and lab data.</p>
                </a>
            </div>

            <div class="col-md-3">
                <a href="reports.jsp" class="custom-card text-center">
                    <div class="icon-box">
                        <i class="bi bi-file-earmark-bar-graph"></i>
                    </div>
                    <h5 class="card-title">Reports</h5>
                    <p class="card-desc">Generate G-7, technical performance, and shift reports.</p>
                </a>
            </div>

            <div class="col-md-3">
                <div class="custom-card text-center">
                    <div class="icon-box">
                        <i class="bi bi-shield-lock"></i>
                    </div>
                    <h5 class="card-title">Security</h5>
                    <p class="card-desc">User access control and system audit logs.</p>
                </div>
            </div>

        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>