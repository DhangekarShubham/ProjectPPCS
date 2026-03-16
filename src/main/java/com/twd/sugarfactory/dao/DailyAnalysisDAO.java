package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyDataAnalysis;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DailyAnalysisDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public boolean saveDailyAnalysis(DailyDataAnalysis data) {
        // We use a transaction to ensure all related tables update together
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // 1. Insert into daily_crushing_log (Base Data)
            String sqlBase = "INSERT INTO daily_crushing_log (sample_date, season_year, member_cane_crushed_mt, non_member_cane_crushed_mt, filter_cake_weight_mt, dirt_correction_pct, recovery_correction_pct, undetermined_losses_pct, condenser_inlet_temp, condenser_outlet_temp) VALUES (?, '2025-2026', ?, ?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE member_cane_crushed_mt=VALUES(member_cane_crushed_mt)";
            try (PreparedStatement ps = conn.prepareStatement(sqlBase)) {
                ps.setString(1, data.getSampleDate());
                ps.setDouble(2, data.getMemberCane() != null ? data.getMemberCane() : 0.0);
                ps.setDouble(3, data.getNonMemberCane() != null ? data.getNonMemberCane() : 0.0);
                ps.setDouble(4, data.getFcWeight() != null ? data.getFcWeight() : 0.0);
                ps.setDouble(5, data.getDirtCorrection() != null ? data.getDirtCorrection() : 0.0);
                ps.setDouble(6, data.getRecoveryCorrection() != null ? data.getRecoveryCorrection() : 0.0);
                ps.setDouble(7, data.getUndetLosses() != null ? data.getUndetLosses() : 0.0);
                ps.setDouble(8, data.getInletTemp() != null ? data.getInletTemp() : 0.0);
                ps.setDouble(9, data.getOutletTemp() != null ? data.getOutletTemp() : 0.0);
                ps.executeUpdate();
            }

            // 2. Insert Time Account
            String sqlTime = "INSERT INTO daily_time_account (sample_date, working_hours, hours_lost_mechanical, hours_lost_electrical) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE working_hours=VALUES(working_hours)";
            try (PreparedStatement ps = conn.prepareStatement(sqlTime)) {
                ps.setString(1, data.getSampleDate());
                ps.setDouble(2, data.getWorkHours() != null ? data.getWorkHours() : 0.0);
                ps.setDouble(3, data.getLostMech() != null ? data.getLostMech() : 0.0);
                ps.setDouble(4, data.getLostElec() != null ? data.getLostElec() : 0.0);
                ps.executeUpdate();
            }

            // 3. Insert Lab Analysis Details (Example: Primary Juice mapped to material_id 1)
            String sqlLab = "INSERT INTO daily_lab_analysis_details (sample_date, material_id, brix_pct, pol_pct, purity_pct) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE brix_pct=VALUES(brix_pct), pol_pct=VALUES(pol_pct)";
            try (PreparedStatement ps = conn.prepareStatement(sqlLab)) {
                // Primary Juice (material_id = 1)
                ps.setString(1, data.getSampleDate());
                ps.setInt(2, 1);
                ps.setObject(3, data.getPjBrix());
                ps.setObject(4, data.getPjPole());
                ps.setObject(5, data.getPjPurity());
                ps.executeUpdate();
                
                // You would repeat this block or use a batch execution for Mixed Juice(2), Clear Juice(4), etc.
            }

            conn.commit(); // End Transaction
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
}