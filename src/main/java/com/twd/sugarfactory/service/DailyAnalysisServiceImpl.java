package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.DailyAnalysisDAO;
import com.twd.sugarfactory.model.DailyDataAnalysis;
import com.twd.sugarfactory.serviceinterface.DailyAnalysisService;

public class DailyAnalysisServiceImpl implements DailyAnalysisService {
    private DailyAnalysisDAO dao = new DailyAnalysisDAO();

    @Override
    public boolean saveDailyData(DailyDataAnalysis data) {
        if (data.getSampleDate() == null || data.getSampleDate().trim().isEmpty()) {
            return false; // Validation
        }
        return dao.saveDailyAnalysis(data);
    }
}