package com.twd.sugarfactory.model;

public class RT8CPerformance {
    // Header Fields
    private String seasonYear;
    private String seasonStartDate;
    private String crushingEndDate;
    private String crushingEndTime;
    private String processEndDate;
    private String processEndTime;
    
    // Nested Data Object
    private RT8CData data;

    public RT8CPerformance() {
        this.data = new RT8CData();
    }

    // Getters and Setters
    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public String getSeasonStartDate() { return seasonStartDate; }
    public void setSeasonStartDate(String seasonStartDate) { this.seasonStartDate = seasonStartDate; }

    public String getCrushingEndDate() { return crushingEndDate; }
    public void setCrushingEndDate(String crushingEndDate) { this.crushingEndDate = crushingEndDate; }

    public String getCrushingEndTime() { return crushingEndTime; }
    public void setCrushingEndTime(String crushingEndTime) { this.crushingEndTime = crushingEndTime; }

    public String getProcessEndDate() { return processEndDate; }
    public void setProcessEndDate(String processEndDate) { this.processEndDate = processEndDate; }

    public String getProcessEndTime() { return processEndTime; }
    public void setProcessEndTime(String processEndTime) { this.processEndTime = processEndTime; }

    public RT8CData getData() { return data; }
    public void setData(RT8CData data) { this.data = data; }

    // Inner class representing the 24 fields in the UI
    public static class RT8CData {
        private Double ownEstateCane, gateCane, outStationCane, areaHarvested, otherThanRailCane;
        private Double caneMembers, caneNonMembers, areaUnderFarm, areaUnderCane;
        private Double roriSugarBags, extraFuelStdBagPct, processSteamPct;
        private Double avgYieldPerHectare, avgYieldAdsali, avgYieldPlant, avgYieldRatoon, avgPrepIndex, avgTempAddedWater;
        private Double bagasseUsedFuel, bagasseUsedSugarPlant, bagasseUsedByProducts, bagasseUsedCogen, bagasseUsedOliver, bagasseSold;

        // Getters and setters for all Double fields...
        public Double getOwnEstateCane() { return ownEstateCane; } public void setOwnEstateCane(Double ownEstateCane) { this.ownEstateCane = ownEstateCane; }
        public Double getGateCane() { return gateCane; } public void setGateCane(Double gateCane) { this.gateCane = gateCane; }
        public Double getOutStationCane() { return outStationCane; } public void setOutStationCane(Double outStationCane) { this.outStationCane = outStationCane; }
        public Double getAreaHarvested() { return areaHarvested; } public void setAreaHarvested(Double areaHarvested) { this.areaHarvested = areaHarvested; }
        public Double getOtherThanRailCane() { return otherThanRailCane; } public void setOtherThanRailCane(Double otherThanRailCane) { this.otherThanRailCane = otherThanRailCane; }
        public Double getCaneMembers() { return caneMembers; } public void setCaneMembers(Double caneMembers) { this.caneMembers = caneMembers; }
        public Double getCaneNonMembers() { return caneNonMembers; } public void setCaneNonMembers(Double caneNonMembers) { this.caneNonMembers = caneNonMembers; }
        public Double getAreaUnderFarm() { return areaUnderFarm; } public void setAreaUnderFarm(Double areaUnderFarm) { this.areaUnderFarm = areaUnderFarm; }
        public Double getAreaUnderCane() { return areaUnderCane; } public void setAreaUnderCane(Double areaUnderCane) { this.areaUnderCane = areaUnderCane; }
        public Double getRoriSugarBags() { return roriSugarBags; } public void setRoriSugarBags(Double roriSugarBags) { this.roriSugarBags = roriSugarBags; }
        public Double getExtraFuelStdBagPct() { return extraFuelStdBagPct; } public void setExtraFuelStdBagPct(Double extraFuelStdBagPct) { this.extraFuelStdBagPct = extraFuelStdBagPct; }
        public Double getProcessSteamPct() { return processSteamPct; } public void setProcessSteamPct(Double processSteamPct) { this.processSteamPct = processSteamPct; }
        public Double getAvgYieldPerHectare() { return avgYieldPerHectare; } public void setAvgYieldPerHectare(Double avgYieldPerHectare) { this.avgYieldPerHectare = avgYieldPerHectare; }
        public Double getAvgYieldAdsali() { return avgYieldAdsali; } public void setAvgYieldAdsali(Double avgYieldAdsali) { this.avgYieldAdsali = avgYieldAdsali; }
        public Double getAvgYieldPlant() { return avgYieldPlant; } public void setAvgYieldPlant(Double avgYieldPlant) { this.avgYieldPlant = avgYieldPlant; }
        public Double getAvgYieldRatoon() { return avgYieldRatoon; } public void setAvgYieldRatoon(Double avgYieldRatoon) { this.avgYieldRatoon = avgYieldRatoon; }
        public Double getAvgPrepIndex() { return avgPrepIndex; } public void setAvgPrepIndex(Double avgPrepIndex) { this.avgPrepIndex = avgPrepIndex; }
        public Double getAvgTempAddedWater() { return avgTempAddedWater; } public void setAvgTempAddedWater(Double avgTempAddedWater) { this.avgTempAddedWater = avgTempAddedWater; }
        public Double getBagasseUsedFuel() { return bagasseUsedFuel; } public void setBagasseUsedFuel(Double bagasseUsedFuel) { this.bagasseUsedFuel = bagasseUsedFuel; }
        public Double getBagasseUsedSugarPlant() { return bagasseUsedSugarPlant; } public void setBagasseUsedSugarPlant(Double bagasseUsedSugarPlant) { this.bagasseUsedSugarPlant = bagasseUsedSugarPlant; }
        public Double getBagasseUsedByProducts() { return bagasseUsedByProducts; } public void setBagasseUsedByProducts(Double bagasseUsedByProducts) { this.bagasseUsedByProducts = bagasseUsedByProducts; }
        public Double getBagasseUsedCogen() { return bagasseUsedCogen; } public void setBagasseUsedCogen(Double bagasseUsedCogen) { this.bagasseUsedCogen = bagasseUsedCogen; }
        public Double getBagasseUsedOliver() { return bagasseUsedOliver; } public void setBagasseUsedOliver(Double bagasseUsedOliver) { this.bagasseUsedOliver = bagasseUsedOliver; }
        public Double getBagasseSold() { return bagasseSold; } public void setBagasseSold(Double bagasseSold) { this.bagasseSold = bagasseSold; }
    }
}