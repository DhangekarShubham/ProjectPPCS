package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.MaterialStock;
import java.util.List;

public interface MaterialStockService {
    List<MaterialStock> getStockData(String sampleDate);
    boolean saveStockData(List<MaterialStock> stockList);
    boolean deleteStockData(String sampleDate);
}