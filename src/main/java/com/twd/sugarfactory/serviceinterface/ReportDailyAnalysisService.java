package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.DailyAnalysisReport;

public interface ReportDailyAnalysisService {
    /**
     * Fetches the consolidated daily analysis report for a given date.
     * @param sampleDate Format YYYY-MM-DD
     * @return DailyAnalysisReport object or null if no data found.
     */
    DailyAnalysisReport getDailyAnalysis(String sampleDate);
}