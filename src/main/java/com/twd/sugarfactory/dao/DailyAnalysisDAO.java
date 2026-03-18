package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyDataAnalysis;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class DailyAnalysisDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    private String formatDbDate(String dateStr) {
        if (dateStr != null && dateStr.contains("T")) {
            return dateStr.split("T")[0];
        }
        return dateStr;
    }

    private Double getDoubleOrNull(ResultSet rs, String column) throws SQLException {
        double val = rs.getDouble(column);
        return rs.wasNull() ? null : val;
    }

    public boolean saveDailyAnalysis(DailyDataAnalysis data) {
        String cleanedDate = formatDbDate(data.getSampleDate());
        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // 1. Main Crushing Table
            String sqlBase = "INSERT INTO daily_crushing_log (crush_date, season_year, member_cane_crushed_mt, " +
                             "non_member_cane_crushed_mt, filter_cake_weight_mt, dirt_correction_pct, " +
                             "recovery_correction_pct, undetermined_losses_pct, condenser_inlet_temp, condenser_outlet_temp) " +
                             "VALUES (?, '2025-2026', ?, ?, ?, ?, ?, ?, ?, ?) " +
                             "ON DUPLICATE KEY UPDATE member_cane_crushed_mt=VALUES(member_cane_crushed_mt), " +
                             "non_member_cane_crushed_mt=VALUES(non_member_cane_crushed_mt), filter_cake_weight_mt=VALUES(filter_cake_weight_mt), " +
                             "dirt_correction_pct=VALUES(dirt_correction_pct), recovery_correction_pct=VALUES(recovery_correction_pct), " +
                             "undetermined_losses_pct=VALUES(undetermined_losses_pct), condenser_inlet_temp=VALUES(condenser_inlet_temp), " +
                             "condenser_outlet_temp=VALUES(condenser_outlet_temp)";
            
            try (PreparedStatement ps = conn.prepareStatement(sqlBase)) {
                ps.setString(1, cleanedDate);
                ps.setObject(2, data.getMemberCane());
                ps.setObject(3, data.getNonMemberCane());
                ps.setObject(4, data.getFcWeight());
                ps.setObject(5, data.getDirtCorrection());
                ps.setObject(6, data.getRecoveryCorrection());
                ps.setObject(7, data.getUndetLosses());
                ps.setObject(8, data.getInletTemp());
                ps.setObject(9, data.getOutletTemp());
                ps.executeUpdate();
            }

            // 2. Time Account
            String sqlTime = "INSERT INTO daily_time_account (crush_date, working_hours, hours_lost_mechanical, hours_lost_electrical) " +
                             "VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE working_hours=VALUES(working_hours), " +
                             "hours_lost_mechanical=VALUES(hours_lost_mechanical), hours_lost_electrical=VALUES(hours_lost_electrical)";
            try (PreparedStatement ps = conn.prepareStatement(sqlTime)) {
                ps.setString(1, cleanedDate);
                ps.setObject(2, data.getWorkHours());
                ps.setObject(3, data.getLostMech());
                ps.setObject(4, data.getLostElec());
                ps.executeUpdate();
            }

            // 3. Lab Analysis
            String sqlLab = "INSERT INTO daily_lab_analysis_details (crush_date, material_id, brix_pct, pol_pct, purity_pct, moisture_pct) " +
                             "VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE brix_pct=VALUES(brix_pct), " +
                             "pol_pct=VALUES(pol_pct), purity_pct=VALUES(purity_pct), moisture_pct=VALUES(moisture_pct)";
            
            try (PreparedStatement ps = conn.prepareStatement(sqlLab)) {
                if(data.getPjBrix() != null) saveLabRow(ps, cleanedDate, 1, data.getPjBrix(), data.getPjPole(), data.getPjPurity(), null);
                if(data.getMjBrix() != null) saveLabRow(ps, cleanedDate, 2, data.getMjBrix(), data.getMjPole(), data.getMjPurity(), null);
                if(data.getCjBrix() != null) saveLabRow(ps, cleanedDate, 4, data.getCjBrix(), data.getCjPole(), data.getCjPurity(), null);
                if(data.getFmBrix() != null) saveLabRow(ps, cleanedDate, 9, data.getFmBrix(), data.getFmPole(), data.getFmPurity(), null);
                if(data.getBagassePol() != null) saveLabRow(ps, cleanedDate, 10, null, data.getBagassePol(), null, data.getBagasseMoist());
            }

            // 4. Sugar Bags
            String sqlSugar = "INSERT INTO daily_sugar_production (crush_date, material_id, no_of_bags) VALUES (?, ?, ?) " +
                              "ON DUPLICATE KEY UPDATE no_of_bags=VALUES(no_of_bags)";
            try (PreparedStatement ps = conn.prepareStatement(sqlSugar)) {
                if (data.getBagsL30_50() != null) saveSugarRow(ps, cleanedDate, 50, data.getBagsL30_50());
                if (data.getBagsM30_50() != null) saveSugarRow(ps, cleanedDate, 51, data.getBagsM30_50());
                if (data.getBagsS130_50() != null) saveSugarRow(ps, cleanedDate, 52, data.getBagsS130_50());
                if (data.getBagsRaw_50() != null) saveSugarRow(ps, cleanedDate, 53, data.getBagsRaw_50());
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    private void saveLabRow(PreparedStatement ps, String date, int matId, Double brix, Double pol, Double pur, Double moist) throws SQLException {
        ps.setString(1, date);
        ps.setInt(2, matId);
        ps.setObject(3, brix);
        ps.setObject(4, pol);
        ps.setObject(5, pur);
        ps.setObject(6, moist);
        ps.executeUpdate();
    }

    private void saveSugarRow(PreparedStatement ps, String date, int matId, Integer bags) throws SQLException {
        ps.setString(1, date);
        ps.setInt(2, matId);
        ps.setObject(3, bags);
        ps.executeUpdate();
    }

    public DailyDataAnalysis getDailyAnalysis(String sampleDate) {
        String cleanedDate = formatDbDate(sampleDate);
        DailyDataAnalysis data = new DailyDataAnalysis();
        data.setSampleDate(cleanedDate);
        
        try (Connection conn = getConnection()) {
            // 1. Crushing Log
            String q1 = "SELECT * FROM daily_crushing_log WHERE crush_date = ?";
            try (PreparedStatement ps = conn.prepareStatement(q1)) {
                ps.setString(1, cleanedDate);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        data.setMemberCane(getDoubleOrNull(rs, "member_cane_crushed_mt"));
                        data.setNonMemberCane(getDoubleOrNull(rs, "non_member_cane_crushed_mt"));
                        data.setFcWeight(getDoubleOrNull(rs, "filter_cake_weight_mt"));
                        data.setDirtCorrection(getDoubleOrNull(rs, "dirt_correction_pct"));
                        data.setRecoveryCorrection(getDoubleOrNull(rs, "recovery_correction_pct"));
                        data.setUndetLosses(getDoubleOrNull(rs, "undetermined_losses_pct"));
                        data.setInletTemp(getDoubleOrNull(rs, "condenser_inlet_temp"));
                        data.setOutletTemp(getDoubleOrNull(rs, "condenser_outlet_temp"));
                    } else { return null; }
                }
            }
            
            // 2. Time Account
            String q2 = "SELECT * FROM daily_time_account WHERE crush_date = ?";
            try (PreparedStatement ps = conn.prepareStatement(q2)) {
                ps.setString(1, cleanedDate);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        data.setWorkHours(getDoubleOrNull(rs, "working_hours"));
                        data.setLostMech(getDoubleOrNull(rs, "hours_lost_mechanical"));
                        data.setLostElec(getDoubleOrNull(rs, "hours_lost_electrical"));
                    }
                }
            }
            
            // 3. Lab Details
            String q3 = "SELECT material_id, brix_pct, pol_pct, purity_pct, moisture_pct FROM daily_lab_analysis_details WHERE crush_date = ?";
            try (PreparedStatement ps = conn.prepareStatement(q3)) {
                ps.setString(1, cleanedDate);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("material_id");
                        if (id == 1) { data.setPjBrix(getDoubleOrNull(rs, "brix_pct")); data.setPjPole(getDoubleOrNull(rs, "pol_pct")); data.setPjPurity(getDoubleOrNull(rs, "purity_pct")); }
                        if (id == 2) { data.setMjBrix(getDoubleOrNull(rs, "brix_pct")); data.setMjPole(getDoubleOrNull(rs, "pol_pct")); data.setMjPurity(getDoubleOrNull(rs, "purity_pct")); }
                        if (id == 4) { data.setCjBrix(getDoubleOrNull(rs, "brix_pct")); data.setCjPole(getDoubleOrNull(rs, "pol_pct")); data.setCjPurity(getDoubleOrNull(rs, "purity_pct")); }
                        if (id == 9) { data.setFmBrix(getDoubleOrNull(rs, "brix_pct")); data.setFmPole(getDoubleOrNull(rs, "pol_pct")); data.setFmPurity(getDoubleOrNull(rs, "purity_pct")); }
                        if (id == 10) { data.setBagassePol(getDoubleOrNull(rs, "pol_pct")); data.setBagasseMoist(getDoubleOrNull(rs, "moisture_pct")); }
                    }
                }
            }

            // 4. Sugar Production
            String q4 = "SELECT material_id, no_of_bags FROM daily_sugar_production WHERE crush_date = ?";
            try (PreparedStatement ps = conn.prepareStatement(q4)) {
                ps.setString(1, cleanedDate);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("material_id");
                        int bags = rs.getInt("no_of_bags");
                        if (id == 50) data.setBagsL30_50(bags);
                        if (id == 51) data.setBagsM30_50(bags);
                        if (id == 52) data.setBagsS130_50(bags);
                        if (id == 53) data.setBagsRaw_50(bags);
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return data;
    }

    public Map<String, Object> getCumulativeTotals(String sampleDate, String seasonYear) {
        String cleanedDate = formatDbDate(sampleDate);
        Map<String, Object> totals = new HashMap<>();
        String sql = "SELECT SUM(member_cane_crushed_mt + non_member_cane_crushed_mt) as total_cane, " +
                     "SUM(filter_cake_weight_mt) as total_fc FROM daily_crushing_log " +
                     "WHERE season_year = ? AND crush_date <= ?";
        
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, seasonYear);
            ps.setString(2, cleanedDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totals.put("totalCane", rs.getDouble("total_cane"));
                    totals.put("totalFilterCake", rs.getDouble("total_fc"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return totals;
    }

    public boolean deleteDailyAnalysis(String sampleDate) {
        String cleanedDate = formatDbDate(sampleDate);
        String sql = "DELETE FROM daily_crushing_log WHERE crush_date = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cleanedDate);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
