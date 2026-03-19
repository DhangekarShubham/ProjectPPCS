package com.twd.sugarfactory.dao;

import com.twd.sugarfactory.model.RT8CPerformance;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RT8CDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/sugar_plant_erp", "root", "root");
    }

    public RT8CPerformance getPerformanceData(String seasonYear) {
        RT8CPerformance p = null;
        String sql = "SELECT * FROM rt8c_technical_performance WHERE season_year = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, seasonYear);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                p = new RT8CPerformance();
                p.setSeasonYear(rs.getString("season_year"));
                p.setSeasonStartDate(rs.getString("season_start_date"));
                p.setCrushingEndDate(rs.getString("crushing_end_date"));
                p.setCrushingEndTime(rs.getString("crushing_end_time"));
                p.setProcessEndDate(rs.getString("process_end_date"));
                p.setProcessEndTime(rs.getString("process_end_time"));

                RT8CPerformance.RT8CData d = new RT8CPerformance.RT8CData();
                if(rs.getObject("own_estate_cane") != null) d.setOwnEstateCane(rs.getDouble("own_estate_cane"));
                if(rs.getObject("gate_cane") != null) d.setGateCane(rs.getDouble("gate_cane"));
                if(rs.getObject("out_station_cane") != null) d.setOutStationCane(rs.getDouble("out_station_cane"));
                if(rs.getObject("area_harvested") != null) d.setAreaHarvested(rs.getDouble("area_harvested"));
                if(rs.getObject("other_than_rail_cane") != null) d.setOtherThanRailCane(rs.getDouble("other_than_rail_cane"));
                if(rs.getObject("cane_members") != null) d.setCaneMembers(rs.getDouble("cane_members"));
                if(rs.getObject("cane_non_members") != null) d.setCaneNonMembers(rs.getDouble("cane_non_members"));
                if(rs.getObject("area_under_farm") != null) d.setAreaUnderFarm(rs.getDouble("area_under_farm"));
                if(rs.getObject("area_under_cane") != null) d.setAreaUnderCane(rs.getDouble("area_under_cane"));
                if(rs.getObject("rori_sugar_bags") != null) d.setRoriSugarBags(rs.getDouble("rori_sugar_bags"));
                if(rs.getObject("extra_fuel_std_bag_pct") != null) d.setExtraFuelStdBagPct(rs.getDouble("extra_fuel_std_bag_pct"));
                if(rs.getObject("process_steam_pct") != null) d.setProcessSteamPct(rs.getDouble("process_steam_pct"));
                if(rs.getObject("avg_yield_per_hectare") != null) d.setAvgYieldPerHectare(rs.getDouble("avg_yield_per_hectare"));
                if(rs.getObject("avg_yield_adsali") != null) d.setAvgYieldAdsali(rs.getDouble("avg_yield_adsali"));
                if(rs.getObject("avg_yield_plant") != null) d.setAvgYieldPlant(rs.getDouble("avg_yield_plant"));
                if(rs.getObject("avg_yield_ratoon") != null) d.setAvgYieldRatoon(rs.getDouble("avg_yield_ratoon"));
                if(rs.getObject("avg_prep_index") != null) d.setAvgPrepIndex(rs.getDouble("avg_prep_index"));
                if(rs.getObject("avg_temp_added_water") != null) d.setAvgTempAddedWater(rs.getDouble("avg_temp_added_water"));
                if(rs.getObject("bagasse_used_fuel") != null) d.setBagasseUsedFuel(rs.getDouble("bagasse_used_fuel"));
                if(rs.getObject("bagasse_used_sugar_plant") != null) d.setBagasseUsedSugarPlant(rs.getDouble("bagasse_used_sugar_plant"));
                if(rs.getObject("bagasse_used_by_products") != null) d.setBagasseUsedByProducts(rs.getDouble("bagasse_used_by_products"));
                if(rs.getObject("bagasse_used_cogen") != null) d.setBagasseUsedCogen(rs.getDouble("bagasse_used_cogen"));
                if(rs.getObject("bagasse_used_oliver") != null) d.setBagasseUsedOliver(rs.getDouble("bagasse_used_oliver"));
                if(rs.getObject("bagasse_sold") != null) d.setBagasseSold(rs.getDouble("bagasse_sold"));
                
                p.setData(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    public boolean savePerformanceData(RT8CPerformance p) {
        String sql = "INSERT INTO rt8c_technical_performance (season_year, season_start_date, crushing_end_date, crushing_end_time, process_end_date, process_end_time, " +
                     "own_estate_cane, gate_cane, out_station_cane, area_harvested, other_than_rail_cane, cane_members, cane_non_members, area_under_farm, area_under_cane, rori_sugar_bags, extra_fuel_std_bag_pct, process_steam_pct, " +
                     "avg_yield_per_hectare, avg_yield_adsali, avg_yield_plant, avg_yield_ratoon, avg_prep_index, avg_temp_added_water, " +
                     "bagasse_used_fuel, bagasse_used_sugar_plant, bagasse_used_by_products, bagasse_used_cogen, bagasse_used_oliver, bagasse_sold) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE " +
                     "season_start_date=VALUES(season_start_date), crushing_end_date=VALUES(crushing_end_date), crushing_end_time=VALUES(crushing_end_time), process_end_date=VALUES(process_end_date), process_end_time=VALUES(process_end_time), " +
                     "own_estate_cane=VALUES(own_estate_cane), gate_cane=VALUES(gate_cane), out_station_cane=VALUES(out_station_cane), area_harvested=VALUES(area_harvested), other_than_rail_cane=VALUES(other_than_rail_cane), cane_members=VALUES(cane_members), cane_non_members=VALUES(cane_non_members), area_under_farm=VALUES(area_under_farm), area_under_cane=VALUES(area_under_cane), rori_sugar_bags=VALUES(rori_sugar_bags), extra_fuel_std_bag_pct=VALUES(extra_fuel_std_bag_pct), process_steam_pct=VALUES(process_steam_pct), " +
                     "avg_yield_per_hectare=VALUES(avg_yield_per_hectare), avg_yield_adsali=VALUES(avg_yield_adsali), avg_yield_plant=VALUES(avg_yield_plant), avg_yield_ratoon=VALUES(avg_yield_ratoon), avg_prep_index=VALUES(avg_prep_index), avg_temp_added_water=VALUES(avg_temp_added_water), " +
                     "bagasse_used_fuel=VALUES(bagasse_used_fuel), bagasse_used_sugar_plant=VALUES(bagasse_used_sugar_plant), bagasse_used_by_products=VALUES(bagasse_used_by_products), bagasse_used_cogen=VALUES(bagasse_used_cogen), bagasse_used_oliver=VALUES(bagasse_used_oliver), bagasse_sold=VALUES(bagasse_sold)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, p.getSeasonYear());
            ps.setString(2, p.getSeasonStartDate());
            ps.setString(3, p.getCrushingEndDate());
            ps.setString(4, p.getCrushingEndTime());
            ps.setString(5, p.getProcessEndDate());
            ps.setString(6, p.getProcessEndTime());

            RT8CPerformance.RT8CData d = p.getData();
            if(d == null) d = new RT8CPerformance.RT8CData(); // Prevent null pointer if empty

            ps.setObject(7, d.getOwnEstateCane(), java.sql.Types.DOUBLE);
            ps.setObject(8, d.getGateCane(), java.sql.Types.DOUBLE);
            ps.setObject(9, d.getOutStationCane(), java.sql.Types.DOUBLE);
            ps.setObject(10, d.getAreaHarvested(), java.sql.Types.DOUBLE);
            ps.setObject(11, d.getOtherThanRailCane(), java.sql.Types.DOUBLE);
            ps.setObject(12, d.getCaneMembers(), java.sql.Types.DOUBLE);
            ps.setObject(13, d.getCaneNonMembers(), java.sql.Types.DOUBLE);
            ps.setObject(14, d.getAreaUnderFarm(), java.sql.Types.DOUBLE);
            ps.setObject(15, d.getAreaUnderCane(), java.sql.Types.DOUBLE);
            ps.setObject(16, d.getRoriSugarBags(), java.sql.Types.DOUBLE);
            ps.setObject(17, d.getExtraFuelStdBagPct(), java.sql.Types.DOUBLE);
            ps.setObject(18, d.getProcessSteamPct(), java.sql.Types.DOUBLE);
            
            ps.setObject(19, d.getAvgYieldPerHectare(), java.sql.Types.DOUBLE);
            ps.setObject(20, d.getAvgYieldAdsali(), java.sql.Types.DOUBLE);
            ps.setObject(21, d.getAvgYieldPlant(), java.sql.Types.DOUBLE);
            ps.setObject(22, d.getAvgYieldRatoon(), java.sql.Types.DOUBLE);
            ps.setObject(23, d.getAvgPrepIndex(), java.sql.Types.DOUBLE);
            ps.setObject(24, d.getAvgTempAddedWater(), java.sql.Types.DOUBLE);
            
            ps.setObject(25, d.getBagasseUsedFuel(), java.sql.Types.DOUBLE);
            ps.setObject(26, d.getBagasseUsedSugarPlant(), java.sql.Types.DOUBLE);
            ps.setObject(27, d.getBagasseUsedByProducts(), java.sql.Types.DOUBLE);
            ps.setObject(28, d.getBagasseUsedCogen(), java.sql.Types.DOUBLE);
            ps.setObject(29, d.getBagasseUsedOliver(), java.sql.Types.DOUBLE);
            ps.setObject(30, d.getBagasseSold(), java.sql.Types.DOUBLE);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deletePerformanceData(String seasonYear) {
        String sql = "DELETE FROM rt8c_technical_performance WHERE season_year = ?";
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