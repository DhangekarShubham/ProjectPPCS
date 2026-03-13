package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyMfgDetails;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReportMfgDetailsDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    public List<DailyMfgDetails> getReportData(String reportDate) {
        List<DailyMfgDetails> list = new ArrayList<>();
        
        // This query fetches all IN_PROCESS and BY_PRODUCT materials,
        // and joins them with the daily lab analysis data if it exists for the given date.
        String sql = "SELECT m.material_id, m.material_name, " +
                     "COALESCE(l.brix_pct, 0.00) as brix, " +
                     "COALESCE(l.pol_pct, 0.00) as pol, " +
                     "COALESCE(l.purity_pct, 0.00) as purity " +
                     "FROM material_master m " +
                     "LEFT JOIN daily_lab_analysis_details l ON m.material_id = l.material_id AND l.sample_date = ? " +
                     "WHERE m.category IN ('IN_PROCESS', 'BY_PRODUCT') " +
                     "ORDER BY m.material_id";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, reportDate);
            ResultSet rs = ps.executeQuery();
            
            int counter = 1;
            while (rs.next()) {
                DailyMfgDetails row = new DailyMfgDetails();
                row.setSrNo(counter++);
                row.setParticulars(rs.getString("material_name"));
                
                // Note: The COALESCE in SQL ensures we return 0.00 instead of null if no data was entered that day
                row.setBrix(rs.getDouble("brix"));
                row.setPol(rs.getDouble("pol"));
                row.setPurity(rs.getDouble("purity"));
                row.setRemark(""); // Left blank as per standard report format
                
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}