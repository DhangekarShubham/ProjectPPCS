package com.twd.sugarfactory.serviceinterface;
import com.twd.sugarfactory.model.DailyCrushing;

public interface DailyCrushingService {
    DailyCrushing getCrushingData(String crushDate);
    boolean saveCrushingData(DailyCrushing data);
    boolean deleteCrushingData(String crushDate);
}