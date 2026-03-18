package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.DailyDataAnalysis;
import java.util.Map;

public interface DailyAnalysisService {
    
    /**
     * Fetch a specific daily record by date.
     * Used by the "Find" button in AngularJS.
     */
    DailyDataAnalysis getDailyData(String sampleDate);

    /**
     * Save or update a daily record.
     * Includes business logic for purity calculations.
     */
    boolean saveDailyData(DailyDataAnalysis data);
    
    /**
     * Delete a record and its associated lab/time details.
     */
    boolean deleteDailyData(String sampleDate);

    /**
     * Optional: Fetch Cumulative (To-Date) totals for the dashboard.
     * Returns a Map of totals (Total Cane, Total Sugar, etc.) 
     * from the start of the season until the given date.
     */
    Map<String, Object> getCumulativeTotals(String sampleDate, String seasonYear);
    
}