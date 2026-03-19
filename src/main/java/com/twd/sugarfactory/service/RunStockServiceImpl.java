package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.RunStockDAO;
import com.twd.sugarfactory.model.RunStock;
import com.twd.sugarfactory.serviceinterface.RunStockService;
import java.util.List;

public class RunStockServiceImpl implements RunStockService {
    private RunStockDAO dao = new RunStockDAO();

    @Override
    public List<RunStock> getStockData(String seasonYear, String runNumber) {
        return dao.getStockData(seasonYear, runNumber);
    }

    @Override
    public boolean saveStockData(List<RunStock> stockList) {
        if (stockList == null || stockList.isEmpty()) return false;
        return dao.saveStockData(stockList);
    }
    
    @Override
    public boolean deleteStockData(String seasonYear, String runNumber) {
        if (seasonYear == null || runNumber == null) return false;
        return dao.deleteStockData(seasonYear, runNumber);
    }
}