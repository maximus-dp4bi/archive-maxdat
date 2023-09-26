package com.maximus.amp.webapp.controller;

import javax.servlet.http.HttpServletRequest;

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

import com.maximus.amp.dao.SearchException;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;
import com.maximus.amp.service.MetricDefinitionManager;

@Controller
@RequestMapping("/*/metrics*")
public class MetricDefinitionController extends BaseFormController {
    
	Logger LOGGER = Logger.getLogger(getClass());
	
	private MetricDefinitionManager metricDefinitionManager;
	
	private LookupManager lookupManager;
	
    @RequestMapping(value="admin/metrics", method = RequestMethod.GET)
    public ModelAndView handleAdminRequest(@RequestParam(required = false, value = "q") String query) throws Exception {
    	
    	LOGGER.debug("handling");
    	
        Model model = new ExtendedModelMap();
        try {
        	if(StringUtils.isNotEmpty(query)) {
        		model.addAttribute("metricDefinitionList", metricDefinitionManager.search(query));
        	} else {
        		model.addAttribute("metricDefinitionList", lookupManager.getActiveMetricDefinitions());
        	}
        } catch (SearchException se) {
            model.addAttribute("searchError", se.getMessage());
            model.addAttribute(metricDefinitionManager.getAll());
        }
        
        return new ModelAndView("admin/metricDefinitionList", model.asMap());
    }

    @RequestMapping(value="help/metrics")
    public ModelAndView handleHelpRequest(@RequestParam(required = false, value = "q") String query
    		, final HttpServletRequest request) throws Exception {
    	
    	LOGGER.debug("handling");
    	String functionalArea = request.getParameter("functionalArea");
    	if(StringUtils.isEmpty(functionalArea)) { functionalArea = "Contact Center"; }    	
    	
        Model model = new ExtendedModelMap();
        
        model.addAttribute("functionalAreas", convertStringsToLabelValues(null, lookupManager.getDistinctFunctionalAreas()));
        model.addAttribute("functionalArea", functionalArea);
        
        try {
        	
        	if(StringUtils.isNotEmpty(query)) {
        		model.addAttribute("metricDefinitionList", metricDefinitionManager.search(query, true));
        	} else {
        		model.addAttribute("metricDefinitionList", lookupManager.getActiveMetricDefinitions(functionalArea));
        	}
        } catch (SearchException se) {
            model.addAttribute("searchError", se.getMessage());
            model.addAttribute(metricDefinitionManager.getAll());
        }
        
        return new ModelAndView("help/metricDefinitionList", model.asMap());
    }

    @Autowired
    public void setLookupManager(@Qualifier("lookupManager") LookupManager lookupManager) {
        this.lookupManager = lookupManager;
    }
    
    @Autowired
    public void setMetricManager(@Qualifier("metricDefinitionManager") MetricDefinitionManager metricDefinitionManager) {
        this.metricDefinitionManager = metricDefinitionManager;
    }
    
    
}
