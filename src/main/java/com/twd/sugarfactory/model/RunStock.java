package com.twd.sugarfactory.model;

public class RunStock {
    private String sampleDate;
    private Integer materialId;
    private String materialName;
    private Double volume;       // HL
    private Double spGravity;
    private Double brixPercent;
    private Double polPercent;
    private Double purityPercent;

    public RunStock() {}

    public String getSampleDate() { return sampleDate; }
    public void setSampleDate(String sampleDate) { this.sampleDate = sampleDate; }

    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }

    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

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