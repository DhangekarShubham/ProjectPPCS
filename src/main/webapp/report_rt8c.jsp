<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.*, com.google.gson.Gson" %>
<%@ page import="com.twd.sugarfactory.dhconnection.DBConnection" %>
<%
    // --- SERVER SIDE API LOGIC (FETCH FROM DATABASE) ---
    String action = request.getParameter("action");

    if ("getRt8cData".equals(action)) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.clear();

        Map<String, Object> responseData = new HashMap<>();
        String seasonYear = request.getParameter("seasonYear"); 
        
        if (seasonYear == null || seasonYear.trim().isEmpty()) {
            out.print("{\"error\": \"Missing season year.\"}");
            return;
        }

        String prevSeasonYear = "N/A";
        try {
            String[] years = seasonYear.split("-");
            int y1 = Integer.parseInt(years[0]) - 1;
            int y2 = Integer.parseInt(years[1]) - 1;
            prevSeasonYear = y1 + "-" + y2;
        } catch (Exception e) {
            prevSeasonYear = "2024-2025"; 
        }

        try (Connection conn = DBConnection.getConnection()) {
            responseData.put("current", fetchSeasonData(conn, seasonYear));
            responseData.put("previous", fetchSeasonData(conn, prevSeasonYear));
            responseData.put("seasonYear", seasonYear);
            responseData.put("prevSeasonYear", prevSeasonYear);
            
            out.print(new Gson().toJson(responseData));

        } catch (Exception e) {
            out.print("{\"error\": \"Database Error: " + e.getMessage().replace("\"", "'") + "\"}");
        }
        out.flush();
        return; 
    }
%>
<%! 
    private Map<String, Object> fetchSeasonData(Connection conn, String season) throws SQLException {
        Map<String, Object> data = new HashMap<>();
        
        String sqlCrush = "SELECT " +
            "SUM(member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) as total_cane, " +
            "AVG(recovery_percent_today) as avg_rec, " +
            "AVG(mill_ext_today) as mill_ext, " +
            "AVG(reduced_ext_today) as reduced_ext, " +
            "AVG(undetermined_losses_pct) as sugar_loss, " +
            "SUM(cogen_export_today) as total_power " +
            "FROM daily_crushing_log WHERE season_year = ?";
            
        try (PreparedStatement ps = conn.prepareStatement(sqlCrush)) {
            ps.setString(1, season);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    data.put("caneCrushed", rs.getDouble("total_cane"));
                    data.put("recovery", rs.getDouble("avg_rec"));
                    data.put("millExt", rs.getDouble("mill_ext"));
                    data.put("reducedMillExt", rs.getDouble("reduced_ext"));
                    data.put("sugarLosses", rs.getDouble("sugar_loss"));
                    data.put("powerGenerated", rs.getDouble("total_power"));
                }
            }
        }

        String sqlBagasse = "SELECT " +
            "bagasse_used_sugar_plant, bagasse_used_cogen, bagasse_sold " +
            "FROM rt8c_technical_performance WHERE season_year = ?";
            
        try (PreparedStatement ps = conn.prepareStatement(sqlBagasse)) {
            ps.setString(1, season);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double bagMill = rs.getDouble("bagasse_used_sugar_plant");
                    double bagCogen = rs.getDouble("bagasse_used_cogen");
                    double bagSaved = rs.getDouble("bagasse_sold");
                    double bagTotal = bagMill + bagCogen + bagSaved;
                    
                    data.put("bagasseMill", bagMill);
                    data.put("bagasseCogen", bagCogen);
                    data.put("bagasseSaved", bagSaved);
                    data.put("bagasseProduced", bagTotal);
                } else {
                    data.put("bagasseMill", 0.0); data.put("bagasseCogen", 0.0);
                    data.put("bagasseSaved", 0.0); data.put("bagasseProduced", 0.0);
                }
            }
        }
        
        data.put("sulphurPct", 0.055); 
        return data;
    }
%>

<%-- --- VIEW LOGIC (ANGULARJS DYNAMIC HTML) --- --%>
<div class="contentpanel ng-cloak" ng-controller="Rt8cReportController">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap');
        @import url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css');

        /* Hide Angular curly braces before load */
        [ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
            display: none !important;
        }

        .rt8-container { font-family: 'Inter', sans-serif; color: #1e293b; }
        
        /* Match UI Screenshot Filter Card */
        .filter-card { 
            background: #ffffff; 
            border: 1px solid #e2e8f0; 
            padding: 15px 20px; 
            border-radius: 8px; 
            margin-bottom: 30px; 
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        
        .report-paper { 
            background-color: white; 
            padding: 60px; 
            border: 1px solid #d1d5db; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            margin: 0 auto; 
            max-width: 1000px; 
            color: #000;
        }

        .report-header-box { border-bottom: 3px solid #000; margin-bottom: 25px; padding-bottom: 15px; }
        .report-title { text-align: center; font-weight: 800; font-size: 1.3rem; text-transform: uppercase; margin: 0; }
        .report-subtitle { text-align: center; font-weight: 600; font-size: 0.95rem; color: #374151; margin-top: 5px; }
        .excise-header { text-align: center; font-weight: 900; font-size: 1.2rem; margin: 20px 0; text-decoration: underline; text-underline-offset: 6px; }

        .table-report { width: 100%; border-collapse: collapse; border: 2px solid #000; margin-bottom: 30px; }
        .table-report th { background-color: #f3f4f6 !important; border: 1px solid #000; text-align: center; padding: 10px; font-size: 0.75rem; text-transform: uppercase; font-weight: 800; color: #000;}
        .table-report td { border: 1px solid #000; padding: 8px 12px; font-size: 0.88rem; font-family: 'JetBrains Mono', monospace; color: #000;}
        .section-header { background-color: #f3f4f6 !important; color: #000 !important; font-weight: 800 !important; text-transform: uppercase; font-size: 0.8rem !important; font-family: 'Inter', sans-serif !important; }
        
        .row-label { font-family: 'Inter', sans-serif !important; font-weight: 600; color: #1f2937; }
        .signature-line { border-top: 1.5px solid #000; width: 85%; margin: 80px auto 10px auto; }
        
        @media print {
            .no-print { display: none !important; }
            .contentpanel { padding: 0 !important; margin: 0 !important; }
            .report-paper { box-shadow: none; border: none; padding: 20px; width: 100%; max-width: 100%; }
            .table-report th, .section-header { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
        }
    </style>

    <div class="rt8-container container-fluid py-4">
        
        <div class="mb-3 no-print">
            <h5 class="mb-0 fw-bold" style="color: #1e293b; letter-spacing: 0.5px;">
                <i class="bi bi-calendar-check-fill text-primary me-2"></i> SEASONAL CLOSURE - FINAL RT-8(C)
            </h5>
        </div>

        <div class="filter-card no-print">
            <div class="d-flex align-items-end justify-content-between">
                
                <div class="d-flex align-items-end gap-3">
                    <div>
                        <label class="small fw-bold text-muted mb-1 d-block" style="font-size: 10px; letter-spacing: 0.5px;">SELECT CRUSHING SEASON</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-calendar3"></i></span>
                            <select class="form-select border-start-0 fw-semibold" ng-model="seasonYear" style="min-width: 200px; cursor: pointer;">
                                <option value="2025-2026">2025-2026 (Current)</option>
                                <option value="2024-2025">2024-2025</option>
                                <option value="2023-2024">2023-2024</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <button type="button" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm" ng-click="generateReport()" ng-disabled="loading">
                            <span ng-show="!loading">Generate</span>
                            <span ng-show="loading"><i class="bi bi-arrow-repeat spin"></i> Loading...</span>
                        </button>
                    </div>
                </div>
                
                <div>
                    <button type="button" class="btn btn-sm btn-outline-dark fw-bold" onclick="window.print()" ng-disabled="!isDataLoaded">
                        <i class="bi bi-printer-fill text-info me-1"></i> Print Final Report
                    </button>
                </div>

            </div>
        </div>

        <div id="printableArea" class="report-paper" ng-show="isDataLoaded">
            <div class="report-header-box text-center">
                <h3 class="report-title">SHRI. CHHATRAPATI S.S.K. LTD, BHAVANINAGAR.</h3>
                <p class="report-subtitle">Tal. Indapur, Dist. Pune, Maharashtra - 413 106</p>
            </div>
            
            <div class="excise-header">FORM R.T. 8 (C) - FINAL MANUFACTURING REPORT</div>
            
            <div class="row mb-4" style="font-size: 0.85rem; font-weight: bold;">
                <div class="col-6">CRUSHING SEASON: {{ reportData.seasonYear }}</div>
                <div class="col-6 text-end">REPORT DATE: {{ todayDate | date:'dd-MMM-yyyy' | uppercase }}</div>
                <div class="col-6 mt-2">PLANT CAPACITY: 3500 TCD</div>
                <div class="col-6 mt-2 text-end">TOTAL OPERATIONAL DAYS: 165</div>
            </div>

            <table class="table-report">
                <thead>
                    <tr><th colspan="3" class="section-header">1.0 MILLING & TECHNICAL EFFICIENCY PERFORMANCE</th></tr>
                    <tr>
                        <th style="width: 50%; text-align: left;">PARTICULARS</th>
                        <th class="text-center">CURRENT ({{ reportData.seasonYear }})</th>
                        <th class="text-center">PREVIOUS ({{ reportData.prevSeasonYear }})</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td class="row-label">Total Cane Crushed (MT)</td>
                        <td class="text-end fw-bold">{{ reportData.current.caneCrushed | number:3 }}</td>
                        <td class="text-end">{{ reportData.previous.caneCrushed | number:3 }}</td>
                    </tr>
                    <tr><td class="row-label">Average Recovery % Cane</td>
                        <td class="text-end fw-bold text-primary">{{ reportData.current.recovery | number:2 }}</td>
                        <td class="text-end text-muted">{{ reportData.previous.recovery | number:2 }}</td>
                    </tr>
                    <tr><td class="row-label">Mill Extraction %</td>
                        <td class="text-end fw-bold">{{ reportData.current.millExt | number:2 }}</td>
                        <td class="text-end">{{ reportData.previous.millExt | number:2 }}</td>
                    </tr>
                    <tr><td class="row-label">Reduced Mill Extraction %</td>
                        <td class="text-end fw-bold">{{ reportData.current.reducedMillExt | number:2 }}</td>
                        <td class="text-end">{{ reportData.previous.reducedMillExt | number:2 }}</td>
                    </tr>
                    <tr><td class="row-label">Total Sugar Losses % Cane</td>
                        <td class="text-end fw-bold text-danger">{{ reportData.current.sugarLosses | number:2 }}</td>
                        <td class="text-end">{{ reportData.previous.sugarLosses | number:2 }}</td>
                    </tr>
                </tbody>
            </table>

            <table class="table-report">
                <thead>
                    <tr><th colspan="3" class="section-header">2.0 BAGASSE ENERGY BALANCE (MT)</th></tr>
                    <tr>
                        <th style="width: 50%; text-align: left;">ENERGY PARTICULARS</th>
                        <th class="text-center">CURRENT SEASON</th>
                        <th class="text-center">PREVIOUS SEASON</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td class="row-label">Total Bagasse Produced</td>
                        <td class="text-end fw-bold">{{ reportData.current.bagasseProduced | number:3 }}</td>
                        <td class="text-end">{{ reportData.previous.bagasseProduced | number:3 }}</td>
                    </tr>
                    <tr><td class="row-label">Used for Sugar Mill Boiler</td>
                        <td class="text-end">{{ reportData.current.bagasseMill | number:3 }}</td>
                        <td class="text-end">{{ reportData.previous.bagasseMill | number:3 }}</td>
                    </tr>
                    <tr><td class="row-label">Used for Co-Generation Unit</td>
                        <td class="text-end">{{ reportData.current.bagasseCogen | number:3 }}</td>
                        <td class="text-end">{{ reportData.previous.bagasseCogen | number:3 }}</td>
                    </tr>
                    <tr class="fw-bold" style="border-top: 2px solid #000;">
                        <td class="row-label">NET BAGASSE SAVED (MT)</td>
                        <td class="text-end text-success">{{ reportData.current.bagasseSaved | number:3 }}</td>
                        <td class="text-end">{{ reportData.previous.bagasseSaved | number:3 }}</td>
                    </tr>
                </tbody>
            </table>

            <table class="table-report">
                <thead>
                    <tr><th colspan="3" class="section-header">3.0 OPERATIONAL CONSUMABLES & UTILITIES</th></tr>
                    <tr>
                        <th style="width: 50%; text-align: left;">PARTICULARS</th>
                        <th class="text-center">CURRENT SEASON</th>
                        <th class="text-center">PREVIOUS SEASON</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td class="row-label">Sulphur Consumption % Cane</td>
                        <td class="text-end">{{ reportData.current.sulphurPct | number:3 }}</td>
                        <td class="text-end">{{ reportData.previous.sulphurPct | number:3 }}</td>
                    </tr>
                    <tr><td class="row-label">Total Electricity Exported (KWH)</td>
                        <td class="text-end fw-bold">{{ reportData.current.powerGenerated | number:0 }}</td>
                        <td class="text-end">{{ reportData.previous.powerGenerated | number:0 }}</td>
                    </tr>
                </tbody>
            </table>
            
            <div class="row text-center" style="margin-top: 80px;">
                <div class="col-3">
                    <div class="signature-line"></div>
                    <span class="small fw-bold">CHIEF CHEMIST</span>
                </div>
                <div class="col-3">
                    <div class="signature-line"></div>
                    <span class="small fw-bold">CHIEF ENGINEER</span>
                </div>
                <div class="col-3">
                    <div class="signature-line"></div>
                    <span class="small fw-bold">MANAGING DIRECTOR</span>
                </div>
                <div class="col-3">
                    <div class="signature-line"></div>
                    <span class="small fw-bold">CENTRAL EXCISE / GST</span>
                    <br><span class="text-muted" style="font-size: 10px;">(Seal & Signature)</span>
                </div>
            </div>
        </div>
    </div>
</div>