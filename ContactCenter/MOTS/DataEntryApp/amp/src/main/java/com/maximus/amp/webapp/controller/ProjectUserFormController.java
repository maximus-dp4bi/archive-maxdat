package com.maximus.amp.webapp.controller;

import java.beans.PropertyEditorSupport;
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
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.maximus.amp.model.ProjectUser;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.Role;
import com.maximus.amp.model.User;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;
import com.maximus.amp.service.UserManager;

@Controller
@RequestMapping("/admin/projectUser")
public class ProjectUserFormController extends BaseFormController {
	
    private GenericManager<ProjectUser, Long> manager = null;
    private LookupManager lookupManager = null;
    
    public ProjectUserFormController() {
        setCancelView("redirect:/admin/project/edit");
        setSuccessView("redirect:/admin/project/edit");
    }
    
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        binder.registerCustomEditor(MetricDefinition.class, "role", new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	            if (!text.isEmpty()){
	            	Role role = lookupManager.getOneOfTypeById(Role.class, Long.parseLong(text));
	            	setValue(role);
	            }
	        }
        });
        
        binder.registerCustomEditor(User.class, "user", new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	            if (!text.isEmpty()){
	            	User user = lookupManager.getOneOfTypeById(User.class, Long.parseLong(text));
	            	setValue(user);
	            }
	        }
        });
    }
    
    private void initModel(Model model, ProjectUser projectUser) {
    	model.addAttribute("projectUser", projectUser);	
        model.addAttribute("roles", convertBaseObjectCollectionToLabelValues(null, lookupManager.getProjectRoles()));
        model.addAttribute("functionalAreas", convertStringsToLabelValues(null, lookupManager.getDistinctFunctionalAreas()));
        model.addAttribute("users", convertBaseObjectCollectionToLabelValues(null, userManager.getUsers()));
    }

    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("projectUser")
    protected ProjectUser loadProjectUser(final HttpServletRequest request) {
        final String id = request.getParameter("id");
        
        if (isFormSubmission(request) && StringUtils.isNotBlank(id) && !id.equals("0")) {
        // if (StringUtils.isNotBlank(metricId)) {
            return manager.get(new Long(id));
        }
        return new ProjectUser();
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
    public String onSubmit(@ModelAttribute("projectUser") ProjectUser projectUser, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response 
    		, Model model) throws Exception {
    	
    	//  TODO:  it appears that this should be able to be done via the @AuthenticationPrincipal annotated method param;
    	UserDetails currentUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		return getCancelView() + "/" + projectUser.getProject().getId() + "#users";
    	} 
    	
        if (validator != null) { // validator is null during testing
            validator.validate(projectUser, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
                initModel(model, projectUser);
            	return "admin/projectUserForm";
            }
        }
        
        log.debug("entering 'onSubmit' method...");
        
        boolean isNew = (projectUser.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
        	manager.remove(projectUser.getId());
            saveMessage(request, getText("projectUser.deleted", locale));
        } else {
       	
        	manager.save(projectUser);
            String key = (isNew) ? "projectUser.added" : "projectUser.updated";
            saveMessage(request, getText(key, locale));
        }

        return getSuccessView() + "/" + projectUser.getProject().getId();
    }


	@Autowired
    public void setLookupManager(@Qualifier("lookupManager") LookupManager lookupManager) {
        this.lookupManager = lookupManager;
    }
    
    
    @Autowired
    public void setProjectUserManager(@Qualifier("projectUserManager") GenericManager<ProjectUser, Long> projectUserManager) {
        this.manager = projectUserManager;
    }


    
    @ModelAttribute
    @RequestMapping(value="/add/{projectId}", method=RequestMethod.GET)
    protected ModelAndView showAddForm(HttpServletRequest request, Model model , @PathVariable(value="projectId") Long projectId) {

    	Project project = lookupManager.getOneOfTypeById(Project.class, projectId);
    	ProjectUser projectUser = new ProjectUser(project);
    	
   		initModel(model, projectUser);
    	
    	return new ModelAndView("admin/projectUserForm", model.asMap());

    }
    
    @ModelAttribute
    @RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
    protected ModelAndView showForm(HttpServletRequest request, Model model
 			, @PathVariable(value="id") Long id) {


    	initModel(model, manager.get(new Long(id)));
    	
    	return new ModelAndView("admin/projectUserForm", model.asMap());

    }

}
