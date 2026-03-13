package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyMfgDetails;
import java.util.List;

public interface ReportMfgDetailsService {
    List<DailyMfgDetails> generateReport(String reportDate);
}