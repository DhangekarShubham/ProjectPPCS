package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.RT8CDAO;
import com.twd.sugarfactory.model.RT8CPerformance;
import com.twd.sugarfactory.serviceinterface.RT8CService;

public class RT8CServiceImpl implements RT8CService {
    private RT8CDAO dao = new RT8CDAO();

    @Override
    public RT8CPerformance getRT8CData(String seasonYear) {
        return dao.getPerformanceData(seasonYear);
    }

    @Override
    public boolean saveRT8CData(RT8CPerformance data) {
        if (data.getSeasonYear() == null || data.getSeasonYear().trim().isEmpty()) return false;
        return dao.savePerformanceData(data);
    }
    
    @Override
    public boolean deleteRT8CData(String seasonYear) {
        if (seasonYear == null || seasonYear.trim().isEmpty()) return false;
        return dao.deletePerformanceData(seasonYear);
    }
}