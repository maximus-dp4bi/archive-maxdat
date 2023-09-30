package com.maximus.amp.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.maximus.amp.model.LabelValue;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.MetricType;
import com.maximus.amp.model.Program;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.Role;
import com.maximus.amp.model.User;

/**
 * Business Service Interface to talk to persistence layer and
 * retrieve values for drop-down choice lists.
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public interface LookupManager {
	
	List<MetricDefinition> getActiveMetricDefinitions();
	
	List<MetricDefinition> getActiveMetricDefinitions(String functionalArea);
	
    /**
     * Retrieves all possible metric types from persistence layer
     * @return List of MetricType objects
     */
    // TODO:  refactor references to use getAllOfType
    
    public <T> List<T> getAllOfType(Class<T> clazz);

    public <T> List<T> getAllOfTypeSorted(Class<T> clazz, String sortedBy);
    
	/**
     * Retrieves all possible roles from persistence layer
     * @return List of LabelValue objects
     */
    List<LabelValue> getApplicationRoles();

	public List<String> getDistinctFunctionalAreas();

	List<String> getDistinctFunctionalAreas(String projectId, User user);
	
	public List<MetricDefinition> getMetricDefinitionsSortedByFuncAreaAndName();

	public List<MetricProject> getMetricProjects(Project project);
	
	public List<MetricDefinition> getNewMetricDefinitions(Long projectId, Long programId, Long geographyMasterId);
	
	public <T, PK extends Serializable> T getOneOfTypeById(Class<T> clazz, PK id);
	
	public ReportingPeriod getPriorReportingPeriod(ProjectReport projectReport);
	
	public List<Role> getProjectRoles();

	Map<String, String> getReportingPeriodTypeMap();
    
}
