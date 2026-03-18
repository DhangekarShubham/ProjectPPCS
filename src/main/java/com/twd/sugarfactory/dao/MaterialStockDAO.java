package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.MaterialStock;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialStockDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    /**
     * Fetches master list.
     * FIXED: Changed s.sample_date to s.crush_date to match DB schema.
     */
    public List<MaterialStock> getStockList(String sampleDate) {
        List<MaterialStock> list = new ArrayList<>();
        String sql = "SELECT m.material_id, m.material_name, s.quantity_qtls, s.volume_hl " +
                     "FROM material_master m " +
                     "LEFT JOIN material_stock_log s ON m.material_id = s.material_id AND s.crush_date = ? " + // Fix here
                     "WHERE m.category IN ('IN_PROCESS', 'SUGAR_GRADE') ORDER BY m.material_id";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, (sampleDate != null && !sampleDate.isEmpty()) ? sampleDate : "1900-01-01"); 
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MaterialStock stock = new MaterialStock();
                    stock.setMaterialId(rs.getInt("material_id"));
                    stock.setMaterialName(rs.getString("material_name"));
                    stock.setSampleDate(sampleDate);
                    
                    double qty = rs.getDouble("quantity_qtls");
                    if (!rs.wasNull()) stock.setQuantity(qty);
                    
                    double vol = rs.getDouble("volume_hl");
                    if (!rs.wasNull()) stock.setVolume(vol);
                    
                    list.add(stock);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Saves/Updates stock log.
     * FIXED: Changed sample_date column to crush_date.
     */
    public boolean saveStockLog(List<MaterialStock> stockList) {
        String sql = "INSERT INTO material_stock_log (crush_date, material_id, quantity_qtls, volume_hl) " + // Fix here
                     "VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity_qtls = VALUES(quantity_qtls), volume_hl = VALUES(volume_hl)";
                     
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); 
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (MaterialStock stock : stockList) {
                    if ((stock.getQuantity() != null || stock.getVolume() != null) && stock.getSampleDate() != null) {
                        ps.setString(1, stock.getSampleDate());
                        ps.setInt(2, stock.getMaterialId());
                        
                        if (stock.getQuantity() != null) ps.setDouble(3, stock.getQuantity());
                        else ps.setNull(3, Types.DOUBLE);
                        
                        if (stock.getVolume() != null) ps.setDouble(4, stock.getVolume());
                        else ps.setNull(4, Types.DOUBLE);
                        
                        ps.addBatch();
                    }
                }
                ps.executeBatch();
                conn.commit(); 
                return true;
            }
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
    
    /**
     * FIXED: Changed WHERE sample_date to WHERE crush_date.
     */
    public boolean deleteStockLog(String sampleDate) {
        String sql = "DELETE FROM material_stock_log WHERE crush_date = ?"; // Fix here
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sampleDate);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}