package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ChemicalConsumptionDAO;
import com.twd.sugarfactory.model.ChemicalConsumption;
import com.twd.sugarfactory.serviceinterface.ChemicalService;
import java.util.List;
import java.util.stream.Collectors;

public class ChemicalServiceImpl implements ChemicalService {

    private ChemicalConsumptionDAO dao = new ChemicalConsumptionDAO();

    @Override
    public List<ChemicalConsumption> getChemicals(String sampleDate) {
        // If date has a timestamp (from Angular), clean it first
        String cleanedDate = cleanDate(sampleDate);
        return dao.getChemicalList(cleanedDate);
    }

    @Override
    public boolean saveChemicals(List<ChemicalConsumption> chemicalList) {
        if (chemicalList == null || chemicalList.isEmpty()) {
            return false;
        }

        // 1. Data Sanitization: Filter out rows where no volume was entered
        // This keeps your 'material_stock_log' table clean.
        List<ChemicalConsumption> validList = chemicalList.stream()
            .filter(c -> c.getVolumeConsumed() != null && c.getVolumeConsumed() > 0)
            .peek(c -> c.setSampleDate(cleanDate(c.getSampleDate()))) // Ensure date is clean
            .collect(Collectors.toList());

        if (validList.isEmpty()) {
            // If all rows were 0 or empty, we don't need to hit the DB
            return true; 
        }

        return dao.saveConsumptionLog(validList);
    }
    
    @Override
    public boolean deleteChemicals(String sampleDate) {
        if(sampleDate == null || sampleDate.trim().isEmpty()) {
            return false;
        }
        return dao.deleteConsumptionLog(cleanDate(sampleDate));
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