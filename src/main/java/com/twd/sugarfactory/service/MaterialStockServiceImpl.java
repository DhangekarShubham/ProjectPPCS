package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.MaterialStockDAO;
import com.twd.sugarfactory.model.MaterialStock;
import com.twd.sugarfactory.serviceinterface.MaterialStockService;
import java.util.List;

public class MaterialStockServiceImpl implements MaterialStockService {
    private MaterialStockDAO dao = new MaterialStockDAO();

    @Override
    public List<MaterialStock> getStockData(String sampleDate) {
        return dao.getStockList(sampleDate);
    }

    @Override
    public boolean saveStockData(List<MaterialStock> stockList) {
        if (stockList == null || stockList.isEmpty()) return false;
        return dao.saveStockLog(stockList);
    }
    
    @Override
    public boolean deleteStockData(String sampleDate) {
        if(sampleDate == null || sampleDate.trim().isEmpty()) return false;
        return dao.deleteStockLog(sampleDate);
    }
}