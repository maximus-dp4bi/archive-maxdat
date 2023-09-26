package com.maximus.amp.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.maximus.amp.dao.GenericDao;
import com.maximus.amp.dao.LookupDao;
import com.maximus.amp.model.LabelValue;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.MetricType;
import com.maximus.amp.model.Program;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.ReportingPeriod.ReportingPeriodType;
import com.maximus.amp.model.Role;
import com.maximus.amp.model.User;
import com.maximus.amp.service.LookupManager;


/**
 * Implementation of LookupManager interface to talk to the persistence layer.
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
@Service("lookupManager")
public class LookupManagerImpl implements LookupManager {

	@Autowired
    private LookupDao dao;
    
    @Autowired
    @Qualifier(value="reportingPeriodDao")
    private GenericDao<ReportingPeriod, Long> reportingPeriodDao;

    @Autowired
    @Qualifier(value="metricProjectDao")
    private GenericDao<MetricProject, Long> metricProjectDao;

    @Autowired
    @Qualifier(value="metricDefinitionDao")
    private GenericDao<MetricDefinition, Long> metricDefinitionDao;
    
    private Map<String, List<ReportingPeriod>> reportingPeriodMap = null;
        
    @Override
	public List<MetricDefinition> getActiveMetricDefinitions() {
		HashMap<String, Object> queryParams = new HashMap<String, Object>();
		queryParams.put("functionalArea", null);
		return metricDefinitionDao.findByNamedQuery("getActiveMetricDefinitions", queryParams);
	}
    
    @Override
	public List<MetricDefinition> getActiveMetricDefinitions(String functionalArea) {
		HashMap<String, Object> queryParams = new HashMap<String, Object>();
		queryParams.put("functionalArea", functionalArea);
		return metricDefinitionDao.findByNamedQuery("getActiveMetricDefinitions", queryParams);
	}

	@Override
	public <T> List<T> getAllOfType(Class<T> clazz){
		return dao.getAllOfType(clazz);
	}
	
	@Override
	public <T> List<T> getAllOfTypeSorted(Class<T> clazz, String sortedBy) {
		return dao.getAllOfTypeSorted(clazz, sortedBy);
	}
	
	/**
     * {@inheritDoc}
     */
    public List<LabelValue> getApplicationRoles() {
        List<Role> roles = dao.getRoles("APPLICATION");
        List<LabelValue> list = new ArrayList<LabelValue>();

        for (Role role1 : roles) {
            list.add(new LabelValue(role1.getName(), role1.getName()));
        }

        return list;
    }
	
	@Override
	public List<String> getDistinctFunctionalAreas() {
		return dao.getDistinctFunctionalAreas();
	}

	
	@Override
	public List<String> getDistinctFunctionalAreas(String projectId, User user) {
		return dao.getDistinctFunctionalAreas(projectId, user);
	}

	@Override
	public List<MetricDefinition> getMetricDefinitionsSortedByFuncAreaAndName() {
		return metricDefinitionDao.findByNamedQuery("getMetricDefinitionsSortedByFuncAreaAndName", null);
	}

	@Override
	public List<MetricProject> getMetricProjects(Project project) {
		HashMap<String, Object> queryParams = new HashMap<String, Object>();
		queryParams.put("project", project);
		
		return metricProjectDao.findByNamedQuery("getAllMetricsForProject", queryParams);
	}

	@Override
	public List<MetricDefinition> getNewMetricDefinitions(Long projectId, Long programId, Long geographyMasterId) {
		
		HashMap<String, Object> queryParams = new HashMap<String, Object>();
		queryParams.put("projectId", projectId);
		queryParams.put("programId", programId);
		queryParams.put("geographyMasterId", geographyMasterId);
		
		return metricDefinitionDao.findByNamedQuery("getNewMetricDefinitions", queryParams);
	}

	public <T, PK extends Serializable> T getOneOfTypeById(Class<T> clazz, PK id) {
		
		return dao.getOneOfTypeById(clazz, id);
	}

	@Override
	public ReportingPeriod getPriorReportingPeriod(ProjectReport projectReport) {
		
		if(reportingPeriodMap == null){
	    	setReportingPeriodMap(getSortedReportingPeriodMap());
		}
		ReportingPeriod reportingPeriod = null;
		String type = projectReport.getReportingPeriod().getType();
		
		// if doing lookup during AJAX post
		// TODO:  review for performance implications;
		if(type==null) {
			reportingPeriod = dao.getOneOfTypeById(ReportingPeriod.class, projectReport.getReportingPeriod().getId());
			type=reportingPeriod.getType();
		} else {
			reportingPeriod = projectReport.getReportingPeriod();
		}
		
		List<ReportingPeriod> reportingPeriodList = reportingPeriodMap.get(type);
		
		int index = reportingPeriodList.indexOf(reportingPeriod);
		
		// if index <= 0, then the reporting period doesn't exist 
		// or is the first in the list and has no prior 
		if(index <= 0) { return null; }
		
		ReportingPeriod priorReportingPeriod = reportingPeriodList.get(index-1);
		
		return priorReportingPeriod;
		
	}

	@Override
	public List<Role> getProjectRoles() {
		List<Role> roles = dao.getRoles("PROJECT");

        return roles;
	}

	@Override
	public Map<String, String> getReportingPeriodTypeMap() {
		Map<String, String> map = new HashMap<String,String>();
		
		for(ReportingPeriodType rpt : ReportingPeriod.ReportingPeriodType.values()) {
			map.put(rpt.getValue(), rpt.getLabel());
		}
		
		return map;
	}

	private Map<String, List<ReportingPeriod>> getSortedReportingPeriodMap() {

		List<ReportingPeriod> weeklyReportingPeriods = dao.getReportingPeriodsByType(ReportingPeriodType.WEEKLY.getValue());
		List<ReportingPeriod> monthlyReportingPeriods = dao.getReportingPeriodsByType(ReportingPeriodType.MONTHLY.getValue());
		
		Map<String, List<ReportingPeriod>> map = new HashMap<String, List<ReportingPeriod>>();
		
		map.put(ReportingPeriodType.WEEKLY.getValue(), weeklyReportingPeriods);
		map.put(ReportingPeriodType.MONTHLY.getValue(), monthlyReportingPeriods);
		
		return map;
	}

	public void setLookupDao(LookupDao lookupDao) {
		this.dao = lookupDao;
	}

	public void setReportingPeriodMap(
			Map<String, List<ReportingPeriod>> reportingPeriodMap) {
		this.reportingPeriodMap = reportingPeriodMap;
	}
	
	
	
}

