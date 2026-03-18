package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.MaterialStock;
import java.util.List;

public interface MaterialStockService {

    /**
     * Fetches stock data. 
     * If sampleDate is null/empty: returns a blank list from Material Master.
     * If sampleDate is provided: returns saved quantities from the daily log.
     */
    List<MaterialStock> getStockData(String sampleDate);

    /**
     * Saves or updates a list of material stock records.
     * Implementation should handle this in a single transaction for data integrity.
     */
    boolean saveStockData(List<MaterialStock> stockList);

    /**
     * Deletes all stock records for a specific date.
     */
    boolean deleteStockData(String sampleDate);
}