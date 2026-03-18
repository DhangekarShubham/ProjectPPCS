package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.DailyCrushingDAO;
import com.twd.sugarfactory.model.DailyCrushing;
import com.twd.sugarfactory.serviceinterface.DailyCrushingService;

public class DailyCrushingServiceImpl implements DailyCrushingService {
    
    private DailyCrushingDAO dao = new DailyCrushingDAO();

    @Override
    public DailyCrushing getCrushingData(String crushDate) {
        if (crushDate == null || crushDate.trim().isEmpty()) {
            return null;
        }
        return dao.getCrushingData(crushDate);
    }

    @Override
    public boolean saveCrushingData(DailyCrushing data) {
        // FIX: Removed .trim().isEmpty() because getCrushDate() is now a java.util.Date
        if (data == null || data.getCrushDate() == null) {
            System.out.println("Validation Error: Crushing Date is missing.");
            return false;
        }
        
        // Optional: Add validation for your required fields
        if (data.getCropDay() <= 0) {
            System.out.println("Validation Error: Crop Day must be greater than 0.");
            return false;
        }

        return dao.saveCrushingData(data);
    }
    
    @Override
    public boolean deleteCrushingData(String crushDate) {
        if (crushDate == null || crushDate.trim().isEmpty()) {
            return false;
        }
        return dao.deleteCrushingData(crushDate);
    }
}