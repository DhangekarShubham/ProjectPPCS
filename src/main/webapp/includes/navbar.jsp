<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .nav-custom { background-color: #fdf5e6; border-bottom: 2px solid #ccc; margin-bottom: 20px; }
    .nav-custom .nav-link:hover { color: #8a2be2 !important; }
    .dropdown-menu { border-radius: 0; border: 1px solid #999; }
    .dropdown-item:hover { background-color: #e2e6ea; }
</style>

<nav class="navbar navbar-expand-lg nav-custom px-3 shadow-sm">
    <div class="container-fluid">
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#factoryMainNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="factoryMainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-dark fw-bold" href="#" data-bs-toggle="dropdown">Master</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="factory_information.jsp">Factory Information</a></li>
                        <li><a class="dropdown-item" href="multiple_day_process.jsp">Multiple Day Process</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-dark fw-bold" href="#" data-bs-toggle="dropdown">Transaction</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="daily_analysis.jsp">Daily Analysis Data Entry</a></li>
                        <li><a class="dropdown-item" href="chemical_consumption.jsp">Chemical Consumption</a></li>
                        <li><a class="dropdown-item" href="material_stock.jsp">Material Stock</a></li>
                        <li><a class="dropdown-item" href="reason_of_stoppage.jsp">Reason Of Stoppage</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="rt7c_stock.jsp">RT 7 C</a></li>
                        <li><a class="dropdown-item" href="run_stock.jsp">Run</a></li>
                        <li><a class="dropdown-item" href="rt8c_stock.jsp">RT 8 C</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="daily_crushing.jsp">Daily Crushing Data Entry</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-dark fw-bold" href="#" data-bs-toggle="dropdown">Reports</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="report_daily_mfg_details.jsp">Daily Manufacturing(Details)</a></li>
                        <li><a class="dropdown-item" href="report_daily_mfg_small.jsp">Daily Manufacturing Small Marathi</a></li>
                        <li><a class="dropdown-item" href="report_daily_mfg_short.jsp">Daily Manufacturing Short Marathi</a></li>
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
                    <a class="nav-link text-dark fw-bold" href="change_password.jsp">Change Password</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="LogoutServlet">Exit</a>
                </li>
            </ul>
            
            <span class="navbar-text fw-bold text-secondary">
                User: <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
            </span>
        </div>
    </div>
</nav>