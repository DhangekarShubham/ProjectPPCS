package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.ChemicalConsumptionDAO;
import com.twd.sugarfactory.model.ChemicalConsumption;
import com.twd.sugarfactory.serviceinterface.ChemicalService;
import java.util.List;

public class ChemicalServiceImpl implements ChemicalService {

    private ChemicalConsumptionDAO dao = new ChemicalConsumptionDAO();

    @Override
    public List<ChemicalConsumption> getChemicals(String sampleDate) {
        return dao.getChemicalList(sampleDate);
    }

    @Override
    public boolean saveChemicals(List<ChemicalConsumption> chemicalList) {
        if (chemicalList == null || chemicalList.isEmpty()) {
            return false;
        }
        return dao.saveConsumptionLog(chemicalList);
    }
    
    @Override
    public boolean deleteChemicals(String sampleDate) {
        if(sampleDate == null || sampleDate.trim().isEmpty()) {
            return false;
        }
        return dao.deleteConsumptionLog(sampleDate);
    }
}