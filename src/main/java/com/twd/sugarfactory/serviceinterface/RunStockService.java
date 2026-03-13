package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.RunStock;
import java.util.List;

public interface RunStockService {
    List<RunStock> getStockData(String sampleDate);
    boolean saveStockData(List<RunStock> stockList);
    boolean deleteStockData(String sampleDate);
}