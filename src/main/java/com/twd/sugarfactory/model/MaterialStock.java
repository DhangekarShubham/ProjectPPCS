package com.twd.sugarfactory.model;

/**
 * Model class for Daily Material Stock & Inventory.
 * Maps material_master items with daily_stock_log quantities.
 */
public class MaterialStock {
    private String sampleDate;
    private Integer materialId;     // Foreign key to material_master
    private String materialName;   // For UI display
    private String unitOfMeasure;  // To show 'Bags', 'Qtls', or 'HL'
    private Double quantity;       // Maps to quantity_qtls (Weight)
    private Double volume;         // Maps to volume_hl (Liquid Volume)

    public MaterialStock() {}

    // Overloaded Constructor for quick DAO mapping
    public MaterialStock(Integer materialId, String materialName, Double quantity, Double volume) {
        this.materialId = materialId;
        this.materialName = materialName;
        this.quantity = quantity;
        this.volume = volume;
    }

    // Getters and Setters
    public String getSampleDate() { return sampleDate; }
    public void setSampleDate(String sampleDate) { this.sampleDate = sampleDate; }

    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }

    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

    public String getUnitOfMeasure() { return unitOfMeasure; }
    public void setUnitOfMeasure(String unitOfMeasure) { this.unitOfMeasure = unitOfMeasure; }

    public Double getQuantity() { return quantity; }
    public void setQuantity(Double quantity) { this.quantity = quantity; }

    public Double getVolume() { return volume; }
    public void setVolume(Double volume) { this.volume = volume; }

    @Override
    public String toString() {
        return "MaterialStock [date=" + sampleDate + ", id=" + materialId 
                + ", name=" + materialName + ", qty=" + quantity + ", vol=" + volume + "]";
    }
}