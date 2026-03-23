package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportDailyAnalysisDAO;
import com.twd.sugarfactory.model.DailyAnalysisReport;
import com.twd.sugarfactory.serviceinterface.ReportDailyAnalysisService;

public class ReportDailyAnalysisServiceImpl implements ReportDailyAnalysisService {

    private ReportDailyAnalysisDAO dao = new ReportDailyAnalysisDAO();

    @Override
    public DailyAnalysisReport getDailyAnalysis(String sampleDate) {
        if (sampleDate == null || sampleDate.trim().isEmpty()) {
            return null;
        }
        // Additional business logic/calculations could be added here if needed
        return dao.getDailyAnalysisByDate(sampleDate);
    }
}