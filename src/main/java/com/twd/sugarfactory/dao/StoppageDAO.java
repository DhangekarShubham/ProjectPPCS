package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.StoppageLog;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class StoppageDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "password");
    }

    public boolean saveStoppage(StoppageLog log) {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // 1. Generate a Unique Reason Code (e.g., "M102" for Mechanical)
            String reasonCode = log.getCategoryCode().substring(0, 1) + System.currentTimeMillis() % 10000;

            // 2. Insert into Master (for description lookup)
            String sqlMaster = "INSERT INTO stoppage_reason_master (reason_code, category_code, description_eng, description_mar) VALUES (?, ?, ?, ?)";
            try (PreparedStatement psMaster = conn.prepareStatement(sqlMaster)) {
                psMaster.setString(1, reasonCode);
                psMaster.setString(2, log.getCategoryCode());
                psMaster.setString(3, log.getReasonEng());
                psMaster.setString(4, log.getReasonMar());
                psMaster.executeUpdate();
            }

            // 3. Insert into Daily Log
            String sqlLog = "INSERT INTO daily_stoppage_log (stoppage_date, reason_code, total_hours) VALUES (?, ?, ?)";
            try (PreparedStatement psLog = conn.prepareStatement(sqlLog, Statement.RETURN_GENERATED_KEYS)) {
                psLog.setString(1, log.getStoppageDate());
                psLog.setString(2, reasonCode);
                psLog.setDouble(3, log.getTotalTime() != null ? log.getTotalTime() : 0.0);
                psLog.executeUpdate();
                
                // Get the auto-generated Stoppage Number
                ResultSet rs = psLog.getGeneratedKeys();
                if(rs.next()) {
                    log.setStoppageId(rs.getInt(1));
                }
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }

    public StoppageLog findStoppageById(Integer stoppageId) {
        String sql = "SELECT l.stoppage_id, l.stoppage_date, l.total_hours, m.category_code, m.description_eng, m.description_mar " +
                     "FROM daily_stoppage_log l " +
                     "JOIN stoppage_reason_master m ON l.reason_code = m.reason_code " +
                     "WHERE l.stoppage_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, stoppageId);
            ResultSet rs = ps.executeQuery();
            
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean deleteStoppage(Integer stoppageId) {
         String sql = "DELETE FROM daily_stoppage_log WHERE stoppage_id = ?";
         try (Connection conn = getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setInt(1, stoppageId);
             return ps.executeUpdate() > 0;
         } catch (Exception e) {
             e.printStackTrace();
             return false;
         }
    }
}