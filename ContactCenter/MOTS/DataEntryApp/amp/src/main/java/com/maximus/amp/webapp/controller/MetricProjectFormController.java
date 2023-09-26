package com.maximus.amp.webapp.controller;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.model.LabelValue;
import com.maximus.amp.model.Metric;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;

@Controller
@RequestMapping("/admin/metricProject")
public class MetricProjectFormController extends BaseFormController {
	
    private GenericManager<MetricProject, Long> manager = null;
    private LookupManager lookupManager = null;
    
    public MetricProjectFormController() {
        setCancelView("redirect:/admin/project/edit");
        setSuccessView("redirect:/admin/project/edit");
    }
    
    private void initModel(Model model, MetricProject metricProject) {
    	model.addAttribute("metricProject", metricProject);	
    	model.addAttribute("programMap", convertBaseObjectCollectionToLabelValues(null, metricProject.getProject().getPrograms()));
		model.addAttribute("geographyMasterMap", convertBaseObjectCollectionToLabelValues(null, metricProject.getProject().getGeographyMasters()));
        model.addAttribute("metrics", convertBaseObjectCollectionToLabelValues(null, lookupManager.getMetricDefinitionsSortedByFuncAreaAndName()));
    }

    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("metricProject")
    protected MetricProject loadMetricProject(final HttpServletRequest request) {
        final String id = request.getParameter("id");
        
        if (isFormSubmission(request) && StringUtils.isNotBlank(id) && !id.equals("0")) {
        // if (StringUtils.isNotBlank(metricId)) {
            return manager.get(new Long(id));
        }
        return new MetricProject();
    }
    
	@RequestMapping(value = "/metrics", method = RequestMethod.GET)
	// TODO:  refactor to accept JSON instead of list of params
	public @ResponseBody List<LabelValue> getMetricDefinitions(
			@RequestParam(value = "projectId", required = true) Long projectId
			, @RequestParam(value = "programId", required = true) Long programId
			, @RequestParam(value = "geographyMasterId", required = true) Long geographyMasterId) {
		
		
		return convertBaseObjectCollectionToLabelValues(null, lookupManager.getNewMetricDefinitions(projectId, programId, geographyMasterId));

	}
    
    @RequestMapping(method = RequestMethod.POST)
    public String onSubmit(@ModelAttribute("metricProject") MetricProject metricProject, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response 
    		, Model model) throws Exception {
    	
    	//  TODO:  it appears that this should be able to be done via the @AuthenticationPrincipal annotated method param;
    	UserDetails currentUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		return getCancelView() + "/" + metricProject.getProject().getId();
    	}

        if (validator != null) { // validator is null during testing
            validator.validate(metricProject, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
                initModel(model, metricProject);
            	return "admin/metricProjectForm";
            }
        }

        log.debug("entering 'onSubmit' method...");

        boolean isNew = (metricProject.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
        	manager.remove(metricProject.getId());
            saveMessage(request, getText("metricProject.deleted", locale));
        } else {
        	
        	if(isNew) {
        		metricProject.setCreatedDate(new Date());
        	}
        	
        	metricProject.setModifiedDate(new Date());
        	
        	manager.save(metricProject);
            String key = (isNew) ? "metricProject.added" : "metricProject.updated";
            saveMessage(request, getText(key, locale));
        }

        return getSuccessView() + "/" + metricProject.getProject().getId();
    }


	@Autowired
    public void setLookupManager(@Qualifier("lookupManager") LookupManager lookupManager) {
        this.lookupManager = lookupManager;
    }
    
    
    @Autowired
    public void setMetricProjectManager(@Qualifier("metricProjectManager") GenericManager<MetricProject, Long> metricProjectManager) {
        this.manager = metricProjectManager;
    }
    
    @ModelAttribute
    @RequestMapping(value="/add/{projectId}", method=RequestMethod.GET)
    protected ModelAndView showAddForm(HttpServletRequest request, Model model , @PathVariable(value="projectId") Long projectId) {

    	Project project = lookupManager.getOneOfTypeById(Project.class, projectId);
    	MetricProject metricProject = new MetricProject(project);
    	
   		initModel(model, metricProject);
    	
    	return new ModelAndView("admin/metricProjectForm", model.asMap());

    }
    
    @ModelAttribute
    @RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
    protected ModelAndView showForm(HttpServletRequest request, Model model
 			, @PathVariable(value="id") Long id) {


    	initModel(model, manager.get(new Long(id)));
    	
    	return new ModelAndView("admin/metricProjectForm", model.asMap());

    }

}
