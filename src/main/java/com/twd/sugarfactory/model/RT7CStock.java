package com.twd.sugarfactory.model;

public class RT7CStock {
    private String stockDate;
    private String reportMonth; // e.g., "2026-02"
    private Integer materialId; // Links to material_master
    private String materialName; 
    private String tabCategory; // "PROCESS", "SUGAR", "OLD" for UI filtering
    
    private Double quantity; // For Sugar/Molasses (Qtls)
    private Double volume;   // For Process goods (HL)
    private Double spGravity;
    private Double brixPercent;
    private Double polPercent;
    private Double purityPercent;

    public RT7CStock() {}

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