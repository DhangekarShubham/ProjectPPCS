package com.twd.sugarfactory.model;

public class DailyCrushing {
    private String crushDate;
    private String seasonYear; // e.g., "2025-2026"
    private Integer cropDay;
    
    // On Date (Daily)
    private Double caneOnDate;
    private Double sugarOnDate;
    private Double percentOnDate;
    
    // To Date (Cumulative - Calculated by Backend)
    private Double caneToDate;
    private Double sugarToDate;
    private Double percentToDate;

    public DailyCrushing() {}

    // Getters and Setters
    public String getCrushDate() { return crushDate; }
    public void setCrushDate(String crushDate) { this.crushDate = crushDate; }

    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public Integer getCropDay() { return cropDay; }
    public void setCropDay(Integer cropDay) { this.cropDay = cropDay; }

    public Double getCaneOnDate() { return caneOnDate; }
    public void setCaneOnDate(Double caneOnDate) { this.caneOnDate = caneOnDate; }

    public Double getSugarOnDate() { return sugarOnDate; }
    public void setSugarOnDate(Double sugarOnDate) { this.sugarOnDate = sugarOnDate; }

    public Double getPercentOnDate() { return percentOnDate; }
    public void setPercentOnDate(Double percentOnDate) { this.percentOnDate = percentOnDate; }

    public Double getCaneToDate() { return caneToDate; }
    public void setCaneToDate(Double caneToDate) { this.caneToDate = caneToDate; }

    public Double getSugarToDate() { return sugarToDate; }
    public void setSugarToDate(Double sugarToDate) { this.sugarToDate = sugarToDate; }

    public Double getPercentToDate() { return percentToDate; }
    public void setPercentToDate(Double percentToDate) { this.percentToDate = percentToDate; }
}