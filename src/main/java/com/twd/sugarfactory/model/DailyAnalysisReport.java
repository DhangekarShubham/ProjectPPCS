package com.twd.sugarfactory.model;

public class DailyAnalysisReport {
    // Meta
    private String seasonYear;
    
    // Time & Throughput
    private Double workingHours;
    private Double lostHours;
    private Double memberCane;
    private Double nonMemberCane;
    private Double totalCrushed;
    
    // Corrections & Recovery
    private Double dirtCorrection;
    private Double recoveryCorrection;
    private Double undeterminedLosses;
    private Double condenserInlet;
    private Double condenserOutlet;
    
    // By-Product Analysis
    private Double bagassePol;
    private Double bagasseMoist;
    private Double filterCakePol;
    private Double filterCakeMoist;
    
    // Sugar Production
    private Integer sugarM30;
    private Integer sugarS130;
    private Integer totalBags;
    
    // Process Products (Brix, Pol, Purity)
    private Double pjBrix;
    private Double pjPole;
    private Double pjPurity;
    
    private Double mjBrix;
    private Double mjPole;
    private Double mjPurity;
    
    private Double cjBrix;
    private Double cjPole;
    private Double cjPurity;
    
    private Double fmBrix;
    private Double fmPole;
    private Double fmPurity;

    // Default Constructor
    public DailyAnalysisReport() {}

    // Getters and Setters (Auto-generated)
    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public Double getWorkingHours() { return workingHours; }
    public void setWorkingHours(Double workingHours) { this.workingHours = workingHours; }

    public Double getLostHours() { return lostHours; }
    public void setLostHours(Double lostHours) { this.lostHours = lostHours; }

    public Double getMemberCane() { return memberCane; }
    public void setMemberCane(Double memberCane) { this.memberCane = memberCane; }

    public Double getNonMemberCane() { return nonMemberCane; }
    public void setNonMemberCane(Double nonMemberCane) { this.nonMemberCane = nonMemberCane; }

    public Double getTotalCrushed() { return totalCrushed; }
    public void setTotalCrushed(Double totalCrushed) { this.totalCrushed = totalCrushed; }

    public Double getDirtCorrection() { return dirtCorrection; }
    public void setDirtCorrection(Double dirtCorrection) { this.dirtCorrection = dirtCorrection; }

    public Double getRecoveryCorrection() { return recoveryCorrection; }
    public void setRecoveryCorrection(Double recoveryCorrection) { this.recoveryCorrection = recoveryCorrection; }

    public Double getUndeterminedLosses() { return undeterminedLosses; }
    public void setUndeterminedLosses(Double undeterminedLosses) { this.undeterminedLosses = undeterminedLosses; }

    public Double getCondenserInlet() { return condenserInlet; }
    public void setCondenserInlet(Double condenserInlet) { this.condenserInlet = condenserInlet; }

    public Double getCondenserOutlet() { return condenserOutlet; }
    public void setCondenserOutlet(Double condenserOutlet) { this.condenserOutlet = condenserOutlet; }

    public Double getBagassePol() { return bagassePol; }
    public void setBagassePol(Double bagassePol) { this.bagassePol = bagassePol; }

    public Double getBagasseMoist() { return bagasseMoist; }
    public void setBagasseMoist(Double bagasseMoist) { this.bagasseMoist = bagasseMoist; }

    public Double getFilterCakePol() { return filterCakePol; }
    public void setFilterCakePol(Double filterCakePol) { this.filterCakePol = filterCakePol; }

    public Double getFilterCakeMoist() { return filterCakeMoist; }
    public void setFilterCakeMoist(Double filterCakeMoist) { this.filterCakeMoist = filterCakeMoist; }

    public Integer getSugarM30() { return sugarM30; }
    public void setSugarM30(Integer sugarM30) { this.sugarM30 = sugarM30; }

    public Integer getSugarS130() { return sugarS130; }
    public void setSugarS130(Integer sugarS130) { this.sugarS130 = sugarS130; }

    public Integer getTotalBags() { return totalBags; }
    public void setTotalBags(Integer totalBags) { this.totalBags = totalBags; }

    public Double getPjBrix() { return pjBrix; }
    public void setPjBrix(Double pjBrix) { this.pjBrix = pjBrix; }

    public Double getPjPole() { return pjPole; }
    public void setPjPole(Double pjPole) { this.pjPole = pjPole; }

    public Double getPjPurity() { return pjPurity; }
    public void setPjPurity(Double pjPurity) { this.pjPurity = pjPurity; }

    public Double getMjBrix() { return mjBrix; }
    public void setMjBrix(Double mjBrix) { this.mjBrix = mjBrix; }

    public Double getMjPole() { return mjPole; }
    public void setMjPole(Double mjPole) { this.mjPole = mjPole; }

    public Double getMjPurity() { return mjPurity; }
    public void setMjPurity(Double mjPurity) { this.mjPurity = mjPurity; }

    public Double getCjBrix() { return cjBrix; }
    public void setCjBrix(Double cjBrix) { this.cjBrix = cjBrix; }

    public Double getCjPole() { return cjPole; }
    public void setCjPole(Double cjPole) { this.cjPole = cjPole; }

    public Double getCjPurity() { return cjPurity; }
    public void setCjPurity(Double cjPurity) { this.cjPurity = cjPurity; }

    public Double getFmBrix() { return fmBrix; }
    public void setFmBrix(Double fmBrix) { this.fmBrix = fmBrix; }

    public Double getFmPole() { return fmPole; }
    public void setFmPole(Double fmPole) { this.fmPole = fmPole; }

    public Double getFmPurity() { return fmPurity; }
    public void setFmPurity(Double fmPurity) { this.fmPurity = fmPurity; }
}