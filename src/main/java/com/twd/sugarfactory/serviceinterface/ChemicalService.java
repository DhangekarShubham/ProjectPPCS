package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.ChemicalConsumption;
import java.util.List;

public interface ChemicalService {

    /**
     * Fetches chemical data. 
     * If sampleDate is null/empty, returns a blank list from the Material Master.
     * If sampleDate is provided, returns saved consumption data for that date.
     */
    List<ChemicalConsumption> getChemicals(String sampleDate);

    /**
     * Saves or updates a list of chemical consumption records.
     * Typically implemented using a Batch Update or Transaction in the DAO.
     */
    boolean saveChemicals(List<ChemicalConsumption> chemicalList);

    /**
     * Deletes all chemical consumption records for a specific date.
     */
    boolean deleteChemicals(String sampleDate);
}