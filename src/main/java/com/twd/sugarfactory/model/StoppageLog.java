package com.twd.sugarfactory.model;

public class StoppageLog {
    private Integer stoppageId; // Auto-generated ID (Stoppage Number)
    private String stoppageDate;
    private Double totalTime; // Expressed in decimals (e.g., 0.25 hrs)
    private String categoryCode; // MECHANICAL, ELECTRICAL, etc.
    private String reasonEng; // Description
    private String reasonMar; // Marathi translation

    public StoppageLog() {}

    public Integer getStoppageId() { return stoppageId; }
    public void setStoppageId(Integer stoppageId) { this.stoppageId = stoppageId; }

    public String getStoppageDate() { return stoppageDate; }
    public void setStoppageDate(String stoppageDate) { this.stoppageDate = stoppageDate; }

    public Double getTotalTime() { return totalTime; }
    public void setTotalTime(Double totalTime) { this.totalTime = totalTime; }

    public String getCategoryCode() { return categoryCode; }
    public void setCategoryCode(String categoryCode) { this.categoryCode = categoryCode; }

    public String getReasonEng() { return reasonEng; }
    public void setReasonEng(String reasonEng) { this.reasonEng = reasonEng; }

    public String getReasonMar() { return reasonMar; }
    public void setReasonMar(String reasonMar) { this.reasonMar = reasonMar; }
}