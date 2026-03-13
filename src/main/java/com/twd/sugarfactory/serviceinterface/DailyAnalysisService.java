package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyDataAnalysis;

public interface DailyAnalysisService {
    boolean saveDailyData(DailyDataAnalysis data);
}