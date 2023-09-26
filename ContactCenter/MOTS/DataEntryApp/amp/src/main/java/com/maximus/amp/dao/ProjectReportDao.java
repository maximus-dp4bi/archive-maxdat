package com.maximus.amp.dao;

import com.maximus.amp.model.ProjectReport;

public interface ProjectReportDao extends GenericDao<ProjectReport, Long> {
	
	void approve(ProjectReport projectReport);

}
