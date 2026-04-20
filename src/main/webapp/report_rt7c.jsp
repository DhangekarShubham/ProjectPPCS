<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.*, com.google.gson.Gson" %>
<%@ page import="com.twd.sugarfactory.dhconnection.DBConnection" %>
<%
    // --- SERVER SIDE API LOGIC (FETCH FROM DATABASE) ---
    String action = request.getParameter("action");

    if ("getRt7cData".equals(action)) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.clear();

        Map<String, Object> responseData = new HashMap<>();
        String reportMonth = request.getParameter("reportMonth"); 
        
        if (reportMonth == null || reportMonth.trim().isEmpty()) {
            out.print("{\"error\": \"Missing report month.\"}");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            Map<String, Double> mfg = new HashMap<>();
            
            // 1. Fetch Cane Crushed Data
            String sqlCane = "SELECT " +
                "SUM(CASE WHEN DATE_FORMAT(crush_date, '%Y-%m') = ? THEN (member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) ELSE 0 END) as cane_month, " +
                "SUM(member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) as cane_season " +
                "FROM daily_crushing_log WHERE season_year = '2025-2026'"; 
                
            try (PreparedStatement ps = conn.prepareStatement(sqlCane)) {
                ps.setString(1, reportMonth);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        mfg.put("caneCrushedMonth", rs.getDouble("cane_month"));
                        mfg.put("caneCrushedSeason", rs.getDouble("cane_season"));
                    }
                }
            }

            // 2. Fetch Sugar Produced Data (Assuming 50kg bags = 0.5 Qtls based on material_master)
            String sqlSugar = "SELECT " +
                "SUM(CASE WHEN DATE_FORMAT(p.crush_date, '%Y-%m') = ? THEN p.no_of_bags ELSE 0 END) * 0.50 as sugar_month, " +
                "SUM(p.no_of_bags) * 0.50 as sugar_season " +
                "FROM daily_sugar_production p " +
                "JOIN daily_crushing_log d ON p.crush_date = d.crush_date " +
                "WHERE d.season_year = '2025-2026'";
            
            try (PreparedStatement ps = conn.prepareStatement(sqlSugar)) {
                ps.setString(1, reportMonth);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        mfg.put("sugarBaggedMonth", rs.getDouble("sugar_month"));
                        mfg.put("sugarBaggedSeason", rs.getDouble("sugar_season"));
                    }
                }
            }

            // 3. Fetch WIP (Statement of In-Process Stocks) from material_stock_log
            double sipMonth = 0.0;
            List<Map<String, Object>> wipList = new ArrayList<>();
            String sqlWip = "SELECT mm.material_name, msl.volume_hl, msl.specific_gravity, msl.brix_percent, msl.pol_percent, msl.purity_percent, msl.quantity_qtls " +
                            "FROM material_stock_log msl " +
                            "JOIN material_master mm ON msl.material_id = mm.material_id " +
                            "WHERE DATE_FORMAT(msl.sample_date, '%Y-%m') = ? AND msl.report_type = 'RT7C' " +
                            "ORDER BY msl.stock_id ASC";
            
            try (PreparedStatement ps = conn.prepareStatement(sqlWip)) {
                ps.setString(1, reportMonth);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("material", rs.getString("material_name"));
                        row.put("volume", rs.getDouble("volume_hl"));
                        row.put("spGr", rs.getDouble("specific_gravity"));
                        row.put("brix", rs.getDouble("brix_percent"));
                        row.put("pol", rs.getDouble("pol_percent"));
                        row.put("purity", rs.getDouble("purity_percent"));
                        
                        double availSugar = rs.getDouble("quantity_qtls");
                        row.put("availSugar", availSugar);
                        sipMonth += availSugar; // Accumulate Total SIP
                        
                        wipList.add(row);
                    }
                }
            }
            responseData.put("wip", wipList);

            // 4. Finalize Mfg Summary Calculations
            mfg.put("sipMonth", sipMonth);
            mfg.put("sipSeason", sipMonth); 
            
            double netMonth = mfg.getOrDefault("sugarBaggedMonth", 0.0) + sipMonth;
            double netSeason = mfg.getOrDefault("sugarBaggedSeason", 0.0) + sipMonth;
            mfg.put("netSugarMonth", netMonth);
            mfg.put("netSugarSeason", netSeason);
            
            double caneM = mfg.getOrDefault("caneCrushedMonth", 0.0);
            double caneS = mfg.getOrDefault("caneCrushedSeason", 0.0);
            mfg.put("recMonth", caneM > 0 ? (netMonth / caneM) * 100 : 0);
            mfg.put("recSeason", caneS > 0 ? (netSeason / caneS) * 100 : 0);
            
            responseData.put("mfg", mfg);

            // 5. Fetch Final Sugar Inventory Account (Calculated dynamically)
            List<Map<String, Object>> invList = new ArrayList<>();
            String sqlInv = "SELECT mm.material_name as grade, " +
                            "0 as opening_bal, " +
                            "COALESCE(SUM(dsp.no_of_bags) * 0.5, 0) as produced, " +
                            "0 as dispatched, " +
                            "COALESCE(SUM(dsp.no_of_bags) * 0.5, 0) as closing_bal " +
                            "FROM material_master mm " +
                            "LEFT JOIN daily_sugar_production dsp ON mm.material_id = dsp.material_id AND DATE_FORMAT(dsp.crush_date, '%Y-%m') = ? " +
                            "WHERE mm.category = 'SUGAR_GRADE' " +
                            "GROUP BY mm.material_id, mm.material_name " +
                            "HAVING produced > 0";
            
            try (PreparedStatement ps = conn.prepareStatement(sqlInv)) {
                ps.setString(1, reportMonth);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("grade", rs.getString("grade"));
                        row.put("opening", rs.getDouble("opening_bal"));
                        row.put("produced", rs.getDouble("produced"));
                        row.put("dispatched", rs.getDouble("dispatched"));
                        row.put("closing", rs.getDouble("closing_bal"));
                        invList.add(row);
                    }
                }
            }
            responseData.put("inventory", invList);

            // Metadata
            responseData.put("season", "2025-2026");
            out.print(new Gson().toJson(responseData));

        } catch (Exception e) {
            out.print("{\"error\": \"Database Error: " + e.getMessage().replace("\"", "'") + "\"}");
        }
        out.flush();
        return; 
    }
%>

<%-- --- VIEW LOGIC (ANGULARJS DYNAMIC HTML) --- --%>
<div class="contentpanel" ng-controller="Rt7cReportController">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap');
        @import url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css');

        .rt7-container { font-family: 'Inter', sans-serif; color: #1e293b; }
        .filter-card { background: #ffffff; border: 1px solid #e2e8f0; padding: 20px; border-radius: 10px; margin-bottom: 30px; }
        .report-paper { background-color: white; padding: 60px; border: 1px solid #d1d5db; box-shadow: 0 4px 12px rgba(0,0,0,0.08); margin: 0 auto; max-width: 1000px; color: #000; }
        .report-header-box { border-bottom: 3px solid #000; margin-bottom: 25px; padding-bottom: 15px; }
        .report-title { text-align: center; font-weight: 800; font-size: 1.5rem; text-transform: uppercase; margin: 0; }
        .report-subtitle { text-align: center; font-weight: 600; font-size: 1.1rem; color: #374151; margin-top: 5px; }
        .excise-header { text-align: center; font-weight: 900; font-size: 1.4rem; margin: 20px 0; text-decoration: underline; text-underline-offset: 8px; }
        .table-report { width: 100%; border-collapse: collapse; border: 1.5px solid #000; margin-bottom: 25px; }
        .table-report th { background-color: #f3f4f6 !important; border: 1px solid #000; text-align: center; padding: 8px; font-size: 0.75rem; text-transform: uppercase; font-weight: 800; }
        .table-report td { border: 1px solid #000; padding: 6px 12px; font-size: 0.85rem; font-family: 'JetBrains Mono', monospace; }
        .section-header { background-color: #000 !important; color: #fff !important; font-weight: 800 !important; text-transform: uppercase; font-size: 0.8rem !important; font-family: 'Inter', sans-serif !important; }
        .signature-line { border-top: 1.5px solid #000; width: 85%; margin: 100px auto 10px auto; }
        
        @media print {
            .no-print { display: none !important; }
            .contentpanel { padding: 0 !important; margin: 0 !important; }
            .report-paper { box-shadow: none; border: none; padding: 20px; width: 100%; max-width: 100%; }
        }
    </style>

    <div class="rt7-container container-fluid py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 no-print">
            <div>
                <h4 class="mb-1 fw-bold text-uppercase" style="color: #1e293b; letter-spacing: 0.5px;">
                    <i class="bi bi-file-earmark-check-fill text-primary me-2"></i> Statutory Compliance - Form RT-7(C)
                </h4>
            </div>
        </div>

        <div class="filter-card shadow-sm mx-auto no-print">
            <div class="row g-3 align-items-end justify-content-between">
                <div class="col-md-5 d-flex align-items-end gap-3">
                    <div>
                        <label class="small fw-bold text-muted text-uppercase mb-1 d-block">Report Month</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-light"><i class="bi bi-calendar3"></i></span>
                            <input type="month" class="form-control" ng-model="inputMonth" required>
                        </div>
                    </div>
                    <div>
                        <button type="button" class="btn btn-sm btn-primary px-4 fw-bold shadow-sm" ng-click="generateReport()" ng-disabled="loading">
                            <i class="bi" ng-class="loading ? 'bi-arrow-repeat spin' : 'bi-gear-wide-connected'"></i> Generate
                        </button>
                    </div>
                </div>
                
                <div class="col-md-7 text-end">
                    <button type="button" class="btn btn-sm btn-outline-dark fw-bold me-2" onclick="window.print()" ng-disabled="!isDataLoaded">
                        <i class="bi bi-printer-fill text-info me-1"></i> Print
                    </button>
                </div>
            </div>
        </div>

        <div id="printableArea" class="report-paper shadow" ng-show="isDataLoaded">
            <div class="report-header-box text-center">
                <h3 class="report-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar.</h3>
                <p class="report-subtitle">Tal. Indapur, Dist. Pune, Maharashtra - 413 106</p>
            </div>
            
            <div class="excise-header">FORM R.T. 7 (C)</div>
            
            <div class="row mb-4" style="font-size: 0.9rem; font-weight: bold;">
                <div class="col-6">CRUSHING SEASON: {{ reportData.season }}</div>
                <div class="col-6 text-end">MONTH: {{ displayMonth | uppercase }}</div>
                <div class="col-6">GSTIN: 27AAAAA0000A1Z5</div>
                <div class="col-6 text-end">FILING DATE: {{ todayDate | date:'dd-MMM-yyyy' | uppercase }}</div>
            </div>

            <table class="table-report">
                <thead>
                    <tr><th colspan="3" class="section-header">1.0 Manufacturing Efficiency Summary</th></tr>
                    <tr>
                        <th style="width: 50%; text-align: left;">Particulars</th>
                        <th class="text-end">For the Month</th>
                        <th class="text-end">To-Date (Season)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-semibold">Cane Crushed (MT)</td>
                        <td class="text-end">{{ reportData.mfg.caneCrushedMonth | number:3 }}</td>
                        <td class="text-end">{{ reportData.mfg.caneCrushedSeason | number:3 }}</td>
                    </tr>
                    <tr>
                        <td class="fw-semibold">Sugar Bagged (Qtls)</td>
                        <td class="text-end">{{ reportData.mfg.sugarBaggedMonth | number:2 }}</td>
                        <td class="text-end">{{ reportData.mfg.sugarBaggedSeason | number:2 }}</td>
                    </tr>
                    <tr>
                        <td class="fw-semibold">Sugar in Process (Qtls)</td>
                        <td class="text-end">{{ reportData.mfg.sipMonth | number:2 }}</td>
                        <td class="text-end">{{ reportData.mfg.sipSeason | number:2 }}</td>
                    </tr>
                    <tr class="bg-light fw-bold" style="border-top: 2px solid #000;">
                        <td>TOTAL NET SUGAR MADE (QTLS)</td>
                        <td class="text-end">{{ reportData.mfg.netSugarMonth | number:2 }}</td>
                        <td class="text-end">{{ reportData.mfg.netSugarSeason | number:2 }}</td>
                    </tr>
                    <tr class="bg-dark text-white fw-bold">
                        <td class="text-white">RECOVERY % CANE</td>
                        <td class="text-end text-white">{{ reportData.mfg.recMonth | number:2 }}</td>
                        <td class="text-end text-white">{{ reportData.mfg.recSeason | number:2 }}</td>
                    </tr>
                </tbody>
            </table>

            <table class="table-report">
                <thead>
                    <tr><th colspan="7" class="section-header">2.0 Statement of In-Process Stocks (W.I.P.)</th></tr>
                    <tr>
                        <th style="width: 20%; text-align: left;">Material</th>
                        <th class="text-end">Vol (HL)</th>
                        <th class="text-end">Sp. Gr.</th>
                        <th class="text-end">Brix%</th>
                        <th class="text-end">Pol%</th>
                        <th class="text-end">Purity%</th>
                        <th class="text-end">Avail. Sugar</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="wip in reportData.wip">
                        <td>{{ wip.material }}</td>
                        <td class="text-end">{{ wip.volume | number:2 }}</td>
                        <td class="text-end">{{ wip.spGr | number:2 }}</td>
                        <td class="text-end">{{ wip.brix | number:2 }}</td>
                        <td class="text-end">{{ wip.pol | number:2 }}</td>
                        <td class="text-end">{{ wip.purity | number:2 }}</td>
                        <td class="text-end fw-bold">{{ wip.availSugar | number:2 }}</td>
                    </tr>
                    <tr class="bg-light fw-bold" ng-if="reportData.wip.length > 0">
                        <td colspan="6" class="text-end">CONSOLIDATED SUGAR IN PROCESS (QTLS):</td>
                        <td class="text-end text-primary">{{ reportData.mfg.sipMonth | number:2 }}</td>
                    </tr>
                    <tr ng-if="reportData.wip.length === 0">
                        <td colspan="7" class="text-center text-muted">No WIP data found for this month.</td>
                    </tr>
                </tbody>
            </table>

            <table class="table-report">
                <thead>
                    <tr><th colspan="5" class="section-header">3.0 Final Sugar Inventory Account (Qtls)</th></tr>
                    <tr>
                        <th style="width: 24%; text-align: left;">Grade</th>
                        <th class="text-end">Opening Bal</th>
                        <th class="text-end">Produced</th>
                        <th class="text-end">Dispatched</th>
                        <th class="text-end">Closing Bal</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="inv in reportData.inventory">
                        <td class="fw-semibold">{{ inv.grade }}</td>
                        <td class="text-end">{{ inv.opening | number:2 }}</td>
                        <td class="text-end">{{ inv.produced | number:2 }}</td>
                        <td class="text-end">{{ inv.dispatched | number:2 }}</td>
                        <td class="text-end fw-bold">{{ inv.closing | number:2 }}</td>
                    </tr>
                    <tr ng-if="reportData.inventory.length === 0">
                        <td colspan="5" class="text-center text-muted">No inventory data found for this month.</td>
                    </tr>
                </tbody>
            </table>
            
            <div class="row text-center" style="margin-top: 50px;">
                <div class="col-4">
                    <div class="signature-line"></div><span class="small fw-bold">CHIEF CHEMIST</span>
                </div>
                <div class="col-4">
                    <div class="signature-line"></div><span class="small fw-bold">MANAGING DIRECTOR</span>
                </div>
                <div class="col-4">
                    <div class="signature-line"></div><span class="small fw-bold">EXCISE INSPECTOR / GST OFFICER</span><br>
                    <span class="text-muted" style="font-size: 0.65rem;">(Official Seal & Signature)</span>
                </div>
            </div>
        </div>
    </div>
</div>