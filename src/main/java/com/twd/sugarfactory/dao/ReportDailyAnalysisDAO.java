package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyAnalysisReport;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportDailyAnalysisDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sugar_plant_erp?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", 
            "root", 
            "root"
        );
    }

    public DailyAnalysisReport getDailyAnalysisByDate(String sampleDate) {
        DailyAnalysisReport report = null;
        
        // Adjust this query to match your actual database tables or views
        String sql = "SELECT * FROM daily_analysis_data WHERE sample_date = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, sampleDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    report = new DailyAnalysisReport();
                    
                    report.setSeasonYear(rs.getString("season_year"));
                    
                    // Time & Throughput
                    report.setWorkingHours(rs.getDouble("working_hours"));
                    report.setLostHours(rs.getDouble("lost_hours"));
                    report.setMemberCane(rs.getDouble("member_cane"));
                    report.setNonMemberCane(rs.getDouble("non_member_cane"));
                    report.setTotalCrushed(rs.getDouble("total_crushed"));
                    
                    // Corrections
                    report.setDirtCorrection(rs.getDouble("dirt_correction"));
                    report.setRecoveryCorrection(rs.getDouble("recovery_correction"));
                    report.setUndeterminedLosses(rs.getDouble("undetermined_losses"));
                    report.setCondenserInlet(rs.getDouble("condenser_inlet"));
                    report.setCondenserOutlet(rs.getDouble("condenser_outlet"));
                    
                    // By-Products
                    report.setBagassePol(rs.getDouble("bagasse_pol"));
                    report.setBagasseMoist(rs.getDouble("bagasse_moist"));
                    report.setFilterCakePol(rs.getDouble("filter_cake_pol"));
                    report.setFilterCakeMoist(rs.getDouble("filter_cake_moist"));
                    
                    // Sugar
                    report.setSugarM30(rs.getInt("sugar_m30"));
                    report.setSugarS130(rs.getInt("sugar_s130"));
                    report.setTotalBags(rs.getInt("total_bags"));
                    
                    // Process Juices
                    report.setPjBrix(rs.getDouble("pj_brix"));
                    report.setPjPole(rs.getDouble("pj_pol"));
                    report.setPjPurity(rs.getDouble("pj_purity"));
                    
                    report.setMjBrix(rs.getDouble("mj_brix"));
                    report.setMjPole(rs.getDouble("mj_pol"));
                    report.setMjPurity(rs.getDouble("mj_purity"));
                    
                    report.setCjBrix(rs.getDouble("cj_brix"));
                    report.setCjPole(rs.getDouble("cj_pol"));
                    report.setCjPurity(rs.getDouble("cj_purity"));
                    
                    report.setFmBrix(rs.getDouble("fm_brix"));
                    report.setFmPole(rs.getDouble("fm_pol"));
                    report.setFmPurity(rs.getDouble("fm_purity"));
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching Daily Analysis: " + e.getMessage());
            e.printStackTrace();
        }
        return report;
    }
}