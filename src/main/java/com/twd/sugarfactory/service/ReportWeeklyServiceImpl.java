package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportWeeklyDAO;
import com.twd.sugarfactory.model.WeeklyReport;
import com.twd.sugarfactory.serviceinterface.ReportWeeklyService;

public class ReportWeeklyServiceImpl implements ReportWeeklyService {
    private ReportWeeklyDAO dao = new ReportWeeklyDAO();

    @Override
    public WeeklyReport generateWeeklyReport(Integer weekNo, String fromDate, String toDate) {
        if(fromDate == null || toDate == null) {
            return null; 
        }
        return dao.getWeeklyReportData(weekNo, fromDate, toDate);
    }
}