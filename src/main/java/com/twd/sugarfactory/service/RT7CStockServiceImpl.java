package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.RT7CStockDAO;
import com.twd.sugarfactory.model.RT7CStock;
import com.twd.sugarfactory.serviceinterface.RT7CStockService;
import java.util.List;

public class RT7CStockServiceImpl implements RT7CStockService {
    private RT7CStockDAO dao = new RT7CStockDAO();

    @Override
    public List<RT7CStock> getStockData(String stockDate) {
        return dao.getRT7CStockList(stockDate);
    }

    @Override
    public boolean saveStockData(List<RT7CStock> stockList) {
        if (stockList == null || stockList.isEmpty()) return false;
        return dao.saveRT7CStockLog(stockList);
    }
    
    @Override
    public boolean deleteStockData(String stockDate) {
        if(stockDate == null || stockDate.trim().isEmpty()) return false;
        return dao.deleteRT7CStockLog(stockDate);
    }
}