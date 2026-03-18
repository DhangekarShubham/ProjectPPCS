<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="leftpanel">
    
    <div class="leftpanel-profile">
        <img src="asset/image/file.enc" alt="Profile" onerror="this.src='https://ui-avatars.com/api/?name=Admin&background=259dab&color=fff';">
        <div class="profile-info">
            <p class="profile-name"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "Admin User" %></p>
            <p class="profile-sub"><i class="fa fa-circle text-success me-1" style="font-size: 8px;"></i> Online</p>
        </div>
    </div>

    <ul class="nav-sidebar flex-column mt-3">
        
        <li class="nav-item active">
            <a class="nav-link" href="dashboard.jsp">
                <i class="fa fa-home main-icon"></i> 
                <span>DASHBOARD</span>
            </a>
        </li>

        <li class="nav-item menu-item-parent">
            <a class="nav-link" href="javascript:void(0);">
                <i class="fa fa-cogs main-icon"></i> 
                <span>MASTER</span>
                <i class="fa fa-angle-down ms-auto caret-icon"></i>
            </a>
            <ul class="children"> 
                <li class="mt-2"><a class="nav-link ajax-link" href="factory_information.jsp"><i class="fa fa-circle-o me-2"></i> Factory Information</a></li>
                <li><a class="nav-link ajax-link" href="multiple_day_process.jsp"><i class="fa fa-circle-o me-2"></i> Multiple Day Process</a></li>
            </ul>
        </li>

        <li class="nav-item menu-item-parent">
            <a class="nav-link" href="javascript:void(0);">
                <i class="fa fa-pencil-square-o main-icon"></i> 
                <span>TRANSACTION</span>
                <i class="fa fa-angle-down ms-auto caret-icon"></i>
            </a>
            <ul class="children">
                <li class="mt-2"><a class="nav-link ajax-link" href="daily_crushing.jsp"><i class="fa fa-circle-o me-2"></i> Daily Crushing Data</a></li>
                <li><a class="nav-link ajax-link" href="daily_analysis.jsp"><i class="fa fa-circle-o me-2"></i> Daily Analysis Data</a></li>
                <li><a class="nav-link ajax-link" href="chemical_consumption.jsp"><i class="fa fa-circle-o me-2"></i> Chemical Consumption</a></li>
                <li><a class="nav-link ajax-link" href="material_stock.jsp"><i class="fa fa-circle-o me-2"></i> Material Stock</a></li>
                <li><a class="nav-link ajax-link" href="reason_of_stoppage.jsp"><i class="fa fa-circle-o me-2"></i> Reason Of Stoppage</a></li>
                
                <li class="mt-3 text-muted ms-4" style="font-size: 10px; font-weight: bold;">STATUTORY</li>
                <li><a class="nav-link ajax-link" href="rt7c_stock.jsp"><i class="fa fa-circle-o me-2"></i> RT 7 (C) Data Entry</a></li>
                <li><a class="nav-link ajax-link" href="rt8c_stock.jsp"><i class="fa fa-circle-o me-2"></i> RT 8 (C) Data Entry</a></li>
                <li><a class="nav-link ajax-link" href="run_stock.jsp"><i class="fa fa-circle-o me-2"></i> Run Stock</a></li>
            </ul>
        </li>

        <li class="nav-item menu-item-parent">
            <a class="nav-link" href="javascript:void(0);">
                <i class="fa fa-file-pdf-o main-icon"></i> 
                <span>REPORTS</span>
                <i class="fa fa-angle-down ms-auto caret-icon"></i>
            </a>
            <ul class="children">
                <li class="mt-2"><a class="nav-link ajax-link" href="report_daily_mfg_details.jsp"><i class="fa fa-circle-o me-2"></i> Daily Mfg (Details)</a></li>
                <li><a class="nav-link ajax-link" href="report_daily_mfg_short.jsp"><i class="fa fa-circle-o me-2"></i> Daily Mfg (Short)</a></li>
                <li><a class="nav-link ajax-link" href="report_daily_ton.jsp"><i class="fa fa-circle-o me-2"></i> Daily Ton Data</a></li>
                <li><a class="nav-link ajax-link" href="report_daily_stock.jsp"><i class="fa fa-circle-o me-2"></i> Daily Stock Data</a></li>
                
                <li class="mt-3 text-muted ms-4" style="font-size: 10px; font-weight: bold;">PERFORMANCE</li>
                <li><a class="nav-link ajax-link" href="report_weekly.jsp"><i class="fa fa-circle-o me-2"></i> Weekly Report</a></li>
                <li><a class="nav-link ajax-link" href="report_rt7c.jsp"><i class="fa fa-circle-o me-2"></i> RT-7 (C) Output</a></li>
                <li><a class="nav-link ajax-link" href="report_rt8c.jsp"><i class="fa fa-circle-o me-2"></i> RT-8 (C) Output</a></li>
                <li><a class="nav-link ajax-link" href="report_daily_analysis.jsp"><i class="fa fa-circle-o me-2"></i> Daily Analysis Output</a></li>
            </ul>
        </li>

    </ul>
</div>