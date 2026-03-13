package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.MaterialStock;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MaterialStockDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    // Fetches master list of in-process goods. If date provided, joins with saved stock data.
    public List<MaterialStock> getStockList(String sampleDate) {
        List<MaterialStock> list = new ArrayList<>();
        String sql = "SELECT m.material_id, m.material_name, s.quantity_qtls, s.volume_hl " +
                     "FROM material_master m " +
                     "LEFT JOIN material_stock_log s ON m.material_id = s.material_id AND s.sample_date = ? " +
                     "WHERE m.category = 'IN_PROCESS' ORDER BY m.material_id";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, sampleDate != null ? sampleDate : "1900-01-01"); 
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                MaterialStock stock = new MaterialStock();
                stock.setMaterialId(rs.getInt("material_id"));
                stock.setMaterialName(rs.getString("material_name"));
                
                double qty = rs.getDouble("quantity_qtls");
                if (!rs.wasNull()) stock.setQuantity(qty);
                
                double vol = rs.getDouble("volume_hl");
                if (!rs.wasNull()) stock.setVolume(vol);
                
                if(sampleDate != null) stock.setSampleDate(sampleDate);
                
                list.add(stock);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean saveStockLog(List<MaterialStock> stockList) {
        String sql = "INSERT INTO material_stock_log (sample_date, material_id, quantity_qtls, volume_hl) " +
                     "VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity_qtls = VALUES(quantity_qtls), volume_hl = VALUES(volume_hl)";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (MaterialStock stock : stockList) {
                // Save only if user entered at least one value (Quantity or Volume)
                if ((stock.getQuantity() != null || stock.getVolume() != null) && stock.getSampleDate() != null) {
                    ps.setString(1, stock.getSampleDate());
                    ps.setInt(2, stock.getMaterialId());
                    
                    if (stock.getQuantity() != null) ps.setDouble(3, stock.getQuantity());
                    else ps.setNull(3, java.sql.Types.DOUBLE);
                    
                    if (stock.getVolume() != null) ps.setDouble(4, stock.getVolume());
                    else ps.setNull(4, java.sql.Types.DOUBLE);
                    
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
    
    public boolean deleteStockLog(String sampleDate) {
        String sql = "DELETE FROM material_stock_log WHERE sample_date = ?";
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