package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportMfgDetailsDAO;
import com.twd.sugarfactory.model.MfgReportDTO;
import com.twd.sugarfactory.serviceinterface.ReportMfgDetailsService;

public class ReportMfgDetailsServiceImpl implements ReportMfgDetailsService {
    private ReportMfgDetailsDAO dao = new ReportMfgDetailsDAO();

    @Override
    public MfgReportDTO generateReport(String reportDate) {
        // Return an empty DTO if no date is provided
        if(reportDate == null || reportDate.trim().isEmpty()) {
            return new MfgReportDTO(); 
        }
        return dao.getReportData(reportDate);
    }
}