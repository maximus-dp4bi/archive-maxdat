package com.maximus.amp.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.maximus.amp.Constants;
import com.maximus.amp.dao.GenericDao;
import com.maximus.amp.dao.ProjectReportDao;
import com.maximus.amp.dao.UserDao;
import com.maximus.amp.model.ActualsReport;
import com.maximus.amp.model.ForecastsReport;
import com.maximus.amp.model.Metric;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ProjectReport.ReportType;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.User;
import com.maximus.amp.service.LookupManager;
import com.maximus.amp.service.ProjectReportManager;

@Service("projectReportManager")
public class ProjectReportManagerImpl extends GenericManagerImpl<ProjectReport, Long> implements ProjectReportManager {

	private static final int RED = 1;
	private static final int YELLOW = 2;
	private static final int GREEN = 3;

	private UserDao userDao;
	
	private GenericDao<MetricProject, Long> metricProjectDao;
	
	private ProjectReportDao projectReportDao;
	
	private GenericDao<ReportingPeriod, Long> reportingPeriodDao;

	private GenericDao<Metric, Long> metricDao;

	private LookupManager lookupManager;
	
	@Autowired
	public ProjectReportManagerImpl(ProjectReportDao projectReportDao) {
		super(projectReportDao);
		this.projectReportDao = projectReportDao;
	}

	@Override
	public void approve(ProjectReport projectReport) {
		projectReportDao.approve(projectReport);
	}

	private void calculateActualForecastVariance(Metric metric) {
		
		long varianceFormat = 0;
		
		if(metric.getForecastValue() != null && metric.getActualValue() != null) {
		
			Float forecastValue = metric.getForecastValue().floatValue();
			Float actualValue = metric.getActualValue().floatValue();
			
			float absPctVar = Math.abs(1F - (forecastValue/actualValue));

			if (absPctVar <= 0.05) { varianceFormat = GREEN; }
			else if(absPctVar <= 0.25) { varianceFormat = YELLOW; }
			else { varianceFormat = RED; }
		}
		
		metric.setActualForecastVarianceFormat(varianceFormat);
	}
	
	@Override
	public List<ReportingPeriod> getAvailableReportingPeriods(
			String functionalArea, String reportingPeriodType, String projectId,
			String programId, String geographyMasterId, 
			String reportType, String reportingPeriodYear) {
		
		HashMap<String, Object> queryParams = new HashMap<String, Object>();
		queryParams.put("functionalArea", functionalArea);
		queryParams.put("reportingPeriodType", reportingPeriodType);
		queryParams.put("projectId", Long.parseLong(projectId));
        queryParams.put("programId", Long.parseLong(programId));
        queryParams.put("geographyMasterId", Long.parseLong(geographyMasterId));
        queryParams.put("reportType", reportType);
        queryParams.put("reportingPeriodYear", Integer.parseInt(reportingPeriodYear));
		
        if(reportType.equals(ReportType.ACTUALS.toString())) {
        	return reportingPeriodDao.findByNamedQuery("getAvailableActualsReportingPeriods", queryParams);	
        } else if (reportType.equals(ReportType.FORECASTS.toString())) {
        	return reportingPeriodDao.findByNamedQuery("getAvailableForecastsReportingPeriods", queryParams);
        }
        
        return null;
		
	}

	private Metric getMetric(MetricDefinition metricDefinition, ProjectReport projectReport) {

		HashMap<String, Object> queryParams = new HashMap<String, Object>();
        queryParams.put("projectId", projectReport.getProject().getId());
        queryParams.put("programId", projectReport.getProgram().getId());
        queryParams.put("geographyMasterId", projectReport.getGeographyMaster().getId());
        queryParams.put("metricDefinitionId", metricDefinition.getId());
        queryParams.put("reportingPeriodEndDate", projectReport.getReportingPeriod().getEndDate());
        queryParams.put("reportingPeriodType", projectReport.getReportingPeriod().getType());
        
        List<Metric> metricList = null;
		
		if(projectReport instanceof ActualsReport){
			 metricList = metricDao.findByNamedQuery("getMetricByForecastsReport", queryParams);	
		} else {
			metricList = metricDao.findByNamedQuery("getMetricByActualsReport", queryParams);
		}

        if (metricList.size() == 1) {
        	return metricList.get(0); 
        } else if(metricList.size() == 0)  {
        	return null;
        } else {
        	throw new Error("Only one metric should exist for a given metric project and project report combo.");
        }
	}
	
	@Override
	public List<MetricProject> getMetricProjectsForReport(ProjectReport projectReport) {
		
		String isWeekly = null; 
		String isMonthly = null;
		
		if(projectReport.getReportingPeriod().getType().equals(ReportingPeriod.ReportingPeriodType.WEEKLY.getValue())) {
			isWeekly = Constants.Y;
		} else if (projectReport.getReportingPeriod().getType().equals(ReportingPeriod.ReportingPeriodType.MONTHLY.getValue())) {
			isMonthly = Constants.Y;
		}
		
        HashMap<String, Object> queryParams = new HashMap<String, Object>();
        queryParams.put("functionalArea", projectReport.getFunctionalArea());
        queryParams.put("projectId", projectReport.getProject().getId());
        queryParams.put("programId", projectReport.getProgram().getId());
        queryParams.put("geographyMasterId", projectReport.getGeographyMaster().getId());
        queryParams.put("isWeekly", isWeekly);
        queryParams.put("isMonthly", isMonthly);
        queryParams.put("reportingPeriodEndDate", projectReport.getReportingPeriod().getEndDate());
        
        
        log.debug("getMetricsForReport");
        List<MetricProject> metricProjectList = null;
        
        if(projectReport instanceof ActualsReport) {
        	metricProjectList = metricProjectDao.findByNamedQuery("getMetricsForActualsReport", queryParams);
        } else {
        	metricProjectList = metricProjectDao.findByNamedQuery("getMetricsForForecastReport", queryParams);
        }
        
		return metricProjectList;
	}

	@Override
	public ProjectReport getPriorProjectReport(ProjectReport projectReport, String type) {
		
		ProjectReport priorProjectReport = null;
		
		ReportingPeriod priorReportingPeriod = lookupManager.getPriorReportingPeriod(projectReport);
		
		if(priorReportingPeriod == null) { return null; }
		
        HashMap<String, Object> queryParams = new HashMap<String, Object>();
        queryParams.put("functionalArea", projectReport.getFunctionalArea());
        queryParams.put("projectId", projectReport.getProject().getId());
        queryParams.put("programId", projectReport.getProgram().getId());
        queryParams.put("geographyMasterId", projectReport.getGeographyMaster().getId());
        queryParams.put("type", type);
        queryParams.put("endDate", priorReportingPeriod.getEndDate());
        
		
        List<ProjectReport> projectReportList = projectReportDao.findByNamedQuery("getProjectReportByCriteria", queryParams);
        
        if(projectReportList != null && projectReportList.size() > 0) {
        	priorProjectReport = projectReportList.get(0);
        }
        
		return priorProjectReport;
	}

	@Override
	public Project getProjectById(String projectId) {
		
		return lookupManager.getOneOfTypeById(Project.class, Long.parseLong(projectId));
//		return projectDao.get(Long.parseLong(projectId));
	}
	
	@Override
	public List<ProjectReport> getProjectReportsByUserDetails(UserDetails userDetails, String type) {

		User user = (User) userDao.loadUserByUsername(userDetails.getUsername());
		HashMap<String, Object> queryParams = new HashMap<String, Object>();
//        queryParams.put("user", user);
//        queryParams.put("type", type);
	      queryParams.put("userId", user.getId());
	      queryParams.put("reportType", type);

//        List<ProjectReport> projectReportList = projectReportDao.findByNamedQuery("getProjectReportsByUser", queryParams);
	    
	      List<ProjectReport> projectReportList = projectReportDao.findByNamedQuery("nativeGetProjectReportsByUser", queryParams);
        
		return projectReportList;
	}

	@Override
	public ProjectReport initializeMetrics(ProjectReport projectReport) {
		
		log.debug("initializing metrics - start");
		
		List<MetricProject> metricProjectList = getMetricProjectsForReport(projectReport);
		
		projectReport = initializeMetrics(projectReport, metricProjectList); 
		
		return projectReport;
	}

	@Override
	public ProjectReport initializeMetrics(ProjectReport projectReport, List<MetricProject> metricProjectList) {
		
		log.debug(metricProjectList.size());
		
		//  loop through all of the metricProject records and add to the project report if necessary
		for (MetricProject metricProject : metricProjectList) {
			MetricDefinition metricDefinition = metricProject.getMetricDefinition();
			
			//  if the metric is already on the report, skip to the next metric
			if(projectReport.getMetricByDef(metricDefinition) != null) { continue; }
			
			//  otherwise, see if the metric has been initialized on the 
			//  associated actuals or forecast report for the same period
			Metric metric = getMetric(metricDefinition, projectReport);
			
			//  if the metric does not already exist, create a new one
			if(metric == null) {
				
				log.debug("saving new metric");
				
				Metric newMetric = metricDao.save(new Metric(projectReport, metricDefinition));
				projectReport.getMetrics().put(metricProject.getMetricDefinition().getId(), newMetric);
				
			} else {
				
				//  if the metric already exists, then add it to the current report based on the report type
				if(projectReport.getType().equals(ProjectReport.ReportType.ACTUALS.toString())) {
					
					ActualsReport actualsReport = (ActualsReport) projectReport;
					
					// if(metric.getActualsReport().equals(actualsReport)) { continue; }
					
					log.debug("updating actuals metric");
					
					
					actualsReport.getMetrics().put(metricProject.getMetricDefinition().getId(), metric);
					metric.setActualsReport(actualsReport);
					metricDao.save(metric);
					
				} else if (projectReport.getType().equals(ProjectReport.ReportType.FORECASTS.toString())) {
					
					ForecastsReport forecastsReport = (ForecastsReport) projectReport;
					
					// if(metric.getActualsReport().equals(forecastsReport)) { continue; }
					
					log.debug("updating forecast metric");
					
					forecastsReport.getMetrics().put(metricProject.getMetricDefinition().getId(), metric);
					metric.setForecastsReport(forecastsReport);
					metricDao.save(metric);
				}
			}
		}
		
		log.debug("initializing metrics - end");
		
		return projectReport;
		
	}
	
	
    public void remove(ProjectReport projectReport) {
        
    	//  loop through the associated metrics  
    	for(Metric metric : projectReport.getMetrics().values()) {
    		
    		if(projectReport instanceof ActualsReport) { 
    			if(metric.getForecastsReport() == null) {
        			//  if an actuals report is being deleted and the metric 
        			//  is not associated with a forecast report, delete the metric
    				metricDao.remove(metric);
    			} else {
    				//  otherwise set the actual value and actualsReport to null
	    			metric.setActualValue(null);
	    			metric.setActualsReport(null);
    			}
    		}
    		else {
    			if(metric.getActualsReport() == null) {
        			//  if a forecasts report is being deleted and the metric 
        			//  is not associated with an actuals report, delete the metric
    				metricDao.remove(metric);
    			} else {
    				//  otherwise set the forecast value and forecastsReport to null
	    			metric.setForecastValue(null);
	    			metric.setForecastsReport(null);
    			}
    		}
    	}
    	
    	remove(projectReport.getId());
    }

	public ProjectReport save(ProjectReport projectReport) {
		
		for(Long key : projectReport.getMetrics().keySet()) {
			Metric metric = projectReport.getMetrics().get(key);

			if(projectReport instanceof ActualsReport) {		
				if(metric.getActualValue() != null) {
					// TODO:  assess whether this should be calculated on approval
					calculateActualForecastVariance(metric);
					if(metric.getActualReceivedDate() != null) { metric.setActualReceivedDate(new Date()); }					

				}
			} else if(projectReport instanceof ForecastsReport) {
				if(metric.getForecastValue() != null) {
					// TODO:  assess whether this should be calculated on approval
					calculateActualForecastVariance(metric);
					if(metric.getForecastReceivedDate() != null) { metric.setForecastReceivedDate(new Date()); }
				}
			}
		}
		
		return super.save(projectReport);

	}


	public void setLookupManager(LookupManager lookupManager) {
		this.lookupManager = lookupManager;
	}


	public void setMetricDao(GenericDao<Metric, Long> metricDao) {
		this.metricDao = metricDao;
	}


	public void setMetricProjectDao(GenericDao<MetricProject, Long> metricProjectDao) {
		this.metricProjectDao = metricProjectDao;
	}

	public void setReportingPeriodDao(
			GenericDao<ReportingPeriod, Long> reportingPeriodDao) {
		this.reportingPeriodDao = reportingPeriodDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}


}
