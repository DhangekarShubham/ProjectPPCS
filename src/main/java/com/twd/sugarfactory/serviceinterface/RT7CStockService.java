package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.RT7CStock;
import java.util.List;

public interface RT7CStockService {
    List<RT7CStock> getStockData(String stockDate);
    boolean saveStockData(List<RT7CStock> stockList);
    boolean deleteStockData(String stockDate);
}