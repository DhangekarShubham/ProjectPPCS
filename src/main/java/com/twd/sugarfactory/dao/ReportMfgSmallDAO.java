package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyMfgSmall;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportMfgSmallDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public DailyMfgSmall getReportData(String reportDate) {
        DailyMfgSmall data = new DailyMfgSmall();
        data.setReportDate(reportDate);
        
        // Example Query 1: Fetch Cane Crushing (Today & ToDate)
        String sqlCane = "SELECT " +
                         "MAX(crop_day) as crop_day, " +
                         "SUM(CASE WHEN crush_date = ? THEN member_cane_crushed_mt ELSE 0 END) as cane_mem_today, " +
                         "SUM(member_cane_crushed_mt) as cane_mem_todate, " +
                         "SUM(CASE WHEN crush_date = ? THEN non_member_cane_crushed_mt ELSE 0 END) as cane_non_today, " +
                         "SUM(non_member_cane_crushed_mt) as cane_non_todate, " +
                         "SUM(CASE WHEN crush_date = ? THEN other_cane_crushed_mt ELSE 0 END) as cane_oth_today, " +
                         "SUM(other_cane_crushed_mt) as cane_oth_todate " +
                         "FROM daily_crushing_log " +
                         "WHERE season_year = '2025-2026' AND crush_date <= ?";

        // Example Query 2: Fetch Time Accounts (Today & ToDate)
        String sqlTime = "SELECT " +
                         "SUM(CASE WHEN sample_date = ? THEN working_hours ELSE 0 END) as hrs_run_today, " +
                         "SUM(working_hours) as hrs_run_todate, " +
                         "SUM(CASE WHEN sample_date = ? THEN (hours_lost_mechanical + hours_lost_electrical + hours_lost_process) ELSE 0 END) as hrs_stop_today, " +
                         "SUM(hours_lost_mechanical + hours_lost_electrical + hours_lost_process) as hrs_stop_todate " +
                         "FROM daily_time_account " +
                         "WHERE sample_date <= ?";

        // In a real scenario, you would have similar queries for Sugar Bags (joined with material_master), 
        // and Performance Metrics (Mill Extraction, Bagasse %) fetched from calculation tables.

        try (Connection conn = getConnection()) {
            
            // Execute Cane Query
            try (PreparedStatement psCane = conn.prepareStatement(sqlCane)) {
                psCane.setString(1, reportDate);
                psCane.setString(2, reportDate);
                psCane.setString(3, reportDate);
                psCane.setString(4, reportDate);
                ResultSet rs = psCane.executeQuery();
                if (rs.next()) {
                    data.setCropDay(rs.getInt("crop_day"));
                    data.setCaneMemberToday(rs.getDouble("cane_mem_today"));
                    data.setCaneMemberTodate(rs.getDouble("cane_mem_todate"));
                    data.setCaneNonMemberToday(rs.getDouble("cane_non_today"));
                    data.setCaneNonMemberTodate(rs.getDouble("cane_non_todate"));
                    data.setCaneOtherToday(rs.getDouble("cane_oth_today"));
                    data.setCaneOtherTodate(rs.getDouble("cane_oth_todate"));
                    
                    data.setCaneTotalToday(data.getCaneMemberToday() + data.getCaneNonMemberToday() + data.getCaneOtherToday());
                    data.setCaneTotalTodate(data.getCaneMemberTodate() + data.getCaneNonMemberTodate() + data.getCaneOtherTodate());
                }
            }

            // Execute Time Query
            try (PreparedStatement psTime = conn.prepareStatement(sqlTime)) {
                psTime.setString(1, reportDate);
                psTime.setString(2, reportDate);
                psTime.setString(3, reportDate); // Use season start logic here in production
                ResultSet rs = psTime.executeQuery();
                if (rs.next()) {
                    data.setMillRunningHrsToday(rs.getDouble("hrs_run_today"));
                    data.setMillRunningHrsTodate(rs.getDouble("hrs_run_todate"));
                    data.setMillStopHrsToday(rs.getDouble("hrs_stop_today"));
                    data.setMillStopHrsTodate(rs.getDouble("hrs_stop_todate"));
                    
                    // Calculate Crushing Rate (Cane / Running Hrs)
                    if(data.getMillRunningHrsToday() > 0) {
                        data.setCrushingRateExclStopsToday(data.getCaneTotalToday() / (data.getMillRunningHrsToday() / 24)); 
                    }
                    if(data.getMillRunningHrsTodate() > 0) {
                        data.setCrushingRateExclStopsTodate(data.getCaneTotalTodate() / (data.getMillRunningHrsTodate() / 24));
                    }
                }
            }
            
            // Dummy Data for demonstration of the PDF fields (Replace with actual DB Queries)
            data.setSugarL30Today(0.00); data.setSugarL30Todate(0.00);
            data.setSugarTotalToday(0.00); data.setSugarTotalTodate(0.00);
            data.setBagassePctCaneToday(27.19); data.setBagassePctCaneTodate(27.19);
            data.setFiberPctCaneToday(13.02); data.setFiberPctCaneTodate(13.02);
            data.setTotalLossesToday(2.10); data.setTotalLossesTodate(10.35);
            data.setMillExtractionToday(92.35); data.setMillExtractionTodate(92.36);
            data.setReducedMillExtractionToday(92.71); data.setReducedMillExtractionTodate(92.71);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}