package com.twd.sugarfactory.model;

/**
 * Model class for Daily Chemical Consumption Grid.
 * Maps material_master names with daily_consumption_log volumes.
 */
public class ChemicalConsumption {
    private String sampleDate;
    private Integer materialId;   // Foreign key to material_master
    private String materialName; // For UI rendering
    private String unitName;     // e.g., MT, Kg, Ltr (fetched from master)
    private Double volumeConsumed;

    // Default Constructor
    public ChemicalConsumption() {}

    // Overloaded Constructor for quick DAO mapping
    public ChemicalConsumption(Integer materialId, String materialName, Double volumeConsumed) {
        this.materialId = materialId;
        this.materialName = materialName;
        this.volumeConsumed = volumeConsumed;
    }

    // Getters and Setters
    public String getSampleDate() { return sampleDate; }
    public void setSampleDate(String sampleDate) { this.sampleDate = sampleDate; }

    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }

    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

    public String getUnitName() { return unitName; }
    public void setUnitName(String unitName) { this.unitName = unitName; }

    public Double getVolumeConsumed() { return volumeConsumed; }
    public void setVolumeConsumed(Double volumeConsumed) { this.volumeConsumed = volumeConsumed; }

    @Override
    public String toString() {
        return "ChemicalConsumption [date=" + sampleDate + ", id=" + materialId 
                + ", name=" + materialName + ", vol=" + volumeConsumed + "]";
    }
}