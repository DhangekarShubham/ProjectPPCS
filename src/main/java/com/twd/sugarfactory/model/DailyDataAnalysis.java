package com.twd.sugarfactory.model;

public class DailyDataAnalysis {
    
    // --- CORE ---
    private String sampleDate;
    
    // --- SCREEN 1: Crushing & Weight Data ---
    private Double fcWeight;
    private Double memberCane;
    private Double nonMemberCane;
    
    // --- SCREEN 1: Time Account ---
    private Double workHours;
    private Double lostMech;
    private Double lostElec;
    
    // --- SCREEN 1: Solid Waste Analysis (Pol & Moisture) ---
    private Double bagassePol;
    private Double bagasseMoist;
    private Double fcPol;
    private Double fcMoist;
    
    // --- SCREEN 1: Efficiency Corrections ---
    private Double dirtCorrection;
    private Double recoveryCorrection;
    private Double undetLosses;
    
    // --- SCREEN 1: Thermal Parameters ---
    private Double inletTemp;
    private Double outletTemp;
    
    // --- SCREEN 2: Sugar Production (Bags) ---
    private Integer bagsL30_50;
    private Integer bagsM30_50;
    private Integer bagsS130_50;
    private Integer bagsL30_100;
    private Integer bagsRaw_50;
    
    // --- SCREEN 2: Laboratory Analysis (Brix, Pol, Purity) ---
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
    
    private Double aMassBrix; 
    private Double aMassPole; 
    private Double aMassPurity;

    // Default Constructor
    public DailyDataAnalysis() {}

    // ==========================================
    // GETTERS AND SETTERS
    // ==========================================

    public String getSampleDate() { return sampleDate; }
    public void setSampleDate(String sampleDate) { this.sampleDate = sampleDate; }

    public Double getFcWeight() { return fcWeight; }
    public void setFcWeight(Double fcWeight) { this.fcWeight = fcWeight; }

    public Double getMemberCane() { return memberCane; }
    public void setMemberCane(Double memberCane) { this.memberCane = memberCane; }

    public Double getNonMemberCane() { return nonMemberCane; }
    public void setNonMemberCane(Double nonMemberCane) { this.nonMemberCane = nonMemberCane; }

    public Double getWorkHours() { return workHours; }
    public void setWorkHours(Double workHours) { this.workHours = workHours; }

    public Double getLostMech() { return lostMech; }
    public void setLostMech(Double lostMech) { this.lostMech = lostMech; }

    public Double getLostElec() { return lostElec; }
    public void setLostElec(Double lostElec) { this.lostElec = lostElec; }

    public Double getBagassePol() { return bagassePol; }
    public void setBagassePol(Double bagassePol) { this.bagassePol = bagassePol; }

    public Double getBagasseMoist() { return bagasseMoist; }
    public void setBagasseMoist(Double bagasseMoist) { this.bagasseMoist = bagasseMoist; }

    public Double getFcPol() { return fcPol; }
    public void setFcPol(Double fcPol) { this.fcPol = fcPol; }

    public Double getFcMoist() { return fcMoist; }
    public void setFcMoist(Double fcMoist) { this.fcMoist = fcMoist; }

    public Double getDirtCorrection() { return dirtCorrection; }
    public void setDirtCorrection(Double dirtCorrection) { this.dirtCorrection = dirtCorrection; }

    public Double getRecoveryCorrection() { return recoveryCorrection; }
    public void setRecoveryCorrection(Double recoveryCorrection) { this.recoveryCorrection = recoveryCorrection; }

    public Double getUndetLosses() { return undetLosses; }
    public void setUndetLosses(Double undetLosses) { this.undetLosses = undetLosses; }

    public Double getInletTemp() { return inletTemp; }
    public void setInletTemp(Double inletTemp) { this.inletTemp = inletTemp; }

    public Double getOutletTemp() { return outletTemp; }
    public void setOutletTemp(Double outletTemp) { this.outletTemp = outletTemp; }

    public Integer getBagsL30_50() { return bagsL30_50; }
    public void setBagsL30_50(Integer bagsL30_50) { this.bagsL30_50 = bagsL30_50; }

    public Integer getBagsM30_50() { return bagsM30_50; }
    public void setBagsM30_50(Integer bagsM30_50) { this.bagsM30_50 = bagsM30_50; }

    public Integer getBagsS130_50() { return bagsS130_50; }
    public void setBagsS130_50(Integer bagsS130_50) { this.bagsS130_50 = bagsS130_50; }

    public Integer getBagsL30_100() { return bagsL30_100; }
    public void setBagsL30_100(Integer bagsL30_100) { this.bagsL30_100 = bagsL30_100; }

    public Integer getBagsRaw_50() { return bagsRaw_50; }
    public void setBagsRaw_50(Integer bagsRaw_50) { this.bagsRaw_50 = bagsRaw_50; }

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

    public Double getaMassBrix() { return aMassBrix; }
    public void setaMassBrix(Double aMassBrix) { this.aMassBrix = aMassBrix; }

    public Double getaMassPole() { return aMassPole; }
    public void setaMassPole(Double aMassPole) { this.aMassPole = aMassPole; }

    public Double getaMassPurity() { return aMassPurity; }
    public void setaMassPurity(Double aMassPurity) { this.aMassPurity = aMassPurity; }
}