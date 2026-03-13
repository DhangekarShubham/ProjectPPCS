package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.StoppageLog;

public interface StoppageService {
    StoppageLog saveStoppageData(StoppageLog log);
    StoppageLog getStoppageData(Integer stoppageId);
    boolean deleteStoppageData(Integer stoppageId);
}