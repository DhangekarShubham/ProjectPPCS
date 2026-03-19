package com.twd.sugarfactory.model;

public class RunStock {
    private Integer materialId;
    private String materialName;
    
    // Global Headers
    private String runNumber;
    private String seasonYear;
    private String startDate;
    private String endDate;
    private String stockDate;
    private String actualDate;
    
    // Grid Data
    private Double volume;
    private Double brixPercent;
    private Double polPercent;
    private Double purityPercent;

    public RunStock() {}

    // Getters and Setters
    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }

    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

    public String getRunNumber() { return runNumber; }
    public void setRunNumber(String runNumber) { this.runNumber = runNumber; }

    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getStockDate() { return stockDate; }
    public void setStockDate(String stockDate) { this.stockDate = stockDate; }

    public String getActualDate() { return actualDate; }
    public void setActualDate(String actualDate) { this.actualDate = actualDate; }

    public Double getVolume() { return volume; }
    public void setVolume(Double volume) { this.volume = volume; }

    public Double getBrixPercent() { return brixPercent; }
    public void setBrixPercent(Double brixPercent) { this.brixPercent = brixPercent; }

    public Double getPolPercent() { return polPercent; }
    public void setPolPercent(Double polPercent) { this.polPercent = polPercent; }

    public Double getPurityPercent() { return purityPercent; }
    public void setPurityPercent(Double purityPercent) { this.purityPercent = purityPercent; }
}