package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.MfgReportDTO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportMfgDetailsDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "root");
    }

    public MfgReportDTO getReportData(String reportDate) {
        MfgReportDTO dto = new MfgReportDTO();
        
        List<MfgReportDTO.MainItem> mainList = new ArrayList<>();
        List<MfgReportDTO.ByproductItem> byproductList = new ArrayList<>();
        Map<String, Object> params = new HashMap<>();
        Map<String, String> metaInfo = new HashMap<>();

        // 1. Fetch Materials and Lab Analysis Data
        String sqlLab = "SELECT m.material_name, m.category, " +
                        "COALESCE(l.brix_pct, 0.00) as brix, " +
                        "COALESCE(l.pol_pct, 0.00) as pol, " +
                        "COALESCE(l.purity_pct, 0.00) as purity, " +
                        "COALESCE(l.moisture_pct, 0.00) as moisture " +
                        "FROM material_master m " +
                        "LEFT JOIN daily_lab_analysis_details l ON m.material_id = l.material_id AND l.crush_date = ? " +
                        "WHERE m.category IN ('IN_PROCESS', 'BY_PRODUCT', 'SUGAR_GRADE') " +
                        "ORDER BY m.material_id";

        // 2. Fetch Plant Parameters (Tanks, Temps)
        String sqlParams = "SELECT season_year, mixed_juice_tanks, added_water_tanks, filter_cake_weight_mt, " +
                           "final_molasses_tanks, condenser_inlet_temp, condenser_outlet_temp, dirt_correction_pct " +
                           "FROM daily_crushing_log WHERE crush_date = ?";

        try (Connection conn = getConnection()) {
            
            // Execute Lab Data Query
            try (PreparedStatement psLab = conn.prepareStatement(sqlLab)) {
                psLab.setString(1, reportDate);
                try (ResultSet rs = psLab.executeQuery()) {
                    while (rs.next()) {
                        String name = rs.getString("material_name");
                        Double brix = rs.getDouble("brix");
                        Double pol = rs.getDouble("pol");
                        Double purity = rs.getDouble("purity");
                        Double moisture = rs.getDouble("moisture");

                        // Separate By-Products from Main Process Materials (Matches PDF)
                        if (name.equalsIgnoreCase("Bagasse") || name.equalsIgnoreCase("Filter Cake") || 
                            name.equalsIgnoreCase("Press Mud") || name.contains("Sugar")) {
                            byproductList.add(new MfgReportDTO.ByproductItem(name, moisture, pol));
                        } else {
                            mainList.add(new MfgReportDTO.MainItem(name, brix, pol, purity, ""));
                        }
                    }
                }
            }

            // Execute Plant Parameters Query
            try (PreparedStatement psParams = conn.prepareStatement(sqlParams)) {
                psParams.setString(1, reportDate);
                try (ResultSet rs = psParams.executeQuery()) {
                    if (rs.next()) {
                        metaInfo.put("seasonYear", rs.getString("season_year"));
                        
                        params.put("juiceTanks", rs.getInt("mixed_juice_tanks"));
                        params.put("addedWaterTanks", rs.getInt("added_water_tanks"));
                        params.put("filterCakeMt", rs.getDouble("filter_cake_weight_mt"));
                        params.put("fmTanks", rs.getInt("final_molasses_tanks"));
                        params.put("inletTemp", rs.getDouble("condenser_inlet_temp"));
                        params.put("outletTemp", rs.getDouble("condenser_outlet_temp"));
                        params.put("dirtCorrection", rs.getDouble("dirt_correction_pct"));
                    } else {
                        // Defaults if no crushing log exists for that day
                        metaInfo.put("seasonYear", "N/A");
                        params.put("juiceTanks", 0); params.put("addedWaterTanks", 0); params.put("filterCakeMt", 0.0);
                        params.put("fmTanks", 0); params.put("inletTemp", 0.0); params.put("outletTemp", 0.0); params.put("dirtCorrection", 0.0);
                    }
                }
            }

            // Bind everything to the Data Transfer Object
            dto.setMetaInfo(metaInfo);
            dto.setMainList(mainList);
            dto.setByproductList(byproductList);
            dto.setParameters(params);

        } catch (Exception e) {
            System.err.println("MFG REPORT DAO ERROR: " + e.getMessage());
            e.printStackTrace();
        }

        return dto;
    }
}