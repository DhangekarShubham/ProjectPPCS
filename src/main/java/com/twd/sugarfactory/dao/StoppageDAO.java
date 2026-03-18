package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.StoppageLog;
import java.sql.*;

/**
 * Data Access Object for Stoppage Logs.
 * Handles transaction management across Master and Log tables.
 */
public class StoppageDAO {

    /**
     * Establishes connection with MySQL. 
     * Configured for Unicode (Marathi) and Baramati/IST timezone.
     */
    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sugar_plant_erp?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", 
            "root", 
            "root"
        );
    }

    /**
     * Saves a new stoppage log.
     * Uses a transaction to insert into both Reason Master and Daily Log.
     */
    public StoppageLog saveNewStoppage(StoppageLog log) {
        String sqlMaster = "INSERT INTO stoppage_reason_master (reason_code, category_code, description_eng, description_mar) VALUES (?, ?, ?, ?) " +
                           "ON DUPLICATE KEY UPDATE description_eng = VALUES(description_eng), description_mar = VALUES(description_mar)";
        
        String sqlLog = "INSERT INTO daily_stoppage_log (stoppage_date, reason_code, total_hours) VALUES (?, ?, ?)";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // 1. Generate a standardized Reason Code safely
            String cat = (log.getCategoryCode() != null && log.getCategoryCode().length() >= 4) 
                         ? log.getCategoryCode().substring(0, 4).toUpperCase() 
                         : "MISC";
            String reasonCode = cat + "_" + (System.currentTimeMillis() % 1000000);

            // 2. Insert/Update into Master Reason table
            try (PreparedStatement psMaster = conn.prepareStatement(sqlMaster)) {
                psMaster.setString(1, reasonCode);
                psMaster.setString(2, log.getCategoryCode());
                psMaster.setString(3, log.getReasonEng());
                psMaster.setString(4, log.getReasonMar());
                psMaster.executeUpdate();
            }

            // 3. Insert into Daily Transaction Log
            try (PreparedStatement psLog = conn.prepareStatement(sqlLog, Statement.RETURN_GENERATED_KEYS)) {
                psLog.setString(1, log.getStoppageDate());
                psLog.setString(2, reasonCode);
                psLog.setDouble(3, log.getTotalTime() != null ? log.getTotalTime() : 0.0);
                psLog.executeUpdate();
                
                try (ResultSet rs = psLog.getGeneratedKeys()) {
                    if (rs.next()) {
                        log.setStoppageId(rs.getInt(1));
                    }
                }
            }

            conn.commit();
            return log;
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            System.err.println("CRITICAL DB ERROR (Save): " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            closeConnection(conn);
        }
    }

    /**
     * Updates an existing stoppage. 
     * Uses a JOIN update to ensure the description in the Master table remains synced.
     */
    public boolean updateStoppage(StoppageLog log) {
        String sqlLog = "UPDATE daily_stoppage_log SET stoppage_date = ?, total_hours = ? WHERE stoppage_id = ?";
        
        String sqlMaster = "UPDATE stoppage_reason_master m " +
                           "INNER JOIN daily_stoppage_log l ON m.reason_code = l.reason_code " +
                           "SET m.category_code = ?, m.description_eng = ?, m.description_mar = ? " +
                           "WHERE l.stoppage_id = ?";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Update Log Table
            try (PreparedStatement psLog = conn.prepareStatement(sqlLog)) {
                psLog.setString(1, log.getStoppageDate());
                psLog.setDouble(2, log.getTotalTime());
                psLog.setInt(3, log.getStoppageId());
                psLog.executeUpdate();
            }

            // Update Master Table via Join
            try (PreparedStatement psMaster = conn.prepareStatement(sqlMaster)) {
                psMaster.setString(1, log.getCategoryCode());
                psMaster.setString(2, log.getReasonEng());
                psMaster.setString(3, log.getReasonMar());
                psMaster.setInt(4, log.getStoppageId());
                psMaster.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            System.err.println("CRITICAL DB ERROR (Update): " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeConnection(conn);
        }
    }

    /**
     * Retrieves a complete stoppage record by its unique database ID.
     */
    public StoppageLog getStoppageById(Integer stoppageId) {
        String sql = "SELECT l.stoppage_id, l.stoppage_date, l.total_hours, m.category_code, m.description_eng, m.description_mar " +
                     "FROM daily_stoppage_log l " +
                     "INNER JOIN stoppage_reason_master m ON l.reason_code = m.reason_code " +
                     "WHERE l.stoppage_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, stoppageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    StoppageLog log = new StoppageLog();
                    log.setStoppageId(rs.getInt("stoppage_id"));
                    log.setStoppageDate(rs.getString("stoppage_date"));
                    log.setTotalTime(rs.getDouble("total_hours"));
                    log.setCategoryCode(rs.getString("category_code"));
                    log.setReasonEng(rs.getString("description_eng"));
                    log.setReasonMar(rs.getString("description_mar"));
                    return log;
                }
            }
        } catch (Exception e) {
            System.err.println("CRITICAL DB ERROR (Fetch): " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Deletes a log entry. Note: Foreign Key should be set to ON DELETE CASCADE 
     * in the DB if you want to remove the master entry as well.
     */
    public boolean deleteStoppage(Integer stoppageId) {
         String sql = "DELETE FROM daily_stoppage_log WHERE stoppage_id = ?";
         try (Connection conn = getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setInt(1, stoppageId);
             return ps.executeUpdate() > 0;
         } catch (Exception e) {
             System.err.println("CRITICAL DB ERROR (Delete): " + e.getMessage());
             return false;
         }
    }

    private void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}