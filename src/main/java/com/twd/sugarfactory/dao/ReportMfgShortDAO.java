package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyMfgShort;
import java.sql.*;

public class ReportMfgShortDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "root");
    }

    public DailyMfgShort getReportData(String reportDate) {
        DailyMfgShort data = new DailyMfgShort();
        data.setReportDate(reportDate);

        // SQL 1: Cane Crushing & Performance (Aggregated to-date)
        String sqlCane = "SELECT " +
                "MAX(CASE WHEN crush_date = ? THEN crop_day ELSE 0 END) as crop_day, " +
                "SUM(CASE WHEN crush_date = ? THEN member_cane_crushed_mt ELSE 0 END) as cane_mem_today, " +
                "SUM(member_cane_crushed_mt) as cane_mem_todate, " +
                "SUM(CASE WHEN crush_date = ? THEN non_member_cane_crushed_mt ELSE 0 END) as cane_non_today, " +
                "SUM(non_member_cane_crushed_mt) as cane_non_todate, " +
                "SUM(CASE WHEN crush_date = ? THEN other_cane_crushed_mt ELSE 0 END) as cane_oth_today, " +
                "SUM(other_cane_crushed_mt) as cane_oth_todate, " +
                "MAX(CASE WHEN crush_date = ? THEN condenser_inlet_temp ELSE 0 END) as inlet, " +
                "MAX(CASE WHEN crush_date = ? THEN condenser_outlet_temp ELSE 0 END) as outlet, " +
                "MAX(CASE WHEN crush_date = ? THEN recovery_percent_today ELSE 0 END) as rec_pct, " +
                "SUM(CASE WHEN crush_date = ? THEN cogen_export_today ELSE 0 END) as cogen " +
                "FROM daily_crushing_log WHERE season_year = '2025-2026' AND crush_date <= ?";

        // SQL 2: Sugar Production (Quintals)
        String sqlSugar = "SELECT " +
                "SUM(CASE WHEN s.crush_date = ? AND m.material_name LIKE 'L-30%' THEN s.no_of_bags ELSE 0 END) as l30_today, " +
                "SUM(CASE WHEN m.material_name LIKE 'L-30%' THEN s.no_of_bags ELSE 0 END) as l30_todate, " +
                "SUM(CASE WHEN s.crush_date = ? AND m.material_name LIKE 'M-30%' THEN s.no_of_bags ELSE 0 END) as m30_today, " +
                "SUM(CASE WHEN m.material_name LIKE 'M-30%' THEN s.no_of_bags ELSE 0 END) as m30_todate, " +
                "SUM(CASE WHEN s.crush_date = ? AND m.material_name LIKE 'S1-30%' THEN s.no_of_bags ELSE 0 END) as s130_today, " +
                "SUM(CASE WHEN m.material_name LIKE 'S1-30%' THEN s.no_of_bags ELSE 0 END) as s130_todate " +
                "FROM daily_sugar_production s " +
                "JOIN material_master m ON s.material_id = m.material_id " +
                "WHERE s.crush_date <= ?";

        try (Connection conn = getConnection()) {
            // 1. Process Cane Data
            try (PreparedStatement ps = conn.prepareStatement(sqlCane)) {
                for (int i = 1; i <= 8; i++) ps.setString(i, reportDate);
                ps.setString(9, reportDate);
                ResultSet rs = ps.executeQuery();
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
                    
                    data.setInletTemp(rs.getDouble("inlet"));
                    data.setOutletTemp(rs.getDouble("outlet"));
                    data.setRecoveryPct(rs.getDouble("rec_pct"));
                    data.setCogenUnits(rs.getDouble("cogen"));
                }
            }

            // 2. Process Sugar Data (Convert Bags to Quintals: 1 Bag = 50kg, so 2 Bags = 1 Quintal)
            try (PreparedStatement ps = conn.prepareStatement(sqlSugar)) {
                ps.setString(1, reportDate);
                ps.setString(2, reportDate);
                ps.setString(3, reportDate);
                ps.setString(4, reportDate);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    data.setSugarL30Today(rs.getDouble("l30_today") * 0.5);
                    data.setSugarL30Todate(rs.getDouble("l30_todate") * 0.5);
                    data.setSugarM30Today(rs.getDouble("m30_today") * 0.5);
                    data.setSugarM30Todate(rs.getDouble("m30_todate") * 0.5);
                    data.setSugarS130Today(rs.getDouble("s130_today") * 0.5);
                    data.setSugarS130Todate(rs.getDouble("s130_todate") * 0.5);
                    
                    data.setSugarTotalToday(data.getSugarL30Today() + data.getSugarM30Today() + data.getSugarS130Today());
                    data.setSugarTotalTodate(data.getSugarL30Todate() + data.getSugarM30Todate() + data.getSugarS130Todate());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}