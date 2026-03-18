package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.ChemicalConsumption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChemicalConsumptionDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    /**
     * Fetches the chemical master list.
     * If volumes exist for 'sampleDate', they are populated; otherwise, they are null/0.
     */
    public List<ChemicalConsumption> getChemicalList(String sampleDate) {
        List<ChemicalConsumption> list = new ArrayList<>();
        // LEFT JOIN ensures we see all chemicals even if no consumption is recorded yet
        String sql = "SELECT m.material_id, m.material_name, c.volume_consumed " +
                     "FROM material_master m " +
                     "LEFT JOIN chemical_consumption_log c ON m.material_id = c.material_id AND c.sample_date = ? " +
                     "WHERE m.category = 'CHEMICAL' ORDER BY m.material_name ASC";
                     
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // If sampleDate is null (initial load), use an impossible date to return empty volumes
            ps.setString(1, (sampleDate != null && !sampleDate.isEmpty()) ? sampleDate : "1900-01-01");
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChemicalConsumption chem = new ChemicalConsumption();
                    chem.setMaterialId(rs.getInt("material_id"));
                    chem.setMaterialName(rs.getString("material_name"));
                    chem.setSampleDate(sampleDate);
                    
                    double volume = rs.getDouble("volume_consumed");
                    if (!rs.wasNull()) {
                        chem.setVolumeConsumed(volume);
                    } else {
                        chem.setVolumeConsumed(null); // Keep as null for the UI placeholder
                    }
                    list.add(chem);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Saves/Updates consumption using Batch Processing.
     * Uses Transaction Rollback to ensure data integrity.
     */
    public boolean saveConsumptionLog(List<ChemicalConsumption> chemicalList) {
        String sql = "INSERT INTO chemical_consumption_log (sample_date, material_id, volume_consumed) " +
                     "VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE volume_consumed = VALUES(volume_consumed)";
                     
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Start Transaction
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (ChemicalConsumption chem : chemicalList) {
                    // Only process rows with a valid volume
                    if (chem.getVolumeConsumed() != null && chem.getSampleDate() != null) {
                        ps.setString(1, chem.getSampleDate());
                        ps.setInt(2, chem.getMaterialId());
                        ps.setDouble(3, chem.getVolumeConsumed());
                        ps.addBatch();
                    }
                }
                ps.executeBatch();
                conn.commit(); // Commit all rows at once
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
     * Deletes chemical log for a date.
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