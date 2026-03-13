package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportDailyTonDAO;
import com.twd.sugarfactory.model.DailyTonReport;
import com.twd.sugarfactory.serviceinterface.ReportDailyTonService;

public class ReportDailyTonServiceImpl implements ReportDailyTonService {
    private ReportDailyTonDAO dao = new ReportDailyTonDAO();

    @Override
    public DailyTonReport generateTonReport(String reportDate) {
        if(reportDate == null || reportDate.trim().isEmpty()) {
            return null; 
        }
        return dao.getTonReportData(reportDate);
    }
}