package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportMfgSmallDAO;
import com.twd.sugarfactory.model.DailyMfgSmall;
import com.twd.sugarfactory.serviceinterface.ReportMfgSmallService;

public class ReportMfgSmallServiceImpl implements ReportMfgSmallService {
    private ReportMfgSmallDAO dao = new ReportMfgSmallDAO();

    @Override
    public DailyMfgSmall generateReport(String reportDate) {
        if(reportDate == null || reportDate.trim().isEmpty()) {
            return null; 
        }
        return dao.getReportData(reportDate);
    }
}