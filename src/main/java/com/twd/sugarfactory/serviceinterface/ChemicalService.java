package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.ChemicalConsumption;
import java.util.List;

public interface ChemicalService {
    List<ChemicalConsumption> getChemicals(String sampleDate);
    boolean saveChemicals(List<ChemicalConsumption> chemicalList);
    boolean deleteChemicals(String sampleDate);
}