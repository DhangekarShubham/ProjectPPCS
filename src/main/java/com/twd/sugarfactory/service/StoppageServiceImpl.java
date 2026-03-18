package com.twd.sugarfactory.service;

import java.util.List;

import com.twd.sugarfactory.dao.StoppageDAO;
import com.twd.sugarfactory.model.StoppageLog;
import com.twd.sugarfactory.serviceinterface.StoppageService;

public class StoppageServiceImpl implements StoppageService {
    private StoppageDAO dao = new StoppageDAO();

	@Override
	public StoppageLog saveStoppageData(StoppageLog log) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StoppageLog getStoppageData(Integer stoppageId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteStoppageData(Integer stoppageId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<StoppageLog> getStoppagesByDate(String stoppageDate) {
		// TODO Auto-generated method stub
		return null;
	}
}