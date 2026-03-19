package com.twd.sugarfactory.model;

public class DailyMfgShort {
    private String reportDate;
    private Integer cropDay;
    
    // Cane Crushing
    private Double caneMemberToday;
    private Double caneMemberTodate;
    private Double caneNonMemberToday;
    private Double caneNonMemberTodate;
    private Double caneOtherToday;
    private Double caneOtherTodate;
    private Double caneTotalToday;
    private Double caneTotalTodate;

    // Sugar Production (Quintals)
    private Double sugarL30Today;
    private Double sugarL30Todate;
    private Double sugarM30Today;
    private Double sugarM30Todate;
    private Double sugarS130Today;
    private Double sugarS130Todate;
    private Double sugarS230Today;
    private Double sugarS230Todate;
    private Double sugarTotalToday;
    private Double sugarTotalTodate;

    // Performance Metrics
    private Double recoveryPct;
    private Double crushingRateWithStoppage;
    private Double crushingRateWithoutStoppage;
    private Double millWorkingHours;
    private Double millStoppageHours;
    private Double inletTemp;
    private Double outletTemp;
    private Double cogenUnits;

    public DailyMfgShort() {}

    // Standard Getters and Setters
    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }
    public Integer getCropDay() { return cropDay; }
    public void setCropDay(Integer cropDay) { this.cropDay = cropDay; }
    
    public Double getCaneMemberToday() { return caneMemberToday; }
    public void setCaneMemberToday(Double caneMemberToday) { this.caneMemberToday = caneMemberToday; }
    public Double getCaneMemberTodate() { return caneMemberTodate; }
    public void setCaneMemberTodate(Double caneMemberTodate) { this.caneMemberTodate = caneMemberTodate; }
    public Double getCaneNonMemberToday() { return caneNonMemberToday; }
    public void setCaneNonMemberToday(Double caneNonMemberToday) { this.caneNonMemberToday = caneNonMemberToday; }
    public Double getCaneNonMemberTodate() { return caneNonMemberTodate; }
    public void setCaneNonMemberTodate(Double caneNonMemberTodate) { this.caneNonMemberTodate = caneNonMemberTodate; }
    public Double getCaneOtherToday() { return caneOtherToday; }
    public void setCaneOtherToday(Double caneOtherToday) { this.caneOtherToday = caneOtherToday; }
    public Double getCaneOtherTodate() { return caneOtherTodate; }
    public void setCaneOtherTodate(Double caneOtherTodate) { this.caneOtherTodate = caneOtherTodate; }
    public Double getCaneTotalToday() { return caneTotalToday; }
    public void setCaneTotalToday(Double caneTotalToday) { this.caneTotalToday = caneTotalToday; }
    public Double getCaneTotalTodate() { return caneTotalTodate; }
    public void setCaneTotalTodate(Double caneTotalTodate) { this.caneTotalTodate = caneTotalTodate; }

    public Double getSugarL30Today() { return sugarL30Today; }
    public void setSugarL30Today(Double sugarL30Today) { this.sugarL30Today = sugarL30Today; }
    public Double getSugarL30Todate() { return sugarL30Todate; }
    public void setSugarL30Todate(Double sugarL30Todate) { this.sugarL30Todate = sugarL30Todate; }
    public Double getSugarM30Today() { return sugarM30Today; }
    public void setSugarM30Today(Double sugarM30Today) { this.sugarM30Today = sugarM30Today; }
    public Double getSugarM30Todate() { return sugarM30Todate; }
    public void setSugarM30Todate(Double sugarM30Todate) { this.sugarM30Todate = sugarM30Todate; }
    public Double getSugarS130Today() { return sugarS130Today; }
    public void setSugarS130Today(Double sugarS130Today) { this.sugarS130Today = sugarS130Today; }
    public Double getSugarS130Todate() { return sugarS130Todate; }
    public void setSugarS130Todate(Double sugarS130Todate) { this.sugarS130Todate = sugarS130Todate; }
    public Double getSugarTotalToday() { return sugarTotalToday; }
    public void setSugarTotalToday(Double sugarTotalToday) { this.sugarTotalToday = sugarTotalToday; }
    public Double getSugarTotalTodate() { return sugarTotalTodate; }
    public void setSugarTotalTodate(Double sugarTotalTodate) { this.sugarTotalTodate = sugarTotalTodate; }

    public Double getInletTemp() { return inletTemp; }
    public void setInletTemp(Double inletTemp) { this.inletTemp = inletTemp; }
    public Double getOutletTemp() { return outletTemp; }
    public void setOutletTemp(Double outletTemp) { this.outletTemp = outletTemp; }
    public Double getRecoveryPct() { return recoveryPct; }
    public void setRecoveryPct(Double recoveryPct) { this.recoveryPct = recoveryPct; }
    public Double getCogenUnits() { return cogenUnits; }
    public void setCogenUnits(Double cogenUnits) { this.cogenUnits = cogenUnits; }
}