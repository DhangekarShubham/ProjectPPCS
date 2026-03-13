package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyMfgShort;

public interface ReportMfgShortService {
    DailyMfgShort generateReport(String reportDate);
}