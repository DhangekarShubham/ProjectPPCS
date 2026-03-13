package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ReportDailyStockDAO;
import com.twd.sugarfactory.model.DailyStockReport;
import com.twd.sugarfactory.serviceinterface.ReportDailyStockService;
import java.util.List;

public class ReportDailyStockServiceImpl implements ReportDailyStockService {
    private ReportDailyStockDAO dao = new ReportDailyStockDAO();

    @Override
    public List<DailyStockReport> generateStockReport(String reportDate) {
        if(reportDate == null || reportDate.trim().isEmpty()) {
            return new java.util.ArrayList<>(); 
        }
        return dao.getStockReport(reportDate);
    }
}