package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyMfgShort;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportMfgShortDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    public DailyMfgShort getReportData(String reportDate) {
        DailyMfgShort data = new DailyMfgShort();
        data.setReportDate(reportDate);
        
        // 1. Fetch Cane Crushing Data
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

        // 2. Fetch Sugar Production Data (Assuming no_of_bags = 1 quintal for simplicity, adjust if 50kg bags)
        String sqlSugar = "SELECT " +
                          "SUM(CASE WHEN s.sample_date = ? AND m.material_name LIKE '%L-30%' THEN s.no_of_bags ELSE 0 END) as l30_today, " +
                          "SUM(CASE WHEN m.material_name LIKE '%L-30%' THEN s.no_of_bags ELSE 0 END) as l30_todate, " +
                          "SUM(CASE WHEN s.sample_date = ? AND m.material_name LIKE '%M-30%' THEN s.no_of_bags ELSE 0 END) as m30_today, " +
                          "SUM(CASE WHEN m.material_name LIKE '%M-30%' THEN s.no_of_bags ELSE 0 END) as m30_todate, " +
                          "SUM(CASE WHEN s.sample_date = ? AND m.material_name LIKE '%S1-30%' THEN s.no_of_bags ELSE 0 END) as s130_today, " +
                          "SUM(CASE WHEN m.material_name LIKE '%S1-30%' THEN s.no_of_bags ELSE 0 END) as s130_todate, " +
                          "SUM(CASE WHEN s.sample_date = ? AND m.material_name LIKE '%Brown%' THEN s.no_of_bags ELSE 0 END) as brown_today, " +
                          "SUM(CASE WHEN m.material_name LIKE '%Brown%' THEN s.no_of_bags ELSE 0 END) as brown_todate " +
                          "FROM daily_sugar_production s " +
                          "JOIN material_master m ON s.material_id = m.material_id " +
                          "WHERE s.sample_date <= ?";

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

            // Execute Sugar Query
            try (PreparedStatement psSugar = conn.prepareStatement(sqlSugar)) {
                psSugar.setString(1, reportDate);
                psSugar.setString(2, reportDate);
                psSugar.setString(3, reportDate);
                psSugar.setString(4, reportDate);
                psSugar.setString(5, reportDate);
                ResultSet rs = psSugar.executeQuery();
                
                if (rs.next()) {
                    // Assuming bag weight is 50kg, we divide by 2 to get Quintals (1 Quintal = 100kg)
                    data.setSugarL30Today(rs.getDouble("l30_today") / 2);
                    data.setSugarL30Todate(rs.getDouble("l30_todate") / 2);
                    data.setSugarM30Today(rs.getDouble("m30_today") / 2);
                    data.setSugarM30Todate(rs.getDouble("m30_todate") / 2);
                    data.setSugarS130Today(rs.getDouble("s130_today") / 2);
                    data.setSugarS130Todate(rs.getDouble("s130_todate") / 2);
                    data.setSugarBrownToday(rs.getDouble("brown_today") / 2);
                    data.setSugarBrownTodate(rs.getDouble("brown_todate") / 2);
                    
                    data.setSugarS230Today(0.00); // Hardcoded as per sample
                    data.setSugarS230Todate(0.00);
                    
                    double totalToday = data.getSugarL30Today() + data.getSugarM30Today() + data.getSugarS130Today() + data.getSugarBrownToday();
                    double totalTodate = data.getSugarL30Todate() + data.getSugarM30Todate() + data.getSugarS130Todate() + data.getSugarBrownTodate();
                    
                    data.setSugarTotalToday(totalToday);
                    data.setSugarTotalTodate(totalTodate);
                    
                    // Calculate Percentages
                    if(totalToday > 0) {
                        data.setPctL30Today((data.getSugarL30Today() / totalToday) * 100);
                        data.setPctM30Today((data.getSugarM30Today() / totalToday) * 100);
                        data.setPctS130Today((data.getSugarS130Today() / totalToday) * 100);
                    } else {
                        data.setPctL30Today(0.0); data.setPctM30Today(0.0); data.setPctS130Today(0.0);
                    }
                    
                    if(totalTodate > 0) {
                        data.setPctL30Todate((data.getSugarL30Todate() / totalTodate) * 100);
                        data.setPctM30Todate((data.getSugarM30Todate() / totalTodate) * 100);
                        data.setPctS130Todate((data.getSugarS130Todate() / totalTodate) * 100);
                    } else {
                        data.setPctL30Todate(0.0); data.setPctM30Todate(0.0); data.setPctS130Todate(0.0);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}