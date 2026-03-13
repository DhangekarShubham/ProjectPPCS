package com.twd.sugarfactory.model;

public class BatchProcessRequest {
    private String fromDate;
    private String toDate;
    private String processModule;

    public BatchProcessRequest() {}

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getProcessModule() {
        return processModule;
    }

    public void setProcessModule(String processModule) {
        this.processModule = processModule;
    }
}