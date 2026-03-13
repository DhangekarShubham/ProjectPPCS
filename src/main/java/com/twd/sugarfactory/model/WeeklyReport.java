package com.twd.sugarfactory.model;

public class WeeklyReport {
    private String seasonYear;
    private Integer weekNo;
    private String fromDate;
    private String toDate;

    // 1. Cane Crushing & Sugar Production
    private Double caneCrushedWeek;
    private Double caneCrushedTodate;
    private Double sugarBaggedWeek;
    private Double sugarBaggedTodate;
    private Double sugarInProcessWeek;
    private Double sugarInProcessTodate;
    
    private Double totalSugarMadeWeek;
    private Double totalSugarMadeTodate;
    private Double recoveryWeek;
    private Double recoveryTodate;

    // 2. Time Account & Crushing Rate
    private Double availableHrsWeek;
    private Double availableHrsTodate;
    private Double lostHrsWeek;
    private Double lostHrsTodate;
    private Double crushingHrsWeek;
    private Double crushingHrsTodate;
    
    private Double crushRateWeek;
    private Double crushRateTodate;

    // 3. Efficiency & Losses
    private Double millExtWeek;
    private Double millExtTodate;
    private Double redMillExtWeek;
    private Double redMillExtTodate;
    private Double boilingHouseExtWeek;
    private Double boilingHouseExtTodate;
    private Double overallExtWeek;
    private Double overallExtTodate;
    private Double sugarLossesWeek;
    private Double sugarLossesTodate;
    private Double bagassePctWeek;
    private Double bagassePctTodate;

    public WeeklyReport() {}

    // Getters and Setters (Generate all via your IDE. Showing a few for brevity)
    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }
    public Integer getWeekNo() { return weekNo; }
    public void setWeekNo(Integer weekNo) { this.weekNo = weekNo; }
    public String getFromDate() { return fromDate; }
    public void setFromDate(String fromDate) { this.fromDate = fromDate; }
    public String getToDate() { return toDate; }
    public void setToDate(String toDate) { this.toDate = toDate; }

    public Double getCaneCrushedWeek() { return caneCrushedWeek; }
    public void setCaneCrushedWeek(Double caneCrushedWeek) { this.caneCrushedWeek = caneCrushedWeek; }
    public Double getCaneCrushedTodate() { return caneCrushedTodate; }
    public void setCaneCrushedTodate(Double caneCrushedTodate) { this.caneCrushedTodate = caneCrushedTodate; }
    
    // ... Please generate the rest of the getters and setters ...
    
    public Double getRecoveryWeek() { return recoveryWeek; }
    public void setRecoveryWeek(Double recoveryWeek) { this.recoveryWeek = recoveryWeek; }
    public Double getRecoveryTodate() { return recoveryTodate; }
    public void setRecoveryTodate(Double recoveryTodate) { this.recoveryTodate = recoveryTodate; }
    
    public Double getMillExtWeek() { return millExtWeek; }
    public void setMillExtWeek(Double millExtWeek) { this.millExtWeek = millExtWeek; }
    public Double getMillExtTodate() { return millExtTodate; }
    public void setMillExtTodate(Double millExtTodate) { this.millExtTodate = millExtTodate; }

	public Double getSugarBaggedWeek() {
		return sugarBaggedWeek;
	}

	public void setSugarBaggedWeek(Double sugarBaggedWeek) {
		this.sugarBaggedWeek = sugarBaggedWeek;
	}

	public Double getSugarBaggedTodate() {
		return sugarBaggedTodate;
	}

	public void setSugarBaggedTodate(Double sugarBaggedTodate) {
		this.sugarBaggedTodate = sugarBaggedTodate;
	}

	public Double getSugarInProcessWeek() {
		return sugarInProcessWeek;
	}

	public void setSugarInProcessWeek(Double sugarInProcessWeek) {
		this.sugarInProcessWeek = sugarInProcessWeek;
	}

	public Double getSugarInProcessTodate() {
		return sugarInProcessTodate;
	}

	public void setSugarInProcessTodate(Double sugarInProcessTodate) {
		this.sugarInProcessTodate = sugarInProcessTodate;
	}

	public Double getTotalSugarMadeWeek() {
		return totalSugarMadeWeek;
	}

	public void setTotalSugarMadeWeek(Double totalSugarMadeWeek) {
		this.totalSugarMadeWeek = totalSugarMadeWeek;
	}

	public Double getTotalSugarMadeTodate() {
		return totalSugarMadeTodate;
	}

	public void setTotalSugarMadeTodate(Double totalSugarMadeTodate) {
		this.totalSugarMadeTodate = totalSugarMadeTodate;
	}

	public Double getAvailableHrsWeek() {
		return availableHrsWeek;
	}

	public void setAvailableHrsWeek(Double availableHrsWeek) {
		this.availableHrsWeek = availableHrsWeek;
	}

	public Double getAvailableHrsTodate() {
		return availableHrsTodate;
	}

	public void setAvailableHrsTodate(Double availableHrsTodate) {
		this.availableHrsTodate = availableHrsTodate;
	}

	public Double getLostHrsWeek() {
		return lostHrsWeek;
	}

	public void setLostHrsWeek(Double lostHrsWeek) {
		this.lostHrsWeek = lostHrsWeek;
	}

	public Double getLostHrsTodate() {
		return lostHrsTodate;
	}

	public void setLostHrsTodate(Double lostHrsTodate) {
		this.lostHrsTodate = lostHrsTodate;
	}

	public Double getCrushingHrsWeek() {
		return crushingHrsWeek;
	}

	public void setCrushingHrsWeek(Double crushingHrsWeek) {
		this.crushingHrsWeek = crushingHrsWeek;
	}

	public Double getCrushingHrsTodate() {
		return crushingHrsTodate;
	}

	public void setCrushingHrsTodate(Double crushingHrsTodate) {
		this.crushingHrsTodate = crushingHrsTodate;
	}

	public Double getCrushRateWeek() {
		return crushRateWeek;
	}

	public void setCrushRateWeek(Double crushRateWeek) {
		this.crushRateWeek = crushRateWeek;
	}

	public Double getCrushRateTodate() {
		return crushRateTodate;
	}

	public void setCrushRateTodate(Double crushRateTodate) {
		this.crushRateTodate = crushRateTodate;
	}

	public Double getRedMillExtWeek() {
		return redMillExtWeek;
	}

	public void setRedMillExtWeek(Double redMillExtWeek) {
		this.redMillExtWeek = redMillExtWeek;
	}

	public Double getRedMillExtTodate() {
		return redMillExtTodate;
	}

	public void setRedMillExtTodate(Double redMillExtTodate) {
		this.redMillExtTodate = redMillExtTodate;
	}

	public Double getBoilingHouseExtWeek() {
		return boilingHouseExtWeek;
	}

	public void setBoilingHouseExtWeek(Double boilingHouseExtWeek) {
		this.boilingHouseExtWeek = boilingHouseExtWeek;
	}

	public Double getBoilingHouseExtTodate() {
		return boilingHouseExtTodate;
	}

	public void setBoilingHouseExtTodate(Double boilingHouseExtTodate) {
		this.boilingHouseExtTodate = boilingHouseExtTodate;
	}

	public Double getOverallExtWeek() {
		return overallExtWeek;
	}

	public void setOverallExtWeek(Double overallExtWeek) {
		this.overallExtWeek = overallExtWeek;
	}

	public Double getOverallExtTodate() {
		return overallExtTodate;
	}

	public void setOverallExtTodate(Double overallExtTodate) {
		this.overallExtTodate = overallExtTodate;
	}

	public Double getSugarLossesWeek() {
		return sugarLossesWeek;
	}

	public void setSugarLossesWeek(Double sugarLossesWeek) {
		this.sugarLossesWeek = sugarLossesWeek;
	}

	public Double getSugarLossesTodate() {
		return sugarLossesTodate;
	}

	public void setSugarLossesTodate(Double sugarLossesTodate) {
		this.sugarLossesTodate = sugarLossesTodate;
	}

	public Double getBagassePctWeek() {
		return bagassePctWeek;
	}

	public void setBagassePctWeek(Double bagassePctWeek) {
		this.bagassePctWeek = bagassePctWeek;
	}

	public Double getBagassePctTodate() {
		return bagassePctTodate;
	}

	public void setBagassePctTodate(Double bagassePctTodate) {
		this.bagassePctTodate = bagassePctTodate;
	}
}