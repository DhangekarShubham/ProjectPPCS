package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.RT8CPerformance;

public interface RT8CService {
    RT8CPerformance getRT8CData(String reportDate);
    boolean saveRT8CData(RT8CPerformance data);
    boolean deleteRT8CData(String reportDate);
}