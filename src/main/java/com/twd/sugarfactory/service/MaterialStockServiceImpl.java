package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.MaterialStockDAO;
import com.twd.sugarfactory.model.MaterialStock;
import com.twd.sugarfactory.serviceinterface.MaterialStockService;
import java.util.List;
import java.util.stream.Collectors;

public class MaterialStockServiceImpl implements MaterialStockService {
    
    private MaterialStockDAO dao = new MaterialStockDAO();

    @Override
    public List<MaterialStock> getStockData(String sampleDate) {
        // Clean the date (remove T00:00:00Z) before sending to DAO
        String cleanedDate = cleanDate(sampleDate);
        return dao.getStockList(cleanedDate);
    }

    @Override
    public boolean saveStockData(List<MaterialStock> stockList) {
        if (stockList == null || stockList.isEmpty()) {
            return false;
        }

        // 1. Data Sanitization: Filter out items where both Quantity and Volume are null/zero.
        // This keeps your 'material_stock_log' table lean and clean.
        List<MaterialStock> validStock = stockList.stream()
            .filter(item -> (item.getQuantity() != null && item.getQuantity() > 0) || 
                            (item.getVolume() != null && item.getVolume() > 0))
            .peek(item -> item.setSampleDate(cleanDate(item.getSampleDate()))) // Ensure date is clean
            .collect(Collectors.toList());

        if (validStock.isEmpty()) {
            // If the user didn't enter any values, we don't need to hit the DB
            return true; 
        }

        return dao.saveStockLog(validStock);
    }
    
    @Override
    public boolean deleteStockData(String sampleDate) {
        if(sampleDate == null || sampleDate.trim().isEmpty()) {
            return false;
        }
        return dao.deleteStockLog(cleanDate(sampleDate));
    }

    /**
     * Helper to strip ISO timestamps (e.g., 2026-03-18T00:00:00.000Z) 
     * down to database-friendly YYYY-MM-DD.
     */
    private String cleanDate(String dateStr) {
        if (dateStr != null && dateStr.contains("T")) {
            return dateStr.split("T")[0];
        }
        return dateStr;
    }
}