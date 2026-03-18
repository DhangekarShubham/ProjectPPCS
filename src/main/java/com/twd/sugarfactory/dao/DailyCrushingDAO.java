package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyCrushing;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DailyCrushingDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public boolean saveCrushingData(DailyCrushing data) {
        String sql = "INSERT INTO daily_crushing_log (crush_date, season_year, crop_day, cane_crushed_today, " +
                     "sugar_produced_today, recovery_percent_today, mill_ext_today, reduced_ext_today, " +
                     "mill_start_today, cogen_export_today) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE " +
                     "crop_day=VALUES(crop_day), cane_crushed_today=VALUES(cane_crushed_today), " +
                     "sugar_produced_today=VALUES(sugar_produced_today), recovery_percent_today=VALUES(recovery_percent_today), " +
                     "mill_ext_today=VALUES(mill_ext_today), reduced_ext_today=VALUES(reduced_ext_today), " +
                     "mill_start_today=VALUES(mill_start_today), cogen_export_today=VALUES(cogen_export_today)";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, data.getCrushDate());
            ps.setString(2, "2025-2026"); // Defaulting to active season
            
            // Standard Fields
            ps.setObject(3, data.getCropDay(), java.sql.Types.INTEGER);
            ps.setObject(4, data.getCaneOnDate(), java.sql.Types.DOUBLE);
            ps.setObject(5, data.getSugarOnDate(), java.sql.Types.DOUBLE);
            ps.setObject(6, data.getPercentOnDate(), java.sql.Types.DOUBLE);
            
            // New Fields
            ps.setObject(7, data.getMillExtOnDate(), java.sql.Types.DOUBLE);
            ps.setObject(8, data.getReducedExtOnDate(), java.sql.Types.DOUBLE);
            ps.setString(9, data.getMillStartOnDate());
            ps.setObject(10, data.getCogenOnDate(), java.sql.Types.DOUBLE);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public DailyCrushing getCrushingData(String crushDate) {
        DailyCrushing data = null;
        
        // 1. Fetch "On Date" Data (Now includes new columns)
        String sqlDaily = "SELECT crop_day, cane_crushed_today, sugar_produced_today, recovery_percent_today, season_year, " +
                          "mill_ext_today, reduced_ext_today, mill_start_today, cogen_export_today " +
                          "FROM daily_crushing_log WHERE crush_date = ?";
                          
        // 2. Fetch "To Date" (Cumulative) Data
        // Co-Gen is summed. Extraction percentages are averaged.
        String sqlCumulative = "SELECT SUM(cane_crushed_today) as total_cane, SUM(sugar_produced_today) as total_sugar, " +
                               "AVG(mill_ext_today) as avg_mill_ext, AVG(reduced_ext_today) as avg_red_ext, " +
                               "SUM(cogen_export_today) as total_cogen " +
                               "FROM daily_crushing_log WHERE season_year = ? AND crush_date <= ?";

        try (Connection conn = getConnection()) {
            
            // --- Step A: Get Daily Data ---
            try (PreparedStatement psDaily = conn.prepareStatement(sqlDaily)) {
                psDaily.setString(1, crushDate);
                ResultSet rsDaily = psDaily.executeQuery();
                if (rsDaily.next()) {
                    data = new DailyCrushing();
                    data.setCrushDate(crushDate);
                    data.setSeasonYear(rsDaily.getString("season_year"));
                    data.setCropDay(rsDaily.getInt("crop_day"));
                    
                    data.setCaneOnDate(rsDaily.getDouble("cane_crushed_today"));
                    data.setSugarOnDate(rsDaily.getDouble("sugar_produced_today"));
                    data.setPercentOnDate(rsDaily.getDouble("recovery_percent_today"));
                    
                    data.setMillExtOnDate(rsDaily.getDouble("mill_ext_today"));
                    data.setReducedExtOnDate(rsDaily.getDouble("reduced_ext_today"));
                    data.setMillStartOnDate(rsDaily.getString("mill_start_today"));
                    data.setCogenOnDate(rsDaily.getDouble("cogen_export_today"));
                }
            }

            // --- Step B: Get Cumulative Data ---
            if (data != null && data.getSeasonYear() != null) {
                try (PreparedStatement psCum = conn.prepareStatement(sqlCumulative)) {
                    psCum.setString(1, data.getSeasonYear());
                    psCum.setString(2, crushDate);
                    ResultSet rsCum = psCum.executeQuery();
                    
                    if (rsCum.next()) {
                        double totalCane = rsCum.getDouble("total_cane");
                        double totalSugar = rsCum.getDouble("total_sugar");
                        
                        data.setCaneToDate(totalCane);
                        data.setSugarToDate(totalSugar);
                        
                        // Calculate Cumulative Average Recovery % = (Total Sugar / Total Cane) * 100
                        if (totalCane > 0) {
                            double avgRecovery = (totalSugar / totalCane) * 100;
                            data.setPercentToDate(Math.round(avgRecovery * 100.0) / 100.0);
                        } else {
                            data.setPercentToDate(0.0);
                        }
                        
                        // Set New Cumulative Fields
                        data.setMillExtToDate(Math.round(rsCum.getDouble("avg_mill_ext") * 100.0) / 100.0);
                        data.setReducedExtToDate(Math.round(rsCum.getDouble("avg_red_ext") * 100.0) / 100.0);
                        data.setCogenToDate(rsCum.getDouble("total_cogen"));
                        
                        // Mill Start doesn't have a cumulative sum, so we just mirror the daily value or leave it blank
                        data.setMillStartToDate(data.getMillStartOnDate());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    public boolean deleteCrushingData(String crushDate) {
        String sql = "DELETE FROM daily_crushing_log WHERE crush_date = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, crushDate);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}