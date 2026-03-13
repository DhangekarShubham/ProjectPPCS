package com.twd.sugarfactory.model;

public class DailyMfgDetails {
    private Integer srNo;
    private String particulars; // E.g., "Primary Juice", "Mixed Juice"
    private Double brix;
    private Double pol;
    private Double purity;
    private String remark;

    public DailyMfgDetails() {}

    public Integer getSrNo() { return srNo; }
    public void setSrNo(Integer srNo) { this.srNo = srNo; }

    public String getParticulars() { return particulars; }
    public void setParticulars(String particulars) { this.particulars = particulars; }

    public Double getBrix() { return brix; }
    public void setBrix(Double brix) { this.brix = brix; }

    public Double getPol() { return pol; }
    public void setPol(Double pol) { this.pol = pol; }

    public Double getPurity() { return purity; }
    public void setPurity(Double purity) { this.purity = purity; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
}