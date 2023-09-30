package com.maximus.amp.webapp.security;

import org.springframework.beans.factory.annotation.Autowired;

import com.maximus.amp.dao.GenericDao;
import com.maximus.amp.dao.UserDao;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;

public abstract class ProjectReportPermission {
	
	@Autowired
	protected GenericDao<ProjectReport, Long> projectReportDao = null;

	@Autowired
	protected GenericDao<Project, Long> projectDao = null;
	
	@Autowired
	protected UserDao userDao = null;
	
	protected Project getProject(ProjectReport projectReport) {
		Project project = null;
		
		if(projectReport.getProject() != null){
			//  if the name is null, then the project has not been hydrated, so lookup by id
			if(projectReport.getProject().getProjectName() != null) {
				project = projectReport.getProject();
			} else if (projectReport.getProject().getId() != null){
				project = projectDao.get(projectReport.getProject().getId());
			}
		}
		
		return project;
	}
	
	
	/**
	 * 
	 * @param object
	 * @return if the object is a Long, retrieve and return the ProjectReport,
	 *  		otherwise, if the object is a ProjectReport cast the object to a ProjectReport
	 *  		and return it.  If the object is an instance of neither type, then return null.
	 */
	protected ProjectReport getProjectReport(Object object) {

		if(object instanceof Long) { 
			Long projectReportId = (Long) object;			
			return projectReportDao.get(projectReportId);
		} else if(object instanceof ProjectReport) {
			return (ProjectReport) object;
		} else {
			return null;
		}

	}


}
