package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyMfgSmall;

public interface ReportMfgSmallService {
    DailyMfgSmall generateReport(String reportDate);
}