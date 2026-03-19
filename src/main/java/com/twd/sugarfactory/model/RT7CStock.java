package com.twd.sugarfactory.model;

public class RT7CStock {
    // Header Fields (New)
    private String rt7cNumber;
    private String seasonYear;
    private String startDate;
    private String endDate;
    private String stockDate; // Maps to sample_date
    private String actualDate;
    
    // Detail Fields (Existing)
    private String reportMonth; 
    private Integer materialId; 
    private String materialName; 
    private String tabCategory; 
    
    private Double quantity; 
    private Double volume;   
    private Double spGravity;
    private Double brixPercent;
    private Double polPercent;
    private Double purityPercent;

    public RT7CStock() {}

    // Getters and Setters
    public String getRt7cNumber() { return rt7cNumber; }
    public void setRt7cNumber(String rt7cNumber) { this.rt7cNumber = rt7cNumber; }

    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getActualDate() { return actualDate; }
    public void setActualDate(String actualDate) { this.actualDate = actualDate; }

    public String getStockDate() { return stockDate; }
    public void setStockDate(String stockDate) { this.stockDate = stockDate; }

    public String getReportMonth() { return reportMonth; }
    public void setReportMonth(String reportMonth) { this.reportMonth = reportMonth; }

    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }

    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

    public String getTabCategory() { return tabCategory; }
    public void setTabCategory(String tabCategory) { this.tabCategory = tabCategory; }

    public Double getQuantity() { return quantity; }
    public void setQuantity(Double quantity) { this.quantity = quantity; }

    public Double getVolume() { return volume; }
    public void setVolume(Double volume) { this.volume = volume; }

    public Double getSpGravity() { return spGravity; }
    public void setSpGravity(Double spGravity) { this.spGravity = spGravity; }

    public Double getBrixPercent() { return brixPercent; }
    public void setBrixPercent(Double brixPercent) { this.brixPercent = brixPercent; }

    public Double getPolPercent() { return polPercent; }
    public void setPolPercent(Double polPercent) { this.polPercent = polPercent; }

    public Double getPurityPercent() { return purityPercent; }
    public void setPurityPercent(Double purityPercent) { this.purityPercent = purityPercent; }
}