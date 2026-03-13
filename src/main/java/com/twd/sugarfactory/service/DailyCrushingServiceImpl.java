package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.DailyCrushingDAO;
import com.twd.sugarfactory.model.DailyCrushing;
import com.twd.sugarfactory.serviceinterface.DailyCrushingService;

public class DailyCrushingServiceImpl implements DailyCrushingService {
    private DailyCrushingDAO dao = new DailyCrushingDAO();

    @Override
    public DailyCrushing getCrushingData(String crushDate) {
        return dao.getCrushingData(crushDate);
    }

    @Override
    public boolean saveCrushingData(DailyCrushing data) {
        if (data.getCrushDate() == null || data.getCrushDate().trim().isEmpty()) return false;
        return dao.saveCrushingData(data);
    }
    
    @Override
    public boolean deleteCrushingData(String crushDate) {
        if (crushDate == null || crushDate.trim().isEmpty()) return false;
        return dao.deleteCrushingData(crushDate);
    }
}