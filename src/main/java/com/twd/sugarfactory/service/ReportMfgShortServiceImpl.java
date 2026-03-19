package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportMfgShortDAO;
import com.twd.sugarfactory.model.DailyMfgShort;
import com.twd.sugarfactory.serviceinterface.ReportMfgShortService;

public class ReportMfgShortServiceImpl implements ReportMfgShortService {
    
    private ReportMfgShortDAO dao = new ReportMfgShortDAO();

    @Override
    public DailyMfgShort generateReport(String reportDate) {
        // Basic validation before calling the DAO
        if (reportDate == null || reportDate.trim().isEmpty()) {
            return null;
        }
        
        // Fetch data from the DAO (Report Date format: YYYY-MM-DD)
        return dao.getReportData(reportDate);
    }
}