package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyTonReport;
import java.sql.Connection;
import java.sql.Date;
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
        String sql = "SELECT MAX(crop_day) as crop_day, MAX(season_year) as season_year, " +
                "SUM(CASE WHEN crush_date = ? THEN member_cane_crushed_mt ELSE 0 END) as mem_today, " +
                "SUM(CASE WHEN crush_date <= ? THEN member_cane_crushed_mt ELSE 0 END) as mem_todate, " +
                "SUM(CASE WHEN crush_date = ? THEN non_member_cane_crushed_mt ELSE 0 END) as non_mem_today, " +
                "SUM(CASE WHEN crush_date <= ? THEN non_member_cane_crushed_mt ELSE 0 END) as non_mem_todate " +
                "FROM daily_crushing_log WHERE season_year = ?";

        String sqlTime = "SELECT SUM(working_hours) as total_hrs_todate " +
                "FROM daily_time_account WHERE crush_date <= ? AND season_year = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                PreparedStatement psTime = conn.prepareStatement(sqlTime)) {

               Date sqlDate = Date.valueOf(reportDate);

               // Crushing log query
               ps.setDate(1, sqlDate);
               ps.setDate(2, sqlDate);
               ps.setDate(3, sqlDate);
               ps.setDate(4, sqlDate);
               ps.setString(5, "2025-2026");  // default season year
               try (ResultSet rs = ps.executeQuery()) {
                   if (rs.next()) {
                       data.setCropDay(rs.getInt("crop_day"));
                       data.setSeasonYear(rs.getString("season_year"));
                       data.setMemberCaneToday(rs.getDouble("mem_today"));
                       data.setMemberCaneTodate(rs.getDouble("mem_todate"));
                       data.setNonMemberCaneToday(rs.getDouble("non_mem_today"));
                       data.setNonMemberCaneTodate(rs.getDouble("non_mem_todate"));
                       
                       double totalToday = data.getMemberCaneToday() + data.getNonMemberCaneToday();
                       double totalTodate = data.getMemberCaneTodate() + data.getNonMemberCaneTodate();

                       // Mock shift distribution
                       data.setShiftACane(totalToday * 0.35); data.setShiftAHours(8.0);
                       data.setShiftBCane(totalToday * 0.35); data.setShiftBHours(8.0);
                       data.setShiftCCane(totalToday * 0.30); data.setShiftCHours(8.0);

                       // Mock transport distribution
                       data.setBullockCartToday(totalToday * 0.15); data.setBullockCartTodate(totalTodate * 0.15);
                       data.setTractorToday(totalToday * 0.55); data.setTractorTodate(totalTodate * 0.55);
                       data.setTruckToday(totalToday * 0.30); data.setTruckTodate(totalTodate * 0.30);
                   }
               }
               
            // Time account query
               psTime.setDate(1, sqlDate);
               psTime.setString(2, "2025-2026");  // default season year

               try (ResultSet rsTime = psTime.executeQuery()) {
                   if (rsTime.next()) {
                       data.setTotalHoursTodate(rsTime.getDouble("total_hrs_todate"));
                       if (data.getTotalHoursTodate() == 0) {
                           data.setTotalHoursTodate(data.getCropDay() * 24.0);
                       }
                   }
               }
               
        } catch (Exception e) {
            e.printStackTrace(); // replace with proper logging
        }

        return data;
    }
}


