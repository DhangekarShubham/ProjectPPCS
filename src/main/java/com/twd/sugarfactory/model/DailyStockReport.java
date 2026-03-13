package com.twd.sugarfactory.model;

public class DailyStockReport {
    private String reportDate;
    private String seasonYear;
    
    private String rowNumber;
    private String productName;
    private String unit;
    private String category; // "SUGAR" or "BY_PRODUCT"
    
    private Double openingBalance;
    private Double productionToday;
    private Double dispatchSale;
    private Double closingBalance;

    public DailyStockReport() {}

    // Getters and Setters
    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }
    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }
    
    public String getRowNumber() { return rowNumber; }
    public void setRowNumber(String rowNumber) { this.rowNumber = rowNumber; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Double getOpeningBalance() { return openingBalance; }
    public void setOpeningBalance(Double openingBalance) { this.openingBalance = openingBalance; }

    public Double getProductionToday() { return productionToday; }
    public void setProductionToday(Double productionToday) { this.productionToday = productionToday; }

    public Double getDispatchSale() { return dispatchSale; }
    public void setDispatchSale(Double dispatchSale) { this.dispatchSale = dispatchSale; }

    public Double getClosingBalance() { return closingBalance; }
    public void setClosingBalance(Double closingBalance) { this.closingBalance = closingBalance; }
}