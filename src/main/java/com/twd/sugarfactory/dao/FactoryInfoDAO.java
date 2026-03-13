package com.twd.sugarfactory.dao;

import java.sql.*;

import com.twd.sugarfactory.model.FactoryInfo;

public class FactoryInfoDAO {

    // Helper method for DB connection (Update with your DB credentials)
    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_factory_db", "root", "password");
    }

    public boolean save(FactoryInfo info) {
        String sql = "INSERT INTO factory_master (season_year, start_date, factory_name, gst_no, installed_capacity, managing_director) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, info.getSeasonYear());
            ps.setString(2, info.getStartDate());
            ps.setString(3, info.getFactoryName());
            ps.setString(4, info.getGstNo());
            if (info.getInstalledCapacity() != null) {
                ps.setDouble(5, info.getInstalledCapacity());
            } else {
                ps.setNull(5, java.sql.Types.DOUBLE);
            }
            ps.setString(6, info.getManagingDirector());
            // NOTE: Add the rest of the 25 fields here corresponding to your database columns
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public FactoryInfo findBySeasonYear(String seasonYear) {
        String sql = "SELECT * FROM factory_master WHERE season_year = ?";
        FactoryInfo info = null;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, seasonYear);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                info = new FactoryInfo();
                info.setSeasonYear(rs.getString("season_year"));
                info.setStartDate(rs.getString("start_date"));
                info.setFactoryName(rs.getString("factory_name"));
                info.setGstNo(rs.getString("gst_no"));
                info.setInstalledCapacity(rs.getDouble("installed_capacity"));
                info.setManagingDirector(rs.getString("managing_director"));
                 // NOTE: Map the rest of the ResultSet to the object here
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return info;
    }

    public boolean update(FactoryInfo info) {
        String sql = "UPDATE factory_master SET start_date=?, factory_name=?, gst_no=? WHERE season_year=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, info.getStartDate());
            ps.setString(2, info.getFactoryName());
            ps.setString(3, info.getGstNo());
            ps.setString(4, info.getSeasonYear());
             // NOTE: Add the rest of the fields
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(String seasonYear) {
        String sql = "DELETE FROM factory_master WHERE season_year=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, seasonYear);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}