package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyStockReport;
import java.util.List;

public interface ReportDailyStockService {
    List<DailyStockReport> generateStockReport(String reportDate);
}