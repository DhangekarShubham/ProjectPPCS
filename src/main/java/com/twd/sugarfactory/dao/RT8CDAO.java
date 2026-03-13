package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.RT8CPerformance;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RT8CDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    public RT8CPerformance getPerformanceData(String reportDate) {
        String sql = "SELECT * FROM rt8c_technical_performance WHERE report_date = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, reportDate);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                RT8CPerformance data = new RT8CPerformance();
                data.setReportDate(rs.getString("report_date"));
                data.setSeasonYear(rs.getString("season_year"));
                
                data.setYieldAdsali(rs.getDouble("yield_adsali"));
                data.setYieldPlant(rs.getDouble("yield_plant"));
                data.setYieldRatoon(rs.getDouble("yield_ratoon"));
                data.setPrepIndex(rs.getDouble("prep_index"));
                // Map custom fields to existing DB structure or alter DB to match exactly. 
                // Assuming DB has these columns based on standard requirements:
                data.setBagassePctCane(rs.getDouble("bagasse_pct_cane"));
                
                data.setBagasseOpening(rs.getDouble("bagasse_opening_bal"));
                data.setBagasseProduction(rs.getDouble("bagasse_production"));
                data.setBagasseBoiler(rs.getDouble("bagasse_used_boiler"));
                data.setBagasseCogen(rs.getDouble("bagasse_used_cogen"));
                
                return data;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean savePerformanceData(RT8CPerformance data) {
        // Requires columns to exist in rt8c_technical_performance table
        String sql = "INSERT INTO rt8c_technical_performance " +
                     "(report_date, season_year, yield_adsali, yield_plant, yield_ratoon, prep_index, bagasse_pct_cane, bagasse_opening_bal, bagasse_production, bagasse_used_boiler, bagasse_used_cogen) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE " +
                     "yield_adsali=VALUES(yield_adsali), yield_plant=VALUES(yield_plant), yield_ratoon=VALUES(yield_ratoon), prep_index=VALUES(prep_index), " +
                     "bagasse_pct_cane=VALUES(bagasse_pct_cane), bagasse_opening_bal=VALUES(bagasse_opening_bal), bagasse_production=VALUES(bagasse_production), " +
                     "bagasse_used_boiler=VALUES(bagasse_used_boiler), bagasse_used_cogen=VALUES(bagasse_used_cogen)";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, data.getReportDate());
            ps.setString(2, data.getSeasonYear() != null ? data.getSeasonYear() : "2025-2026");
            
            ps.setObject(3, data.getYieldAdsali(), java.sql.Types.DOUBLE);
            ps.setObject(4, data.getYieldPlant(), java.sql.Types.DOUBLE);
            ps.setObject(5, data.getYieldRatoon(), java.sql.Types.DOUBLE);
            ps.setObject(6, data.getPrepIndex(), java.sql.Types.DOUBLE);
            ps.setObject(7, data.getBagassePctCane(), java.sql.Types.DOUBLE);
            
            ps.setObject(8, data.getBagasseOpening(), java.sql.Types.DOUBLE);
            ps.setObject(9, data.getBagasseProduction(), java.sql.Types.DOUBLE);
            ps.setObject(10, data.getBagasseBoiler(), java.sql.Types.DOUBLE);
            ps.setObject(11, data.getBagasseCogen(), java.sql.Types.DOUBLE);
            
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deletePerformanceData(String reportDate) {
        String sql = "DELETE FROM rt8c_technical_performance WHERE report_date = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reportDate);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}