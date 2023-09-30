package com.maximus.amp.webapp.controller;

import org.apache.commons.lang3.StringUtils;
import org.directwebremoting.util.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.Constants;
import com.maximus.amp.dao.SearchException;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.Project;
import com.maximus.amp.service.GenericManager;

@Controller
@RequestMapping("/admin/projects*")
public class ProjectController extends BaseFormController {
    
	Logger LOGGER = Logger.getLogger(getClass());
	
	private GenericManager<Project, Long> projectManager;

    @Autowired
    public void setProjectManager(@Qualifier("projectManager") GenericManager<Project, Long> projectManager) {
        this.projectManager = projectManager;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView handleRequest(@RequestParam(required = false, value = "q") String query) throws Exception {
    	
    	LOGGER.debug("handling");
    	
        Model model = new ExtendedModelMap();
        
        try {
        	
        	if(StringUtils.isNotEmpty(query)) {
        		model.addAttribute("projectList", projectManager.search(query, Project.class));
        	} else {
        		model.addAttribute("projectList", projectManager.getAll());
        	}
        
        } catch (SearchException se) {
            model.addAttribute("searchError", se.getMessage());
            model.addAttribute("projectList", projectManager.getAll());
        }
        
                
        return new ModelAndView("admin/projectList", model.asMap());
    }
}
