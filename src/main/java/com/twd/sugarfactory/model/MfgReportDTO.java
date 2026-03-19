package com.twd.sugarfactory.model;

import java.util.List;
import java.util.Map;

public class MfgReportDTO {
    
    private Map<String, String> metaInfo;
    private List<MainItem> mainList;
    private List<ByproductItem> byproductList;
    private Map<String, Object> parameters;

    public MfgReportDTO() {}

    public Map<String, String> getMetaInfo() { return metaInfo; }
    public void setMetaInfo(Map<String, String> metaInfo) { this.metaInfo = metaInfo; }

    public List<MainItem> getMainList() { return mainList; }
    public void setMainList(List<MainItem> mainList) { this.mainList = mainList; }

    public List<ByproductItem> getByproductList() { return byproductList; }
    public void setByproductList(List<ByproductItem> byproductList) { this.byproductList = byproductList; }

    public Map<String, Object> getParameters() { return parameters; }
    public void setParameters(Map<String, Object> parameters) { this.parameters = parameters; }

    // --- Inner Class for Table 1 (Boiling House) ---
    public static class MainItem {
        private String particulars;
        private Double brix;
        private Double pol;
        private Double purity;
        private String remark;

        public MainItem(String particulars, Double brix, Double pol, Double purity, String remark) {
            this.particulars = particulars; this.brix = brix; this.pol = pol; this.purity = purity; this.remark = remark;
        }

        public String getParticulars() { return particulars; }
        public Double getBrix() { return brix; }
        public Double getPol() { return pol; }
        public Double getPurity() { return purity; }
        public String getRemark() { return remark; }
    }

    // --- Inner Class for Table 2 (By-Products) ---
    public static class ByproductItem {
        private String particulars;
        private Double moisture;
        private Double pol;

        public ByproductItem(String particulars, Double moisture, Double pol) {
            this.particulars = particulars; this.moisture = moisture; this.pol = pol;
        }

        public String getParticulars() { return particulars; }
        public Double getMoisture() { return moisture; }
        public Double getPol() { return pol; }
    }
}