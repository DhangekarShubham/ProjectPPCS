package com.twd.sugarfactory.model;

public class DailyCrushing {
    private String crushDate;
    private String seasonYear; // e.g., "2025-2026"
    private Integer cropDay;
    
    // On Date (Daily)
    private Double caneOnDate;
    private Double sugarOnDate;
    private Double percentOnDate;
    
    // NEW: Added fields from the updated UI
    private Double millExtOnDate;
    private Double reducedExtOnDate;
    private String millStartOnDate; 
    private Double cogenOnDate;
    
    // To Date (Cumulative - Calculated by Backend)
    private Double caneToDate;
    private Double sugarToDate;
    private Double percentToDate;
    
    // NEW: To Date fields for the new UI additions
    private Double millExtToDate;
    private Double reducedExtToDate;
    private String millStartToDate;
    private Double cogenToDate;

    public DailyCrushing() {}

    // --- Core Getters and Setters ---
    public String getCrushDate() { return crushDate; }
    public void setCrushDate(String crushDate) { this.crushDate = crushDate; }

    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public Integer getCropDay() { return cropDay; }
    public void setCropDay(Integer cropDay) { this.cropDay = cropDay; }

    // --- On Date Getters and Setters ---
    public Double getCaneOnDate() { return caneOnDate; }
    public void setCaneOnDate(Double caneOnDate) { this.caneOnDate = caneOnDate; }

    public Double getSugarOnDate() { return sugarOnDate; }
    public void setSugarOnDate(Double sugarOnDate) { this.sugarOnDate = sugarOnDate; }

    public Double getPercentOnDate() { return percentOnDate; }
    public void setPercentOnDate(Double percentOnDate) { this.percentOnDate = percentOnDate; }

    public Double getMillExtOnDate() { return millExtOnDate; }
    public void setMillExtOnDate(Double millExtOnDate) { this.millExtOnDate = millExtOnDate; }

    public Double getReducedExtOnDate() { return reducedExtOnDate; }
    public void setReducedExtOnDate(Double reducedExtOnDate) { this.reducedExtOnDate = reducedExtOnDate; }

    public String getMillStartOnDate() { return millStartOnDate; }
    public void setMillStartOnDate(String millStartOnDate) { this.millStartOnDate = millStartOnDate; }

    public Double getCogenOnDate() { return cogenOnDate; }
    public void setCogenOnDate(Double cogenOnDate) { this.cogenOnDate = cogenOnDate; }

    // --- To Date Getters and Setters ---
    public Double getCaneToDate() { return caneToDate; }
    public void setCaneToDate(Double caneToDate) { this.caneToDate = caneToDate; }

    public Double getSugarToDate() { return sugarToDate; }
    public void setSugarToDate(Double sugarToDate) { this.sugarToDate = sugarToDate; }

    public Double getPercentToDate() { return percentToDate; }
    public void setPercentToDate(Double percentToDate) { this.percentToDate = percentToDate; }

    public Double getMillExtToDate() { return millExtToDate; }
    public void setMillExtToDate(Double millExtToDate) { this.millExtToDate = millExtToDate; }

    public Double getReducedExtToDate() { return reducedExtToDate; }
    public void setReducedExtToDate(Double reducedExtToDate) { this.reducedExtToDate = reducedExtToDate; }

    public String getMillStartToDate() { return millStartToDate; }
    public void setMillStartToDate(String millStartToDate) { this.millStartToDate = millStartToDate; }

    public Double getCogenToDate() { return cogenToDate; }
    public void setCogenToDate(Double cogenToDate) { this.cogenToDate = cogenToDate; }
}