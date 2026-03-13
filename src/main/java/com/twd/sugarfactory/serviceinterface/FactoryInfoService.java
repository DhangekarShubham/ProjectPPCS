package com.twd.sugarfactory.serviceinterface;


import com.twd.sugarfactory.model.FactoryInfo;

public interface FactoryInfoService {
    boolean saveFactoryInfo(FactoryInfo info);
    FactoryInfo getFactoryInfo(String seasonYear);
    boolean updateFactoryInfo(FactoryInfo info);
    boolean deleteFactoryInfo(String seasonYear);
}
