package com.twd.sugarfactory.model;

public class MaterialStock {
    private String sampleDate;
    private Integer materialId;     // Foreign key to material_master
    private String materialName;   // For UI display
    private Double quantity;       // quantity_qtls
    private Double volume;         // volume_hl

    public MaterialStock() {}

    public String getSampleDate() { return sampleDate; }
    public void setSampleDate(String sampleDate) { this.sampleDate = sampleDate; }

    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }

    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

    public Double getQuantity() { return quantity; }
    public void setQuantity(Double quantity) { this.quantity = quantity; }

    public Double getVolume() { return volume; }
    public void setVolume(Double volume) { this.volume = volume; }
}