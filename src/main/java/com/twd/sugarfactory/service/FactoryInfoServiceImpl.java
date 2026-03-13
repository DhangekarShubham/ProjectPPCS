package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.FactoryInfoDAO;
import com.twd.sugarfactory.model.FactoryInfo;
import com.twd.sugarfactory.serviceinterface.FactoryInfoService;

public class FactoryInfoServiceImpl implements FactoryInfoService {
    
    private FactoryInfoDAO dao = new FactoryInfoDAO();

    @Override
    public boolean saveFactoryInfo(FactoryInfo info) {
        // Business logic: Ensure Season Year is not null before saving
        if(info.getSeasonYear() == null || info.getSeasonYear().trim().isEmpty()) {
            return false;
        }
        return dao.save(info);
    }

    @Override
    public FactoryInfo getFactoryInfo(String seasonYear) {
        return dao.findBySeasonYear(seasonYear);
    }

    @Override
    public boolean updateFactoryInfo(FactoryInfo info) {
        return dao.update(info);
    }

    @Override
    public boolean deleteFactoryInfo(String seasonYear) {
        return dao.delete(seasonYear);
    }
}