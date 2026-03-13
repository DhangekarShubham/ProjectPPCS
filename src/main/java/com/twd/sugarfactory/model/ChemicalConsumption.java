package com.twd.sugarfactory.model;

public class ChemicalConsumption {
    private String sampleDate;
    private Integer materialId; // Foreign key to material_master
    private String materialName; // Only used for UI rendering
    private Double volumeConsumed;

    public ChemicalConsumption() {}

    public String getSampleDate() {
        return sampleDate;
    }

    public void setSampleDate(String sampleDate) {
        this.sampleDate = sampleDate;
    }

    public Integer getMaterialId() {
        return materialId;
    }

    public void setMaterialId(Integer materialId) {
        this.materialId = materialId;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public Double getVolumeConsumed() {
        return volumeConsumed;
    }

    public void setVolumeConsumed(Double volumeConsumed) {
        this.volumeConsumed = volumeConsumed;
    }
}