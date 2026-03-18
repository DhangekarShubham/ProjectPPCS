<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    :root {
        --nav-bg: #1e293b;        /* Deep Slate */
        --nav-accent: #6366f1;    /* Indigo */
        --nav-hover: #334155;     /* Lighter Slate */
        --text-main: #f8fafc;     /* Ghost White */
        --dropdown-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
    }

    /* Navbar Container */
    .nav-custom { 
        background-color: var(--nav-bg) !important; 
        border-bottom: 3px solid var(--nav-accent);
        padding: 0.6rem 1.5rem;
        transition: all 0.3s ease;
    }

    /* Brand/Logo Styling */
    .navbar-brand-custom {
        font-weight: 800;
        letter-spacing: 1px;
        color: var(--text-main) !important;
        text-transform: uppercase;
        font-size: 1.1rem;
    }

    /* Navigation Links */
    .nav-custom .nav-link { 
        color: #94a3b8 !important; /* Soft Muted Blue */
        font-size: 0.9rem;
        padding: 8px 15px !important;
        margin: 0 2px;
        border-radius: 6px;
        transition: all 0.2s ease-in-out;
    }

    .nav-custom .nav-link:hover { 
        color: var(--text-main) !important;
        background-color: var(--nav-hover);
    }

    /* Dropdown Menus */
    .dropdown-menu { 
        border: none;
        background-color: #ffffff;
        box-shadow: var(--dropdown-shadow);
        border-radius: 10px;
        padding: 0.8rem;
        margin-top: 10px !important;
        animation: nav-slide 0.3s ease;
    }

    @keyframes nav-slide {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .dropdown-item {
        border-radius: 6px;
        padding: 8px 15px;
        font-size: 0.88rem;
        color: #475569;
        font-weight: 500;
    }

    .dropdown-item:hover { 
        background-color: #f1f5f9;
        color: var(--nav-accent);
        transform: translateX(5px);
        transition: all 0.2s ease;
    }

    /* Special Items */
    .nav-exit {
        background: rgba(239, 68, 68, 0.1);
        color: #ef4444 !important;
        border-radius: 6px;
    }

    .nav-exit:hover {
        background: #ef4444 !important;
        color: #fff !important;
    }

    /* User Information Badge */
    .user-badge {
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 5px 15px;
        border-radius: 50px;
        color: #cbd5e1;
        font-size: 0.85rem;
    }

    .dropdown-divider { border-top: 1px solid #e2e8f0; }
</style>

<nav class="navbar navbar-expand-lg nav-custom sticky-top shadow">
    <div class="container-fluid">
        <a class="navbar-brand navbar-brand-custom" href="dashboard.jsp">
            <i class="bi bi-factory me-2"></i>Sugar Plant ERP
        </a>
        
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#factoryMainNav">
            <i class="bi bi-list fs-2"></i>
        </button>

        <div class="collapse navbar-collapse" id="factoryMainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-bold" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-database-fill-gear me-1"></i> Master
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="factory_information.jsp">Factory Information</a></li>
                        <li><a class="dropdown-item" href="multiple_day_process.jsp">Multiple Day Process</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-bold" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-arrow-left-right me-1"></i> Transaction
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="daily_analysis.jsp">Daily Analysis Data Entry</a></li>
                        <li><a class="dropdown-item" href="chemical_consumption.jsp">Chemical Consumption</a></li>
                        <li><a class="dropdown-item" href="material_stock.jsp">Material Stock</a></li>
                        <li><a class="dropdown-item" href="reason_of_stoppage.jsp">Reason Of Stoppage</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li class="dropdown-header text-uppercase small fw-bold text-muted" style="font-size: 0.65rem;">Stock Reporting</li>
                        <li><a class="dropdown-item" href="rt7c_stock.jsp">RT 7 C</a></li>
                        <li><a class="dropdown-item" href="run_stock.jsp">Run</a></li>
                        <li><a class="dropdown-item" href="rt8c_stock.jsp">RT 8 C</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="daily_crushing.jsp">Daily Crushing Data Entry</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-bold" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-file-earmark-bar-graph-fill me-1"></i> Reports
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="report_daily_mfg_details.jsp">Daily Manufacturing (Details)</a></li>
                        <li><a class="dropdown-item" href="report_daily_mfg_small.jsp">Daily Mfg Small Marathi</a></li>
                        <li><a class="dropdown-item" href="report_daily_mfg_short.jsp">Daily Mfg Short Marathi</a></li>
                        <li><a class="dropdown-item" href="report_daily_ton.jsp">Daily Ton Data</a></li>
                        <li><a class="dropdown-item" href="report_daily_stock.jsp">Daily Stock Data</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="report_weekly.jsp">Weekly</a></li>
                        <li><a class="dropdown-item" href="report_rt7c.jsp">RT-7 (C)</a></li>
                        <li><a class="dropdown-item" href="report_rt8c.jsp">RT-8 (c)</a></li>
                        <li><a class="dropdown-item" href="report_daily_analysis.jsp">Daily Analysis Report</a></li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-bold" href="change_password.jsp">
                        <i class="bi bi-shield-lock-fill me-1"></i> Password
                    </a>
                </li>
            </ul>
            
            <div class="d-flex align-items-center">
                <div class="user-badge me-2 shadow-sm">
                    <i class="bi bi-person-circle me-1 text-info"></i>
                    <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
                </div>
                <a class="nav-link fw-bold nav-exit px-3" href="LogoutServlet">
                    <i class="bi bi-power me-1"></i> Exit
                </a>
            </div>
        </div>
    </div>
</nav> --%>