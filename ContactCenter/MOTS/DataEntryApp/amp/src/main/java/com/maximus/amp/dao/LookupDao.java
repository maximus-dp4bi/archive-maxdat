package com.maximus.amp.dao;

import java.io.Serializable;
import java.util.List;

import com.maximus.amp.model.GeographyMaster;
import com.maximus.amp.model.MetricType;
import com.maximus.amp.model.Program;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.Role;
import com.maximus.amp.model.User;

/**
 * Lookup Data Access Object (GenericDao) interface.  This is used to lookup values in
 * the database (i.e. for drop-downs).
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public interface LookupDao {
    //~ Methods ================================================================

    /**
     * Returns all Roles ordered by name
     * @return populated list of roles
     */
    List<Role> getRoles(String type);
    
    public <T> List<T> getAllOfType(Class<T> clazz);
    
    public <T> List<T> getAllOfTypeSorted(Class<T> clazz, String sortBy);
    
    public <T, PK extends Serializable> T getOneOfTypeById(Class<T> clazz, PK id);
    
    public List<ReportingPeriod> getReportingPeriodsByType(String type);
    
    public List<String> getDistinctFunctionalAreas();

	List<String> getDistinctFunctionalAreas(String projectId, User user);
    
}
