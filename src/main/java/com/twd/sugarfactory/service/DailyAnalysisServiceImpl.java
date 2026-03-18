package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.DailyAnalysisDAO;
import com.twd.sugarfactory.model.DailyDataAnalysis;
import com.twd.sugarfactory.serviceinterface.DailyAnalysisService;
import java.util.Map;

public class DailyAnalysisServiceImpl implements DailyAnalysisService {
    
    private DailyAnalysisDAO dao = new DailyAnalysisDAO();

    @Override
    public DailyDataAnalysis getDailyData(String sampleDate) {
        if (sampleDate == null || sampleDate.trim().isEmpty()) {
            return null;
        }
        // Ensure date is only YYYY-MM-DD before sending to DAO
        String cleanedDate = cleanDate(sampleDate);
        return dao.getDailyAnalysis(cleanedDate);
    }

    @Override
    public boolean saveDailyData(DailyDataAnalysis data) {
        if (data == null || data.getSampleDate() == null) {
            return false;
        }

        // 1. Sanitize Date
        data.setSampleDate(cleanDate(data.getSampleDate()));

        // 2. Business Logic: Auto-calculate Purity for all lab materials
        data.setPjPurity(calculatePurity(data.getPjBrix(), data.getPjPole()));
        data.setMjPurity(calculatePurity(data.getMjBrix(), data.getMjPole()));
        data.setCjPurity(calculatePurity(data.getCjBrix(), data.getCjPole()));
        data.setFmPurity(calculatePurity(data.getFmBrix(), data.getFmPole()));

        return dao.saveDailyAnalysis(data);
    }

    @Override
    public boolean deleteDailyData(String sampleDate) {
        if (sampleDate == null || sampleDate.trim().isEmpty()) {
            return false;
        }
        return dao.deleteDailyAnalysis(cleanDate(sampleDate));
    }

    /**
     * NEW: Implementation for Cumulative Totals
     * Fetches Season-to-Date data for the Dashboard/Find view
     */
    @Override
    public Map<String, Object> getCumulativeTotals(String sampleDate, String seasonYear) {
        if (sampleDate == null || seasonYear == null) {
            return null;
        }
        // Note: You will need to add this method to your DailyAnalysisDAO as well
        return dao.getCumulativeTotals(cleanDate(sampleDate), seasonYear);
    }

    /**
     * Internal helper to calculate Purity percentage
     */
    private Double calculatePurity(Double brix, Double pol) {
        if (brix != null && pol != null && brix > 0) {
            double purity = (pol / brix) * 100;
            return Math.round(purity * 100.0) / 100.0;
        }
        return 0.0;
    }

    /**
     * Helper to strip T00:00:00.000Z from Angular Date strings
     */
    private String cleanDate(String dateStr) {
        if (dateStr != null && dateStr.contains("T")) {
            return dateStr.split("T")[0];
        }
        return dateStr;
    }
}