package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.RT7CStock;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RT7CStockDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public List<RT7CStock> getRT7CStockList(String stockDate) {
        List<RT7CStock> list = new ArrayList<>();
        
        // Added the new header fields to the SELECT query
     // Add s.sample_date to the second line of the query
        String sql = "SELECT m.material_id, m.material_name, m.category, " +
                     "s.sample_date, s.quantity_qtls, s.volume_hl, s.specific_gravity, s.brix_percent, s.pol_percent, s.purity_percent, " +
                     "s.rt7c_number, s.season_year, s.start_date, s.end_date, s.actual_date " +
                     "FROM material_master m " +
                     "LEFT JOIN material_stock_log s ON m.material_id = s.material_id AND s.sample_date = ? AND s.report_type = 'RT7C' " +
                     "WHERE m.category IN ('IN_PROCESS', 'SUGAR_GRADE', 'BY_PRODUCT', 'OLD_STOCK') ORDER BY m.material_id";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, stockDate != null ? stockDate : "1900-01-01"); 
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                RT7CStock stock = new RT7CStock();
                stock.setMaterialId(rs.getInt("material_id"));
                stock.setMaterialName(rs.getString("material_name"));
                
                String cat = rs.getString("category");
                if ("IN_PROCESS".equals(cat)) stock.setTabCategory("PROCESS");
                else if ("OLD_STOCK".equals(cat)) stock.setTabCategory("OLD");
                else stock.setTabCategory("SUGAR");

                // Header Data
                stock.setRt7cNumber(rs.getString("rt7c_number"));
                stock.setSeasonYear(rs.getString("season_year"));
                stock.setStartDate(rs.getString("start_date"));
                stock.setEndDate(rs.getString("end_date"));
                stock.setStockDate(rs.getString("sample_date"));
                
                stock.setActualDate(rs.getString("actual_date"));

                // Detail Data
                if (rs.getObject("quantity_qtls") != null) stock.setQuantity(rs.getDouble("quantity_qtls"));
                if (rs.getObject("volume_hl") != null) stock.setVolume(rs.getDouble("volume_hl"));
                if (rs.getObject("specific_gravity") != null) stock.setSpGravity(rs.getDouble("specific_gravity"));
                if (rs.getObject("brix_percent") != null) stock.setBrixPercent(rs.getDouble("brix_percent"));
                if (rs.getObject("pol_percent") != null) stock.setPolPercent(rs.getDouble("pol_percent"));
                if (rs.getObject("purity_percent") != null) stock.setPurityPercent(rs.getDouble("purity_percent"));
                
                list.add(stock);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean saveRT7CStockLog(List<RT7CStock> stockList) {
        // Added the header fields to the INSERT and ON DUPLICATE KEY UPDATE logic
        String sql = "INSERT INTO material_stock_log (sample_date, report_type, material_id, quantity_qtls, volume_hl, specific_gravity, brix_percent, pol_percent, purity_percent, rt7c_number, season_year, start_date, end_date, actual_date) " +
                     "VALUES (?, 'RT7C', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity_qtls=VALUES(quantity_qtls), volume_hl=VALUES(volume_hl), specific_gravity=VALUES(specific_gravity), brix_percent=VALUES(brix_percent), pol_percent=VALUES(pol_percent), purity_percent=VALUES(purity_percent), rt7c_number=VALUES(rt7c_number), season_year=VALUES(season_year), start_date=VALUES(start_date), end_date=VALUES(end_date), actual_date=VALUES(actual_date)";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (RT7CStock stock : stockList) {
                // Save if there is ANY data, AND if we successfully grabbed the material ID from the master list
                if (stock.getMaterialId() != null && (stock.getQuantity() != null || stock.getVolume() != null || stock.getBrixPercent() != null) && stock.getStockDate() != null) {
                    
                    ps.setString(1, stock.getStockDate());
                    ps.setInt(2, stock.getMaterialId());
                    
                    ps.setObject(3, stock.getQuantity(), java.sql.Types.DOUBLE);
                    ps.setObject(4, stock.getVolume(), java.sql.Types.DOUBLE);
                    ps.setObject(5, stock.getSpGravity(), java.sql.Types.DOUBLE);
                    ps.setObject(6, stock.getBrixPercent(), java.sql.Types.DOUBLE);
                    ps.setObject(7, stock.getPolPercent(), java.sql.Types.DOUBLE);
                    ps.setObject(8, stock.getPurityPercent(), java.sql.Types.DOUBLE);
                    
                    ps.setString(9, stock.getRt7cNumber());
                    ps.setString(10, stock.getSeasonYear());
                    ps.setString(11, stock.getStartDate());
                    ps.setString(12, stock.getEndDate());
                    ps.setString(13, stock.getActualDate());
                    
                    ps.addBatch();
                }
            }
            
            ps.executeBatch();
            conn.commit();
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteRT7CStockLog(String stockDate) {
        String sql = "DELETE FROM material_stock_log WHERE sample_date = ? AND report_type = 'RT7C'";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stockDate);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}