package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.RunStockDAO;
import com.twd.sugarfactory.model.RunStock;
import com.twd.sugarfactory.serviceinterface.RunStockService;
import java.util.List;

public class RunStockServiceImpl implements RunStockService {
    private RunStockDAO dao = new RunStockDAO();

    @Override
    public List<RunStock> getStockData(String sampleDate) {
        return dao.getRunStockList(sampleDate);
    }

    @Override
    public boolean saveStockData(List<RunStock> stockList) {
        if (stockList == null || stockList.isEmpty()) return false;
        return dao.saveRunStockLog(stockList);
    }
    
    @Override
    public boolean deleteStockData(String sampleDate) {
        if (sampleDate == null || sampleDate.trim().isEmpty()) return false;
        return dao.deleteRunStockLog(sampleDate);
    }
}