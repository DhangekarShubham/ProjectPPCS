package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.StoppageLog;
import java.util.List;

/**
 * Service interface for managing downtime and factory stoppage logs.
 */
public interface StoppageService {

    /**
     * Saves a new stoppage log or updates an existing one.
     * Implementation should handle the logic to determine Save vs Update 
     * based on the presence of a Stoppage ID.
     * * @param log StoppageLog object from UI
     * @return The saved object including the generated ID
     */
    StoppageLog saveStoppageData(StoppageLog log);

    /**
     * Retrieves a specific downtime record by its ID.
     * @param stoppageId Primary key of the log
     * @return StoppageLog object
     */
    StoppageLog getStoppageById(Integer stoppageId);

    /**
     * Deletes a specific downtime log.
     * @param stoppageId Primary key to delete
     * @return true if successful
     */
    boolean deleteStoppageData(Integer stoppageId);

    /**
     * Fetches all stoppage logs for a specific date. 
     * Useful for daily summary reports.
     */
    List<StoppageLog> getStoppagesByDate(String stoppageDate);
}