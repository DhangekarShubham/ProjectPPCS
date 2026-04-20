package com.twd.sugarfactory.service;

import java.util.List;

import com.twd.sugarfactory.dao.StoppageDAO;
import com.twd.sugarfactory.model.StoppageLog;
import com.twd.sugarfactory.serviceinterface.StoppageService;

public class StoppageServiceImpl implements StoppageService {

    private StoppageDAO dao = new StoppageDAO();

    @Override
    public StoppageLog saveStoppageData(StoppageLog log) {
        return dao.saveNewStoppage(log);
    }

    @Override
    public StoppageLog getStoppageById(Integer stoppageId) {
        return dao.getStoppageById(stoppageId);
    }

    @Override
    public boolean deleteStoppageData(Integer stoppageId) {
        return dao.deleteStoppage(stoppageId);
    }

    @Override
    public List<StoppageLog> getStoppagesByDate(String stoppageDate) {
        // Optional (not implemented in DAO yet)
        return null;
    }
}