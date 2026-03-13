package com.twd.sugarfactory.service;


import com.twd.sugarfactory.dao.BatchProcessDAO;
import com.twd.sugarfactory.model.BatchProcessRequest;
import com.twd.sugarfactory.serviceinterface.BatchProcessService;

public class BatchProcessServiceImpl implements BatchProcessService {

    private BatchProcessDAO dao = new BatchProcessDAO();

    @Override
    public boolean executeBatchProcess(BatchProcessRequest request) {
        String module = request.getProcessModule();
        String fromDate = request.getFromDate();
        String toDate = request.getToDate();

        boolean success = true;

        if ("ALL".equals(module) || "CRUSHING".equals(module)) {
            success = success && dao.processCrushingData(fromDate, toDate);
        }
        
        if ("ALL".equals(module) || "STOCK".equals(module)) {
            success = success && dao.processStockData(fromDate, toDate);
        }

        if ("ALL".equals(module) || "LOSSES".equals(module)) {
            success = success && dao.processLossesData(fromDate, toDate);
        }

        return success;
    }
}
