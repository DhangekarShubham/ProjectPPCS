package com.twd.sugarfactory.dao;

import java.sql.*;
import com.twd.sugarfactory.model.FactoryInfo;

public class FactoryInfoDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    // Helper to clean ISO Date strings (e.g., "2015-10-31T18:30:00.000Z" -> "2015-10-31")
    private String formatDbDate(String dateStr) {
        if (dateStr != null && dateStr.contains("T")) { 
            return dateStr.split("T")[0];
        }
        return dateStr;
    }

    public boolean save(FactoryInfo info) {
        String sql = "INSERT INTO factory_master (season_year, start_date, start_time, factory_name, address, taluka, district, state, pin_code, phone_no, std_code, email, website, clarification_process, registration_no, gst_no, fssai_no, commission_rate, division, `range`, installed_capacity, managing_director, works_manager, chief_chemist, lab_incharge) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Set Season Year at index 1
            ps.setString(1, info.getSeasonYear());
            // Map the rest starting from index 2
            mapFields(ps, info, 2);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(FactoryInfo info) {
        String sql = "UPDATE factory_master SET start_date=?, start_time=?, factory_name=?, address=?, taluka=?, district=?, state=?, pin_code=?, phone_no=?, std_code=?, email=?, website=?, clarification_process=?, registration_no=?, gst_no=?, fssai_no=?, commission_rate=?, division=?, `range`=?, installed_capacity=?, managing_director=?, works_manager=?, chief_chemist=?, lab_incharge=? WHERE season_year=?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Map fields starting from index 1
            mapFields(ps, info, 1);
            // Set WHERE clause season_year at the last index (25)
            ps.setString(25, info.getSeasonYear());
            
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
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    info = new FactoryInfo();
                    info.setSeasonYear(rs.getString("season_year"));
                    info.setStartDate(rs.getString("start_date"));
                    info.setStartTime(rs.getString("start_time"));
                    info.setFactoryName(rs.getString("factory_name"));
                    info.setAddress(rs.getString("address"));
                    info.setTaluka(rs.getString("taluka"));
                    info.setDistrict(rs.getString("district"));
                    info.setState(rs.getString("state"));
                    info.setPinCode(rs.getString("pin_code"));
                    info.setPhoneNo(rs.getString("phone_no"));
                    info.setStdCode(rs.getString("std_code"));
                    info.setEmail(rs.getString("email"));
                    info.setWebsite(rs.getString("website"));
                    info.setClarificationProcess(rs.getString("clarification_process"));
                    info.setRegistrationNo(rs.getString("registration_no"));
                    info.setGstNo(rs.getString("gst_no"));
                    info.setFssaiNo(rs.getString("fssai_no"));
                    info.setCommissionRate(rs.getDouble("commission_rate"));
                    info.setDivision(rs.getString("division"));
                    info.setRange(rs.getString("range"));
                    info.setInstalledCapacity(rs.getDouble("installed_capacity"));
                    info.setManagingDirector(rs.getString("managing_director"));
                    info.setWorksManager(rs.getString("works_manager"));
                    info.setChiefChemist(rs.getString("chief_chemist"));
                    info.setLabIncharge(rs.getString("lab_incharge"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return info;
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

    /**
     * Helper to map common fields for both INSERT and UPDATE.
     * @param startIdx The starting parameter index for the PreparedStatement.
     */
    private void mapFields(PreparedStatement ps, FactoryInfo info, int startIdx) throws SQLException {
        int i = startIdx;
        ps.setString(i++, formatDbDate(info.getStartDate())); // Fixes Truncation Error
        ps.setString(i++, info.getStartTime());
        ps.setString(i++, info.getFactoryName());
        ps.setString(i++, info.getAddress());
        ps.setString(i++, info.getTaluka());
        ps.setString(i++, info.getDistrict());
        ps.setString(i++, info.getState());
        ps.setString(i++, info.getPinCode());
        ps.setString(i++, info.getPhoneNo());
        ps.setString(i++, info.getStdCode());
        ps.setString(i++, info.getEmail());
        ps.setString(i++, info.getWebsite());
        ps.setString(i++, info.getClarificationProcess());
        ps.setString(i++, info.getRegistrationNo());
        ps.setString(i++, info.getGstNo());
        ps.setString(i++, info.getFssaiNo());
        ps.setObject(i++, info.getCommissionRate());
        ps.setString(i++, info.getDivision());
        ps.setString(i++, info.getRange());
        ps.setObject(i++, info.getInstalledCapacity());
        ps.setString(i++, info.getManagingDirector());
        ps.setString(i++, info.getWorksManager());
        ps.setString(i++, info.getChiefChemist());
        ps.setString(i++, info.getLabIncharge());
    }
}
