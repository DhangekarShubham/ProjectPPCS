package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportMfgShortDAO;
import com.twd.sugarfactory.model.DailyMfgShort;
import com.twd.sugarfactory.serviceinterface.ReportMfgShortService;

public class ReportMfgShortServiceImpl implements ReportMfgShortService {
    private ReportMfgShortDAO dao = new ReportMfgShortDAO();

    @Override
    public DailyMfgShort generateReport(String reportDate) {
        if(reportDate == null || reportDate.trim().isEmpty()) {
            return null; 
        }
        return dao.getReportData(reportDate);
    }
}