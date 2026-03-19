package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.RT8CPerformance;

public interface RT8CService {
    RT8CPerformance getRT8CData(String seasonYear);
    boolean saveRT8CData(RT8CPerformance data);
    boolean deleteRT8CData(String seasonYear);
}