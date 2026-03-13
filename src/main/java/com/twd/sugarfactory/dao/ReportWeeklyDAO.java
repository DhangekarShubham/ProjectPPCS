package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.WeeklyReport;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportWeeklyDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    public WeeklyReport getWeeklyReportData(Integer weekNo, String fromDate, String toDate) {
        WeeklyReport data = new WeeklyReport();
        data.setWeekNo(weekNo);
        data.setFromDate(fromDate);
        data.setToDate(toDate);
        data.setSeasonYear("2025-2026");

        // Example Query to aggregate Base Crushing Data
        // Using conditional aggregation to get both "Week" and "To-Date" in one pass
        String sql = "SELECT " +
                     "SUM(CASE WHEN crush_date BETWEEN ? AND ? THEN (member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) ELSE 0 END) as cane_week, " +
                     "SUM(CASE WHEN crush_date <= ? THEN (member_cane_crushed_mt + non_member_cane_crushed_mt + other_cane_crushed_mt) ELSE 0 END) as cane_todate, " +
                     
                     "SUM(CASE WHEN crush_date BETWEEN ? AND ? THEN sugar_produced_today ELSE 0 END) as sugar_week, " +
                     "SUM(CASE WHEN crush_date <= ? THEN sugar_produced_today ELSE 0 END) as sugar_todate " +
                     "FROM daily_crushing_log WHERE season_year = '2025-2026'";

        // Example Query to aggregate Time Account
        String sqlTime = "SELECT " +
                         "SUM(CASE WHEN sample_date BETWEEN ? AND ? THEN working_hours ELSE 0 END) as run_week, " +
                         "SUM(CASE WHEN sample_date <= ? THEN working_hours ELSE 0 END) as run_todate, " +
                         "SUM(CASE WHEN sample_date BETWEEN ? AND ? THEN (hours_lost_mechanical + hours_lost_electrical + hours_lost_process) ELSE 0 END) as stop_week, " +
                         "SUM(CASE WHEN sample_date <= ? THEN (hours_lost_mechanical + hours_lost_electrical + hours_lost_process) ELSE 0 END) as stop_todate " +
                         "FROM daily_time_account";

        try (Connection conn = getConnection()) {
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, fromDate); ps.setString(2, toDate); ps.setString(3, toDate);
                ps.setString(4, fromDate); ps.setString(5, toDate); ps.setString(6, toDate);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    data.setCaneCrushedWeek(rs.getDouble("cane_week"));
                    data.setCaneCrushedTodate(rs.getDouble("cane_todate"));
                    data.setSugarBaggedWeek(rs.getDouble("sugar_week"));
                    data.setSugarBaggedTodate(rs.getDouble("sugar_todate"));
                }
            }

            try (PreparedStatement psTime = conn.prepareStatement(sqlTime)) {
                psTime.setString(1, fromDate); psTime.setString(2, toDate); psTime.setString(3, toDate);
                psTime.setString(4, fromDate); psTime.setString(5, toDate); psTime.setString(6, toDate);
                ResultSet rs = psTime.executeQuery();
                if (rs.next()) {
                    data.setCrushingHrsWeek(rs.getDouble("run_week"));
                    data.setCrushingHrsTodate(rs.getDouble("run_todate"));
                    data.setLostHrsWeek(rs.getDouble("stop_week"));
                    data.setLostHrsTodate(rs.getDouble("stop_todate"));
                }
            }
            
            // --- MOCK DATA FOR COMPLEX CALCULATIONS ---
            // In a production ERP, these technical parameters (Mill Extraction, Boiling House Recovery) 
            // are usually pulled from a pre-calculated `weekly_performance_log` table, as they require 
            // complex weighted averages based on Pol, Brix, and Fibre formulas.
            
            // 1. Calculations based on fetched data
            data.setSugarInProcessWeek(120.50); // Mock
            data.setSugarInProcessTodate(120.50); // Mock
            
            data.setTotalSugarMadeWeek(data.getSugarBaggedWeek() + data.getSugarInProcessWeek());
            data.setTotalSugarMadeTodate(data.getSugarBaggedTodate() + data.getSugarInProcessTodate());
            
            if(data.getCaneCrushedWeek() > 0) data.setRecoveryWeek((data.getTotalSugarMadeWeek() / data.getCaneCrushedWeek()) * 100);
            if(data.getCaneCrushedTodate() > 0) data.setRecoveryTodate((data.getTotalSugarMadeTodate() / data.getCaneCrushedTodate()) * 100);
            
            data.setAvailableHrsWeek(data.getCrushingHrsWeek() + data.getLostHrsWeek());
            data.setAvailableHrsTodate(data.getCrushingHrsTodate() + data.getLostHrsTodate());
            
            if(data.getCrushingHrsWeek() > 0) data.setCrushRateWeek(data.getCaneCrushedWeek() / (data.getCrushingHrsWeek() / 24));
            if(data.getCrushingHrsTodate() > 0) data.setCrushRateTodate(data.getCaneCrushedTodate() / (data.getCrushingHrsTodate() / 24));

            // 2. Technical Parameters (Mocked for UI mapping)
            data.setMillExtWeek(95.42); data.setMillExtTodate(95.19);
            data.setRedMillExtWeek(95.80); data.setRedMillExtTodate(95.65);
            data.setBoilingHouseExtWeek(88.55); data.setBoilingHouseExtTodate(88.20);
            data.setOverallExtWeek(84.49); data.setOverallExtTodate(83.95);
            data.setSugarLossesWeek(2.05); data.setSugarLossesTodate(2.12);
            data.setBagassePctWeek(28.50); data.setBagassePctTodate(29.15);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}