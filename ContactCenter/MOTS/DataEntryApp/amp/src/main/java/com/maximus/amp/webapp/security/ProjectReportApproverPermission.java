package com.maximus.amp.webapp.security;

import javax.transaction.Transactional;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import com.maximus.amp.Constants;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ProjectUser;
import com.maximus.amp.model.User;

@Component
public class ProjectReportApproverPermission extends ProjectReportPermission implements Permission {
	
	@Override
	@Transactional
	public boolean isAllowed(Authentication authentication, Object object) {
		
		if(object == null) { return true; }
		
		ProjectReport projectReport = getProjectReport(object);
		//  if null is returned, then the request is invalid.  
		if(projectReport == null) { return false; }
		
		Project project = getProject(projectReport);
		//  if null is returned, then the request is invalid.
		if(project == null) { return false; }
		
		String functionalArea = projectReport.getFunctionalArea();					
		User user = (User) userDao.loadUserByUsername(authentication.getName());

		for(ProjectUser projectUser : project.getProjectUsers()){
			if(functionalArea.equals(projectUser.getFunctionalArea()) 
					&& user.equals(projectUser.getUser())
					&& projectUser.getRole().getName().equals(Constants.ROLE_PROJECT_APPROVER)) { 
				return true; 
			}
		}
		
		return false;
		
	}
}
