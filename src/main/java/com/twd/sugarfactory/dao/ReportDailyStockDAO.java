package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.DailyStockReport;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReportDailyStockDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public List<DailyStockReport> getStockReport(String reportDate) {
        List<DailyStockReport> list = new ArrayList<>();
        
        // This is a complex query structure typical for ERPs.
        // We join material_master with production logs and simulated dispatch tables.
        // For demonstration based on your schema, we aggregate production. 
        // *Note: In a full system, opening balance is yesterday's closing balance.
        
        String sql = "SELECT m.material_id, m.material_name, m.unit_of_measure, m.category, " +

             // Production TODAY
             "(SELECT COALESCE(SUM(no_of_bags),0)/2 " +
             " FROM daily_sugar_production " +
             " WHERE material_id = m.material_id AND crush_date = ?) as prod_today, " +

             // Production BEFORE date (Opening)
             "(SELECT COALESCE(SUM(no_of_bags),0)/2 " +
             " FROM daily_sugar_production " +
             " WHERE material_id = m.material_id AND crush_date < ?) as prod_past " +
             //IN_PROCESS, CHEMICAL
             "FROM material_master m " +
             "WHERE m.category IN ('SUGAR_GRADE','BY_PRODUCT') " + 
             "ORDER BY m.category DESC, m.material_id ASC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
        	ps.setDate(1, java.sql.Date.valueOf(reportDate));
        	ps.setDate(2, java.sql.Date.valueOf(reportDate));
            ResultSet rs = ps.executeQuery();
            
            int sugarCount = 1;
            int byProdCount = 1;

            while (rs.next()) {
                DailyStockReport row = new DailyStockReport();
                row.setReportDate(reportDate);
                row.setSeasonYear("2025-2026");
                row.setProductName(rs.getString("material_name"));
                row.setUnit(rs.getString("unit_of_measure"));
                row.setCategory(rs.getString("category"));
                
                if ("SUGAR_GRADE".equals(row.getCategory())) {
                    row.setRowNumber("1." + sugarCount++);
                    // Assuming no_of_bags is 50kg, divided by 2 in SQL for Quintals
                    row.setProductionToday(rs.getDouble("prod_today"));
                    // In a real system, subtract past sales from past production to get exact Opening Balance
                    row.setOpeningBalance(rs.getDouble("prod_past")); 
                    
                    // Mock Sales Data (Would come from a Sales Module)
                    row.setDispatchSale(row.getProductionToday() * 0.2); // Just for demo
                    
                } else {
                    row.setRowNumber("2." + byProdCount++);
                    // For By-Products, production comes from calculation tables (like RT8C for Bagasse).
                    // Using mock data for the By-Product rows to match your UI format.
                    if(row.getProductName().contains("Molasses")) {
                        row.setOpeningBalance(8450.25); row.setProductionToday(145.30); row.setDispatchSale(200.0);
                    } else if (row.getProductName().contains("Bagasse")) {
                        row.setOpeningBalance(15200.0); row.setProductionToday(925.50); row.setDispatchSale(850.0);
                    } else {
                         row.setOpeningBalance(2100.0); row.setProductionToday(120.0); row.setDispatchSale(150.0);
                    }
                }
                
                // Calculate Closing Balance = Opening + Prod - Dispatch
                double closing = (row.getOpeningBalance() + row.getProductionToday()) - row.getDispatchSale();
                row.setClosingBalance(closing);
                
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}