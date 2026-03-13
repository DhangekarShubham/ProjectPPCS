package com.twd.sugarfactory.model;

public class RT8CPerformance {
    private String reportDate;
    private String seasonYear;
    
    // Agri & Milling
    private Double yieldAdsali;
    private Double yieldPlant;
    private Double yieldRatoon;
    private Double prepIndex;
    private Double waterPctFiber;
    private Double bagassePctCane;
    private Double fcPctCane;
    
    // Bagasse Balance
    private Double bagasseOpening;
    private Double bagasseProduction;
    private Double bagasseBoiler;
    private Double bagasseCogen;
    private Double bagasseSold;
    
    // Alternative Fuel
    private Double coalPct;
    private Double firewoodPct;

    public RT8CPerformance() {}

    // Getters and Setters
    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }

    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public Double getYieldAdsali() { return yieldAdsali; }
    public void setYieldAdsali(Double yieldAdsali) { this.yieldAdsali = yieldAdsali; }

    public Double getYieldPlant() { return yieldPlant; }
    public void setYieldPlant(Double yieldPlant) { this.yieldPlant = yieldPlant; }

    public Double getYieldRatoon() { return yieldRatoon; }
    public void setYieldRatoon(Double yieldRatoon) { this.yieldRatoon = yieldRatoon; }

    public Double getPrepIndex() { return prepIndex; }
    public void setPrepIndex(Double prepIndex) { this.prepIndex = prepIndex; }

    public Double getWaterPctFiber() { return waterPctFiber; }
    public void setWaterPctFiber(Double waterPctFiber) { this.waterPctFiber = waterPctFiber; }

    public Double getBagassePctCane() { return bagassePctCane; }
    public void setBagassePctCane(Double bagassePctCane) { this.bagassePctCane = bagassePctCane; }

    public Double getFcPctCane() { return fcPctCane; }
    public void setFcPctCane(Double fcPctCane) { this.fcPctCane = fcPctCane; }

    public Double getBagasseOpening() { return bagasseOpening; }
    public void setBagasseOpening(Double bagasseOpening) { this.bagasseOpening = bagasseOpening; }

    public Double getBagasseProduction() { return bagasseProduction; }
    public void setBagasseProduction(Double bagasseProduction) { this.bagasseProduction = bagasseProduction; }

    public Double getBagasseBoiler() { return bagasseBoiler; }
    public void setBagasseBoiler(Double bagasseBoiler) { this.bagasseBoiler = bagasseBoiler; }

    public Double getBagasseCogen() { return bagasseCogen; }
    public void setBagasseCogen(Double bagasseCogen) { this.bagasseCogen = bagasseCogen; }

    public Double getBagasseSold() { return bagasseSold; }
    public void setBagasseSold(Double bagasseSold) { this.bagasseSold = bagasseSold; }

    public Double getCoalPct() { return coalPct; }
    public void setCoalPct(Double coalPct) { this.coalPct = coalPct; }

    public Double getFirewoodPct() { return firewoodPct; }
    public void setFirewoodPct(Double firewoodPct) { this.firewoodPct = firewoodPct; }
}