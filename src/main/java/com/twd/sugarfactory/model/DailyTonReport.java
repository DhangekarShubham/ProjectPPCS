package com.twd.sugarfactory.model;

public class DailyTonReport {
    private String reportDate;
    private String seasonYear;
    private Integer cropDay;
    
    // Shift Details (Today)
    private Double shiftACane; private Double shiftAHours;
    private Double shiftBCane; private Double shiftBHours;
    private Double shiftCCane; private Double shiftCHours;
    
    // To-Date Totals (From start of season)
    private Double totalCaneTodate;
    private Double totalHoursTodate;
    
    // Source Category (Today)
    private Double memberCaneToday;
    private Double nonMemberCaneToday;
    
    // Source Category (To-Date)
    private Double memberCaneTodate;
    private Double nonMemberCaneTodate;
    
    // Transport Type (Today)
    private Double bullockCartToday;
    private Double tractorToday;
    private Double truckToday;

    // Transport Type (To-Date)
    private Double bullockCartTodate;
    private Double tractorTodate;
    private Double truckTodate;

    public DailyTonReport() {}

    // Getters and Setters (Generate all via IDE, showing a few for brevity)
    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }
    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }
    public Integer getCropDay() { return cropDay; }
    public void setCropDay(Integer cropDay) { this.cropDay = cropDay; }

    public Double getShiftACane() { return shiftACane; }
    public void setShiftACane(Double shiftACane) { this.shiftACane = shiftACane; }
    public Double getShiftAHours() { return shiftAHours; }
    public void setShiftAHours(Double shiftAHours) { this.shiftAHours = shiftAHours; }
    
    // ... Generate the rest of the getters and setters ...

    public Double getMemberCaneToday() { return memberCaneToday; }
    public void setMemberCaneToday(Double memberCaneToday) { this.memberCaneToday = memberCaneToday; }
    public Double getMemberCaneTodate() { return memberCaneTodate; }
    public void setMemberCaneTodate(Double memberCaneTodate) { this.memberCaneTodate = memberCaneTodate; }
    
    public Double getBullockCartToday() { return bullockCartToday; }
    public void setBullockCartToday(Double bullockCartToday) { this.bullockCartToday = bullockCartToday; }
    // ...

	public Double getShiftBCane() {
		return shiftBCane;
	}

	public void setShiftBCane(Double shiftBCane) {
		this.shiftBCane = shiftBCane;
	}

	public Double getShiftBHours() {
		return shiftBHours;
	}

	public void setShiftBHours(Double shiftBHours) {
		this.shiftBHours = shiftBHours;
	}

	public Double getShiftCCane() {
		return shiftCCane;
	}

	public void setShiftCCane(Double shiftCCane) {
		this.shiftCCane = shiftCCane;
	}

	public Double getShiftCHours() {
		return shiftCHours;
	}

	public void setShiftCHours(Double shiftCHours) {
		this.shiftCHours = shiftCHours;
	}

	public Double getTotalCaneTodate() {
		return totalCaneTodate;
	}

	public void setTotalCaneTodate(Double totalCaneTodate) {
		this.totalCaneTodate = totalCaneTodate;
	}

	public Double getTotalHoursTodate() {
		return totalHoursTodate;
	}

	public void setTotalHoursTodate(Double totalHoursTodate) {
		this.totalHoursTodate = totalHoursTodate;
	}

	public Double getNonMemberCaneToday() {
		return nonMemberCaneToday;
	}

	public void setNonMemberCaneToday(Double nonMemberCaneToday) {
		this.nonMemberCaneToday = nonMemberCaneToday;
	}

	public Double getNonMemberCaneTodate() {
		return nonMemberCaneTodate;
	}

	public void setNonMemberCaneTodate(Double nonMemberCaneTodate) {
		this.nonMemberCaneTodate = nonMemberCaneTodate;
	}

	public Double getTractorToday() {
		return tractorToday;
	}

	public void setTractorToday(Double tractorToday) {
		this.tractorToday = tractorToday;
	}

	public Double getTruckToday() {
		return truckToday;
	}

	public void setTruckToday(Double truckToday) {
		this.truckToday = truckToday;
	}

	public Double getBullockCartTodate() {
		return bullockCartTodate;
	}

	public void setBullockCartTodate(Double bullockCartTodate) {
		this.bullockCartTodate = bullockCartTodate;
	}

	public Double getTractorTodate() {
		return tractorTodate;
	}

	public void setTractorTodate(Double tractorTodate) {
		this.tractorTodate = tractorTodate;
	}

	public Double getTruckTodate() {
		return truckTodate;
	}

	public void setTruckTodate(Double truckTodate) {
		this.truckTodate = truckTodate;
	}
}