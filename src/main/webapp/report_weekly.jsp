<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, com.google.gson.Gson" %>
<%@ page import="com.twd.sugarfactory.model.WeeklyReport" %>
<%@ page import="com.twd.sugarfactory.dhconnection.DBConnection" %>
<%
    // --- SERVER SIDE API LOGIC ---
    String action = request.getParameter("action");

    if ("getWeeklyReport".equals(action)) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.clear(); // CRITICAL: Clears any stray whitespace before JSON output

        try {
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String seasonYear = "2025-2026";
            
            if (fromDate == null || toDate == null) {
                out.print("{\"error\": \"Missing required dates.\"}");
                return;
            }

            int weekNo = 0;
            String weekNoStr = request.getParameter("weekNo");
            if (weekNoStr != null && !weekNoStr.trim().isEmpty()) {
                weekNo = Integer.parseInt(weekNoStr);
            }

            WeeklyReport data = new WeeklyReport();
            data.setWeekNo(weekNo);
            data.setFromDate(fromDate);
            data.setToDate(toDate);
            data.setSeasonYear(seasonYear);

            // SQL 1: Production Data
            String sqlMain = "SELECT " +
                "SUM(CASE WHEN crush_date BETWEEN ? AND ? THEN (member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) ELSE 0 END) as cane_week, " +
                "SUM(CASE WHEN crush_date <= ? THEN (member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) ELSE 0 END) as cane_todate, " +
                "(SELECT SUM(no_of_bags) FROM daily_sugar_production WHERE crush_date BETWEEN ? AND ?) as sugar_week, " +
                "(SELECT SUM(no_of_bags) FROM daily_sugar_production WHERE crush_date <= ?) as sugar_todate, " +
                "AVG(CASE WHEN crush_date BETWEEN ? AND ? THEN recovery_percent_today ELSE NULL END) as avg_recovery_week, " +
                "AVG(CASE WHEN crush_date BETWEEN ? AND ? THEN mill_ext_today ELSE NULL END) as avg_mill_ext_week " +
                "FROM daily_crushing_log WHERE season_year = ?";

            // SQL 2: Time Data
            String sqlTime = "SELECT " +
                "SUM(CASE WHEN crush_date BETWEEN ? AND ? THEN working_hours ELSE 0 END) as run_week, " +
                "SUM(CASE WHEN crush_date <= ? THEN working_hours ELSE 0 END) as run_todate, " +
                "SUM(CASE WHEN crush_date BETWEEN ? AND ? THEN (hours_lost_rain + hours_lost_mechanical + hours_lost_electrical + hours_lost_cane_shortage + hours_lost_cleaning + hours_lost_process + hours_lost_misc) ELSE 0 END) as stop_week, " +
                "SUM(CASE WHEN crush_date <= ? THEN (hours_lost_rain + hours_lost_mechanical + hours_lost_electrical + hours_lost_cane_shortage + hours_lost_cleaning + hours_lost_process + hours_lost_misc) ELSE 0 END) as stop_todate " +
                "FROM daily_time_account WHERE crush_date <= ?";

            try (Connection conn = DBConnection.getConnection()) {
                try (PreparedStatement ps = conn.prepareStatement(sqlMain)) {
                    ps.setString(1, fromDate); ps.setString(2, toDate); ps.setString(3, toDate);
                    ps.setString(4, fromDate); ps.setString(5, toDate); ps.setString(6, toDate);
                    ps.setString(7, fromDate); ps.setString(8, toDate);
                    ps.setString(9, fromDate); ps.setString(10, toDate);
                    ps.setString(11, seasonYear);
                    try(ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            data.setCaneCrushedWeek(rs.getDouble("cane_week"));
                            data.setCaneCrushedTodate(rs.getDouble("cane_todate"));
                            data.setSugarBaggedWeek(rs.getDouble("sugar_week"));
                            data.setSugarBaggedTodate(rs.getDouble("sugar_todate"));
                            data.setRecoveryWeek(rs.getDouble("avg_recovery_week"));
                            data.setMillExtWeek(rs.getDouble("avg_mill_ext_week"));
                        }
                    }
                }
                try (PreparedStatement psTime = conn.prepareStatement(sqlTime)) {
                    psTime.setString(1, fromDate); psTime.setString(2, toDate); psTime.setString(3, toDate);
                    psTime.setString(4, fromDate); psTime.setString(5, toDate); psTime.setString(6, toDate);
                    psTime.setString(7, toDate);
                    try(ResultSet rs = psTime.executeQuery()) {
                        if (rs.next()) {
                            data.setCrushingHrsWeek(rs.getDouble("run_week"));
                            data.setCrushingHrsTodate(rs.getDouble("run_todate"));
                            data.setLostHrsWeek(rs.getDouble("stop_week"));
                            data.setLostHrsTodate(rs.getDouble("stop_todate"));
                        }
                    }
                }
                
                double runWk = data.getCrushingHrsWeek() != null ? data.getCrushingHrsWeek() : 0.0;
                double caneWk = data.getCaneCrushedWeek() != null ? data.getCaneCrushedWeek() : 0.0;
                data.setCrushRateWeek(runWk > 0 ? caneWk / (runWk / 24.0) : 0.0);

                out.print(new Gson().toJson(data));
            } catch (Exception e) {
                out.print("{\"error\": \"Database Error: " + e.getMessage().replace("\"", "'") + "\"}");
            }
        } catch (Exception e) {
            out.print("{\"error\": \"System Error: " + e.getMessage() + "\"}");
        }
        out.flush();
        return; // Prevents HTML from rendering during API calls
    }
%>

<%-- --- VIEW LOGIC --- --%>
<div class="contentpanel" ng-controller="WeeklyReportController">
    <style>
        .report-card { border-top: 5px solid #0d6efd; background: white; max-width: 1000px; padding: 40px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .pdf-table { width: 100%; border: 1px solid #333; border-collapse: collapse; }
        .pdf-table th, .pdf-table td { border: 1px solid #333; padding: 10px; font-size: 14px; }
        .pdf-table th { background-color: #f1f5f9; text-align: center; }
        .val-cell { text-align: right; font-family: 'Courier New', monospace; font-weight: bold; }
        @media print { .no-print { display: none !important; } .container-fluid { padding: 0; } .report-card { border:none; box-shadow:none; padding: 0 !important; } }
    </style>

    <div class="container-fluid py-3">
        <div class="card shadow-sm mb-4 no-print">
            <div class="card-header bg-primary text-white fw-bold">WEEKLY REPORT PARAMETERS</div>
            <div class="card-body bg-light">
                <div class="row g-3 align-items-end">
                    <div class="col-md-2">
                        <label class="form-label small fw-bold">Week No</label>
                        <input type="number" class="form-control" ng-model="weekNo">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">From Date</label>
                        <input type="date" class="form-control" ng-model="fromDate">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">To Date</label>
                        <input type="date" class="form-control" ng-model="toDate">
                    </div>
                    <div class="col-md-4">
                        <button class="btn btn-primary px-4" ng-click="generateReport()" ng-disabled="loading">
                            <i class="fa" ng-class="loading ? 'fa-spinner fa-spin' : 'fa-refresh'"></i> Generate
                        </button>
                        <button class="btn btn-dark px-4" ng-click="printReport()" ng-disabled="!isDataLoaded">
                            <i class="fa fa-print"></i> Print
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow report-card p-5 mx-auto" ng-show="isDataLoaded">
            <div class="text-center mb-4">
                <h2 class="fw-bold">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar</h2>
                <h5 class="text-muted text-decoration-underline">WEEKLY MANUFACTURING REPORT</h5>
            </div>

            <div class="d-flex justify-content-between mb-3 fw-bold border-bottom pb-2">
                <span>Season: {{report.seasonYear}}</span>
                <span>Week No: {{report.weekNo}}</span>
                <span>Period: {{displayFromDate}} to {{displayToDate}}</span>
            </div>

            <table class="pdf-table">
                <thead>
                    <tr>
                        <th style="width: 50%;">PARTICULARS</th>
                        <th style="width: 25%;">THIS WEEK</th>
                        <th style="width: 25%;">TO-DATE (SEASON)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="table-dark"><td colspan="3" class="fw-bold">1.0 PRODUCTION DATA</td></tr>
                    <tr>
                        <td>Total Cane Crushed (MT)</td>
                        <td class="val-cell">{{report.caneCrushedWeek | number:3}}</td>
                        <td class="val-cell">{{report.caneCrushedTodate | number:3}}</td>
                    </tr>
                    <tr>
                        <td>Sugar Bagged (Qtls)</td>
                        <td class="val-cell">{{report.sugarBaggedWeek | number:2}}</td>
                        <td class="val-cell">{{report.sugarBaggedTodate | number:2}}</td>
                    </tr>
                    <tr class="bg-light fw-bold">
                        <td>Net Recovery % Cane</td>
                        <td class="val-cell text-primary">{{report.recoveryWeek | number:2}}</td>
                        <td class="val-cell text-primary">{{report.recoveryTodate | number:2}}</td>
                    </tr>
                    <tr class="table-dark"><td colspan="3" class="fw-bold">2.0 TECHNICAL PERFORMANCE</td></tr>
                    <tr>
                        <td>Mill Extraction %</td>
                        <td class="val-cell">{{report.millExtWeek | number:2}}</td>
                        <td class="val-cell text-muted">---</td>
                    </tr>
                    <tr>
                        <td>Crushing Rate (MT/24Hrs)</td>
                        <td class="val-cell">{{report.crushRateWeek | number:2}}</td>
                        <td class="val-cell text-muted">---</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>