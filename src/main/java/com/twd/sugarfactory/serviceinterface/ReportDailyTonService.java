package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyTonReport;

public interface ReportDailyTonService {
    DailyTonReport generateTonReport(String reportDate);
}