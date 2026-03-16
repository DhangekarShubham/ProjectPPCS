package com.twd.sugarfactory.model;

import java.io.Serializable;

public class FactoryInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private String seasonYear;
    private String startDate;
    private String startTime;
    private String factoryName;
    private String address;
    private String taluka;
    private String district;
    private String state;
    private String pinCode;
    private String phoneNo;
    private String stdCode;
    private String email;
    private String website;
    private String clarificationProcess;
    private String registrationNo;
    private String gstNo;
    private String fssaiNo;
    private Double commissionRate;
    private String division;
    private String range;
    private Double installedCapacity;
    private String managingDirector;
    private String chiefChemist;
    private String worksManager;
    private String labIncharge;

    // Default Constructor
    public FactoryInfo() {}

    // Parameterized Constructor for quick instantiation
    public FactoryInfo(String seasonYear, String factoryName, String gstNo) {
        this.seasonYear = seasonYear;
        this.factoryName = factoryName;
        this.gstNo = gstNo;
    }

    // Getters and Setters
    public String getSeasonYear() { return seasonYear; }
    public void setSeasonYear(String seasonYear) { this.seasonYear = seasonYear; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getFactoryName() { return factoryName; }
    public void setFactoryName(String factoryName) { this.factoryName = factoryName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getTaluka() { return taluka; }
    public void setTaluka(String taluka) { this.taluka = taluka; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getPinCode() { return pinCode; }
    public void setPinCode(String pinCode) { this.pinCode = pinCode; }

    public String getPhoneNo() { return phoneNo; }
    public void setPhoneNo(String phoneNo) { this.phoneNo = phoneNo; }

    public String getStdCode() { return stdCode; }
    public void setStdCode(String stdCode) { this.stdCode = stdCode; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getClarificationProcess() { return clarificationProcess; }
    public void setClarificationProcess(String clarificationProcess) { this.clarificationProcess = clarificationProcess; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getGstNo() { return gstNo; }
    public void setGstNo(String gstNo) { this.gstNo = gstNo; }

    public String getFssaiNo() { return fssaiNo; }
    public void setFssaiNo(String fssaiNo) { this.fssaiNo = fssaiNo; }

    public Double getCommissionRate() { return commissionRate; } 
    public void setCommissionRate(Double commissionRate) { this.commissionRate = commissionRate; }

    public String getDivision() { return division; }
    public void setDivision(String division) { this.division = division; }

    public String getRange() { return range; }
    public void setRange(String range) { this.range = range; }

    public Double getInstalledCapacity() { return installedCapacity; }
    public void setInstalledCapacity(Double installedCapacity) { this.installedCapacity = installedCapacity; }

    public String getManagingDirector() { return managingDirector; }
    public void setManagingDirector(String managingDirector) { this.managingDirector = managingDirector; }

    public String getChiefChemist() { return chiefChemist; }
    public void setChiefChemist(String chiefChemist) { this.chiefChemist = chiefChemist; }

    public String getWorksManager() { return worksManager; }
    public void setWorksManager(String worksManager) { this.worksManager = worksManager; }

    public String getLabIncharge() { return labIncharge; }
    public void setLabIncharge(String labIncharge) { this.labIncharge = labIncharge; }

    @Override
    public String toString() {
        return "FactoryInfo [seasonYear=" + seasonYear + ", factoryName=" + factoryName + ", gstNo=" + gstNo + "]";
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> branch 'master' of https://github.com/DhangekarShubham/ProjectPPCS.git
