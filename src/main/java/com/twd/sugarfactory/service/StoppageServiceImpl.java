package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.StoppageDAO;
import com.twd.sugarfactory.model.StoppageLog;
import com.twd.sugarfactory.serviceinterface.StoppageService;

public class StoppageServiceImpl implements StoppageService {
    private StoppageDAO dao = new StoppageDAO();

    @Override
    public StoppageLog saveStoppageData(StoppageLog log) {
        if (log.getStoppageDate() == null || log.getTotalTime() == null) {
            return null; // Basic validation
        }
        boolean success = dao.saveStoppage(log);
        return success ? log : null; // Returns object with new ID if successful
    }

    @Override
    public StoppageLog getStoppageData(Integer stoppageId) {
        return dao.findStoppageById(stoppageId);
    }
    
    @Override
    public boolean deleteStoppageData(Integer stoppageId) {
        return dao.deleteStoppage(stoppageId);
    }
}