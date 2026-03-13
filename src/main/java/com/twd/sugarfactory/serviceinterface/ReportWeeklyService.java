package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.WeeklyReport;

public interface ReportWeeklyService {
    WeeklyReport generateWeeklyReport(Integer weekNo, String fromDate, String toDate);
}