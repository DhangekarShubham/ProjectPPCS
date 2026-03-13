package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportMfgDetailsDAO;
import com.twd.sugarfactory.model.DailyMfgDetails;
import com.twd.sugarfactory.serviceinterface.ReportMfgDetailsService;
import java.util.List;

public class ReportMfgDetailsServiceImpl implements ReportMfgDetailsService {
    private ReportMfgDetailsDAO dao = new ReportMfgDetailsDAO();

    @Override
    public List<DailyMfgDetails> generateReport(String reportDate) {
        if(reportDate == null || reportDate.trim().isEmpty()) {
            return new java.util.ArrayList<>(); // Return empty list if no date provided
        }
        return dao.getReportData(reportDate);
    }
}