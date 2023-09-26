package com.maximus.amp.webapp.controller;

import javax.servlet.http.HttpServletRequest;

import org.directwebremoting.util.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.dao.SearchException;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.service.ProjectReportManager;

@Controller
@RequestMapping("/reports")
public class ProjectReportController extends BaseFormController {
    
	Logger LOGGER = Logger.getLogger(getClass());
	
	private ProjectReportManager projectReportManager;

    @Autowired
    public void setprojectReportManager(@Qualifier("projectReportManager") ProjectReportManager projectReportManager) {
        this.projectReportManager = projectReportManager;
    }

    @RequestMapping(value="/{type}", method = RequestMethod.GET)
    public ModelAndView handleRequest(HttpServletRequest request,
    		@PathVariable("type") String type, 
    		@RequestParam(required = false, value = "q") String query) 
    	throws Exception {
    	
    	LOGGER.debug("handling");

    	if(!ProjectReport.ReportType.contains(type)){
    		return new ModelAndView("/404");
    	}
    	
        Model model = new ExtendedModelMap();
        
        model.addAttribute("type", type);
        model.addAttribute("typeMsg", getText("projectReport.type."+type, request.getLocale()));
        
        
        try {
        	LOGGER.debug("check search box");
        	if((query == null)||(query.isEmpty())){
        		LOGGER.debug("no search value. returning project-reports assoc w/ user");
        		model.addAttribute("projectReportList", projectReportManager.getProjectReportsByUserDetails(getCurrentUser(), type));
        	} else {
        		LOGGER.debug("there is a search value. performing search");
        		// model.addAttribute("projectReportList", projectReportManager.search(query, ProjectReport.class));
        		model.addAttribute("projectReportList", projectReportManager.getAll());
        	}
        } catch (SearchException se) {
            model.addAttribute("searchError", se.getMessage());
            model.addAttribute("projectReportList", projectReportManager.getProjectReportsByUserDetails(getCurrentUser(), type));
        }
        
        return new ModelAndView("projectReportList", model.asMap());
    }
}
