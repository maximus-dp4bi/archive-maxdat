package com.maximus.amp.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ReportingPeriod;

public interface ProjectReportManager extends GenericManager<ProjectReport, Long> {
	
	List<MetricProject> getMetricProjectsForReport(ProjectReport projectReport);
	
	List<ProjectReport> getProjectReportsByUserDetails(UserDetails userDetails, String type);

	ProjectReport initializeMetrics(ProjectReport projectReport);
	
	ProjectReport initializeMetrics(ProjectReport projectReport, List<MetricProject> metricProjectList);

	Project getProjectById(String projectId);

	List<ReportingPeriod> getAvailableReportingPeriods(String functionalArea, String reportingPeriodType, String projectId, String programId, String geographyMasterId, String reportType, String reportingPeriodYear);

	ProjectReport getPriorProjectReport(ProjectReport projectReport, String type);

	void approve(ProjectReport projectReport);
	
	void remove(ProjectReport projectReport);

}
