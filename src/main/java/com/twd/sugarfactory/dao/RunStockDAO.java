package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.RunStock;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class RunStockDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Using the same robust connection string as your Stoppage module
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "root");
    }

    /**
     * Fetches the Run Stock Data. 
     * Uses a LEFT JOIN to ensure all 11 required materials always show up on the UI.
     */
    public List<RunStock> getStockData(String seasonYear, String runNumber) {
        List<RunStock> list = new ArrayList<>();
        
        String sql = "SELECT m.material_id, m.material_name, " +
                     "s.volume_hl, s.brix_percent, s.pol_percent, s.purity_percent, " +
                     "s.run_number, s.season_year, s.start_date, s.end_date, s.stock_date, s.actual_date " +
                     "FROM material_master m " +
                     "LEFT JOIN run_stock_log s ON m.material_id = s.material_id " +
                     "AND s.season_year = ? AND s.run_number = ? " +
                     "WHERE m.material_name IN ('Clear Juice', 'Syrup', 'Unsulphited Syrup', 'A - Massecuite', 'B - Massecuite', 'C - Massecuite', 'Other - Massecuite', 'A - Light - Molasses', 'B - Light - Molasses', 'C - Light - Molasses', 'Other - Light - Molasses') " +
                     "ORDER BY m.material_id";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, seasonYear != null ? seasonYear : ""); 
            ps.setString(2, runNumber != null ? runNumber : ""); 
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RunStock stock = new RunStock();
                    stock.setMaterialId(rs.getInt("material_id"));
                    stock.setMaterialName(rs.getString("material_name"));
                    
                    // Global Headers
                    stock.setRunNumber(rs.getString("run_number"));
                    stock.setSeasonYear(rs.getString("season_year"));
                    stock.setStartDate(rs.getString("start_date"));
                    stock.setEndDate(rs.getString("end_date"));
                    stock.setStockDate(rs.getString("stock_date"));
                    stock.setActualDate(rs.getString("actual_date"));

                    // Grid Values
                    if (rs.getObject("volume_hl") != null) stock.setVolume(rs.getDouble("volume_hl"));
                    if (rs.getObject("brix_percent") != null) stock.setBrixPercent(rs.getDouble("brix_percent"));
                    if (rs.getObject("pol_percent") != null) stock.setPolPercent(rs.getDouble("pol_percent"));
                    if (rs.getObject("purity_percent") != null) stock.setPurityPercent(rs.getDouble("purity_percent"));
                    
                    list.add(stock);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Saves or Updates the Run Stock Data.
     */
    public boolean saveStockData(List<RunStock> stockList) {
        String sql = "INSERT INTO run_stock_log (season_year, run_number, material_id, start_date, end_date, stock_date, actual_date, volume_hl, brix_percent, pol_percent, purity_percent) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE " +
                     "start_date=VALUES(start_date), end_date=VALUES(end_date), stock_date=VALUES(stock_date), actual_date=VALUES(actual_date), " +
                     "volume_hl=VALUES(volume_hl), brix_percent=VALUES(brix_percent), pol_percent=VALUES(pol_percent), purity_percent=VALUES(purity_percent)";
                     
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (RunStock stock : stockList) {
                    // Only save rows where the user actually entered data (Volume, Brix, or Pol)
                    // Also ensure we have the critical identifiers
                    if (stock.getMaterialId() != null && stock.getRunNumber() != null && stock.getSeasonYear() != null && 
                       (stock.getVolume() != null || stock.getBrixPercent() != null || stock.getPolPercent() != null)) {
                        
                        ps.setString(1, stock.getSeasonYear());
                        ps.setString(2, stock.getRunNumber());
                        ps.setInt(3, stock.getMaterialId());
                        ps.setString(4, stock.getStartDate());
                        ps.setString(5, stock.getEndDate());
                        ps.setString(6, stock.getStockDate());
                        ps.setString(7, stock.getActualDate());
                        
                        // Handle nulls safely for double fields
                        if (stock.getVolume() != null) ps.setDouble(8, stock.getVolume()); else ps.setNull(8, Types.DOUBLE);
                        if (stock.getBrixPercent() != null) ps.setDouble(9, stock.getBrixPercent()); else ps.setNull(9, Types.DOUBLE);
                        if (stock.getPolPercent() != null) ps.setDouble(10, stock.getPolPercent()); else ps.setNull(10, Types.DOUBLE);
                        if (stock.getPurityPercent() != null) ps.setDouble(11, stock.getPurityPercent()); else ps.setNull(11, Types.DOUBLE);
                        
                        ps.addBatch();
                    }
                }
                
                ps.executeBatch();
                conn.commit();
                return true;
            }
        } catch (Exception e) {
            System.err.println("RUN STOCK SAVE ERROR: " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) {}
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) {}
            }
        }
    }
    
    /**
     * Deletes a specific Run Stock batch.
     */
    public boolean deleteStockData(String seasonYear, String runNumber) {
        String sql = "DELETE FROM run_stock_log WHERE season_year = ? AND run_number = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, seasonYear);
            ps.setString(2, runNumber);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("RUN STOCK DELETE ERROR: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}