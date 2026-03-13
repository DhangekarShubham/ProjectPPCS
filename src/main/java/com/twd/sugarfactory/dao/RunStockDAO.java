package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.RunStock;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RunStockDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    public List<RunStock> getRunStockList(String sampleDate) {
        List<RunStock> list = new ArrayList<>();
        // Fetch materials typically found in the boiling house (Syrups, Massecuites, Molasses)
        String sql = "SELECT m.material_id, m.material_name, " +
                     "s.volume_hl, s.specific_gravity, s.brix_percent, s.pol_percent, s.purity_percent " +
                     "FROM material_master m " +
                     "LEFT JOIN material_stock_log s ON m.material_id = s.material_id AND s.sample_date = ? AND s.report_type = 'RUN' " +
                     "WHERE m.category = 'IN_PROCESS' ORDER BY m.material_id";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, sampleDate != null ? sampleDate : "1900-01-01"); 
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                RunStock stock = new RunStock();
                stock.setMaterialId(rs.getInt("material_id"));
                stock.setMaterialName(rs.getString("material_name"));
                
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

    public boolean saveRunStockLog(List<RunStock> stockList) {
        String sql = "INSERT INTO material_stock_log (sample_date, report_type, material_id, volume_hl, specific_gravity, brix_percent, pol_percent, purity_percent) " +
                     "VALUES (?, 'RUN', ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE volume_hl=VALUES(volume_hl), specific_gravity=VALUES(specific_gravity), brix_percent=VALUES(brix_percent), pol_percent=VALUES(pol_percent), purity_percent=VALUES(purity_percent)";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (RunStock stock : stockList) {
                // Ensure we only save if the row contains valid analysis or volume data
                if ((stock.getVolume() != null || stock.getBrixPercent() != null) && stock.getSampleDate() != null) {
                    
                    ps.setString(1, stock.getSampleDate());
                    ps.setInt(2, stock.getMaterialId());
                    
                    ps.setObject(3, stock.getVolume(), java.sql.Types.DOUBLE);
                    ps.setObject(4, stock.getSpGravity(), java.sql.Types.DOUBLE);
                    ps.setObject(5, stock.getBrixPercent(), java.sql.Types.DOUBLE);
                    ps.setObject(6, stock.getPolPercent(), java.sql.Types.DOUBLE);
                    ps.setObject(7, stock.getPurityPercent(), java.sql.Types.DOUBLE);
                    
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
    
    public boolean deleteRunStockLog(String sampleDate) {
        String sql = "DELETE FROM material_stock_log WHERE sample_date = ? AND report_type = 'RUN'";
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