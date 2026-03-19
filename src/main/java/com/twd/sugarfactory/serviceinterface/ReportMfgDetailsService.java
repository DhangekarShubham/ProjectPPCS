package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.MfgReportDTO;

public interface ReportMfgDetailsService {
    MfgReportDTO generateReport(String reportDate);
}