package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyTonReport;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportDailyTonDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public DailyTonReport getTonReportData(String reportDate) {
        DailyTonReport data = new DailyTonReport();
        data.setReportDate(reportDate);
        
        // This query simulates aggregating data from a daily_crushing_log and a weighbridge_log
        String sql = "SELECT " +
                     "MAX(crop_day) as crop_day, MAX(season_year) as season_year, " +
                     
                     // Member / Non-Member Status
                     "SUM(CASE WHEN crush_date = ? THEN member_cane_crushed_mt ELSE 0 END) as mem_today, " +
                     "SUM(member_cane_crushed_mt) as mem_todate, " +
                     "SUM(CASE WHEN crush_date = ? THEN non_member_cane_crushed_mt ELSE 0 END) as non_mem_today, " +
                     "SUM(non_member_cane_crushed_mt) as non_mem_todate " +
                     
                     // Note: In production, Shift and Transport data would come from joining a 'weighbridge_receipts' table.
                     // For this ERP calculation core, we fetch the base data.
                     "FROM daily_crushing_log WHERE season_year = '2025-2026' AND crush_date <= ?";

        // Fetching Time Account for To-Date Hours
        String sqlTime = "SELECT SUM(working_hours) as total_hrs_todate FROM daily_time_account WHERE sample_date <= ?";

        try (Connection conn = getConnection()) {
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
            	ps.setDate(1, java.sql.Date.valueOf(reportDate));
            	ps.setDate(2, java.sql.Date.valueOf(reportDate));
            	ps.setDate(3, java.sql.Date.valueOf(reportDate));
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    data.setCropDay(rs.getInt("crop_day"));
                    data.setSeasonYear(rs.getString("season_year"));
                    
                    data.setMemberCaneToday(rs.getDouble("mem_today"));
                    data.setMemberCaneTodate(rs.getDouble("mem_todate"));
                    data.setNonMemberCaneToday(rs.getDouble("non_mem_today"));
                    data.setNonMemberCaneTodate(rs.getDouble("non_mem_todate"));
                    
                    // --- MOCK DATA FOR WEIGHBRIDGE SPECIFICS (Since the provided schema focuses on lab/process) ---
                    // In a live system, replace this block with actual DB queries fetching from the weighbridge module.
                    double totalToday = data.getMemberCaneToday() + data.getNonMemberCaneToday();
                    double totalTodate = data.getMemberCaneTodate() + data.getNonMemberCaneTodate();
                    
                    // Distribute mock shift data
                    data.setShiftACane(totalToday * 0.35); data.setShiftAHours(8.0);
                    data.setShiftBCane(totalToday * 0.35); data.setShiftBHours(8.0);
                    data.setShiftCCane(totalToday * 0.30); data.setShiftCHours(8.0);
                    
                    // Distribute mock transport data
                    data.setBullockCartToday(totalToday * 0.15); data.setBullockCartTodate(totalTodate * 0.15);
                    data.setTractorToday(totalToday * 0.55); data.setTractorTodate(totalTodate * 0.55);
                    data.setTruckToday(totalToday * 0.30); data.setTruckTodate(totalTodate * 0.30);
                }
            }

            try (PreparedStatement psTime = conn.prepareStatement(sqlTime)) {
                psTime.setString(1, reportDate);
                ResultSet rs = psTime.executeQuery();
                if (rs.next()) {
                    data.setTotalHoursTodate(rs.getDouble("total_hrs_todate"));
                    
                    // Mock data fallback if Time Account table is empty
                    if(data.getTotalHoursTodate() == 0) data.setTotalHoursTodate(data.getCropDay() * 24.0);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}