package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.ChemicalConsumption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ChemicalConsumptionDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    /**
     * Fetches the master list of chemicals to populate the UI grid.
     * If data exists for the given date, it populates the volumes.
     */
    public List<ChemicalConsumption> getChemicalList(String sampleDate) {
        List<ChemicalConsumption> list = new ArrayList<>();
        // Query joins material_master with the daily log (if it exists)
        String sql = "SELECT m.material_id, m.material_name, c.volume_consumed " +
                     "FROM material_master m " +
                     "LEFT JOIN chemical_consumption_log c ON m.material_id = c.material_id AND c.sample_date = ? " +
                     "WHERE m.category = 'CHEMICAL' ORDER BY m.material_id";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, sampleDate != null ? sampleDate : "1900-01-01"); // Dummy date if new
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ChemicalConsumption chem = new ChemicalConsumption();
                chem.setMaterialId(rs.getInt("material_id"));
                chem.setMaterialName(rs.getString("material_name"));
                
                double volume = rs.getDouble("volume_consumed");
                if (!rs.wasNull()) {
                    chem.setVolumeConsumed(volume);
                    chem.setSampleDate(sampleDate);
                }
                list.add(chem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Saves or Updates the consumption log using JDBC Batch Processing.
     */
    public boolean saveConsumptionLog(List<ChemicalConsumption> chemicalList) {
        String sql = "INSERT INTO chemical_consumption_log (sample_date, material_id, volume_consumed) " +
                     "VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE volume_consumed = VALUES(volume_consumed)";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (ChemicalConsumption chem : chemicalList) {
                // Only save if a volume was actually entered
                if (chem.getVolumeConsumed() != null && chem.getSampleDate() != null) {
                    ps.setString(1, chem.getSampleDate());
                    ps.setInt(2, chem.getMaterialId());
                    ps.setDouble(3, chem.getVolumeConsumed());
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
    
    /**
     * Deletes the consumption log for a specific date.
     */
    public boolean deleteConsumptionLog(String sampleDate) {
        String sql = "DELETE FROM chemical_consumption_log WHERE sample_date = ?";
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