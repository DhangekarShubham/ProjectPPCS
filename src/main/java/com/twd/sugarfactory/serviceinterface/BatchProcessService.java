package com.twd.sugarfactory.serviceinterface;


import com.twd.sugarfactory.model.BatchProcessRequest;

public interface BatchProcessService {
    boolean executeBatchProcess(BatchProcessRequest request);
}
