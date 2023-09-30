package com.maximus.amp.webapp.controller;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.maximus.amp.Constants;
import com.maximus.amp.model.LabelValue;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.Role;
import com.maximus.amp.model.User;
import com.maximus.amp.model.ValidationResult;
import com.maximus.amp.service.LookupManager;
import com.maximus.amp.service.ProjectReportManager;
import com.maximus.amp.webapp.security.Permission;
import com.maximus.amp.webapp.security.ProjectReportApproverPermission;
import com.maximus.amp.webapp.validator.ProjectReportValidator;


@Controller
@RequestMapping("/report")
public class ProjectReportFormController extends BaseFormController {
	
	@Autowired
    private ProjectReportManager projectReportManager = null;
	
	@Autowired
	private LookupManager lookupManager = null;
    
	@Autowired
	@Qualifier("projectReportValidator")
    private ProjectReportValidator validator;
	
	@Autowired
	@Qualifier("projectReportApproverPermission")
	// TODO:  review why the security:authorize tag is not correctly calling hasPermission
	//  and remove this field from the controller...
	private Permission projectReportApproverPermission = null;

	public ProjectReportFormController() {
        setCancelView("redirect:/reports");
        setSuccessView("redirect:/reports");
    }
	

	private Model initAddModel(String type) {

    	Model model = new ExtendedModelMap();
    	
		ProjectReport projectReport = ProjectReport.newProjectReport(type);
		
    	model.addAttribute("projectReport", projectReport);
    	model.addAttribute("type", type);
    	
    	User user = (User) getCurrentUser();
    	
    	Set<Project> projectSet = user.getProjects();
    	if(projectSet.size() > 0) {
	    	Project firstProject = projectSet.iterator().next();
	    	
	    	model.addAttribute("projectMap", convertBaseObjectCollectionToMap(projectSet));
			model.addAttribute("programMap", convertBaseObjectCollectionToMap(firstProject.getPrograms()));
			model.addAttribute("geographyMasterMap", convertBaseObjectCollectionToMap(firstProject.getGeographyMasters()));
			model.addAttribute("functionalAreas", convertStringsToLabelValues(null, user.getFunctionalAreas(firstProject)));
    	}
		// model.addAttribute("functionalAreas", convertStringListToLabelValues(null, lookupManager.getDistinctFunctionalAreas(firstProject.getId().toString(), (User) getCurrentUser())));
		// List<ReportingPeriod> reportingPeriodList = projectReportManager.getAvailableReportingPeriods(projectReport);
		// List<ReportingPeriod> reportingPeriodList = lookupManager.getAllOfType(ReportingPeriod.class);

		//  start with empty list of reporting periods until form selections are made..
		List<ReportingPeriod> reportingPeriodList = new ArrayList<ReportingPeriod>();
		// TODO:  refactor label to pull from messages
		model.addAttribute("reportingPeriodMap", convertBaseObjectCollectionToLabelValues(new LabelValue("Select a reporting period ...", "0"), reportingPeriodList));

		return model;
	}
	
	@InitBinder
    protected void initBinder(final HttpServletRequest request, final ServletRequestDataBinder binder) {
    	super.initBinder(request, binder);
        binder.setValidator(validator);
        
        binder.registerCustomEditor(ReportingPeriod.class, "reportingPeriod", new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	            if (!text.isEmpty()){
	            	ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, Long.parseLong(text));
	            	setValue(reportingPeriod);
	            }
	        }
        });
        
        binder.registerCustomEditor(null, "metrics.actualValueNotSupplied", new PropertyEditorSupport() {
	        
        	@Override
	        public String getAsText() {
        		return getValue().toString();
	            
	        }
        	
        	@Override
	        public void setAsText(String text) {
        		//  when form is not readonly, a checked box == "on"
        		//  when the form is readonly, a checked box
        		if (text.equals("on") || text.equals(Constants.Y)){
	            	setValue("Y");
	            } else {
	            	setValue("N");
	            }
	        }
        });

        binder.registerCustomEditor(null, "metrics.forecastValueNotSupplied", new PropertyEditorSupport() {
	        
	        
        	@Override
	        public String getAsText() {
	            return getValue().toString();
	        }
        	
        	@Override
	        public void setAsText(String text) {
        		//  when form is not readonly, a checked box == "on"
        		//  when the form is readonly, a checked box
	            if (text.equals("on") || text.equals(Constants.Y)){
	            	setValue("Y");
	            } else {
	            	setValue("N");
	            }
	        }
        });

        
    }


	protected boolean isFormSubmission(final HttpServletRequest request) {
    	
    	String ajax = request.getParameter("ajax"); 
    	
    	if(!StringUtils.isEmpty(ajax) && ajax.equals("true")) return true;
    	
        return request.getMethod().equalsIgnoreCase("post");
    }
    
    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("projectReport")
    protected ProjectReport loadProjectReport(final HttpServletRequest request) {
        final String projectReportId = request.getParameter("id");
        final String type = request.getParameter("type");
        
        if (isFormSubmission(request) && StringUtils.isNotBlank(projectReportId)) {
            ProjectReport projectReport = projectReportManager.get(new Long(projectReportId));
            return projectReport;
            // return initProjectReportForm(projectReport);
        } else if (StringUtils.isNotBlank(type)) {
        	return ProjectReport.newProjectReport(type);	
        }
        
        return null;
        


    }

    @RequestMapping(value = "/project", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, List<LabelValue>> onProjectChange(@RequestParam(value = "projectId", required = true) String projectId) {
		log.debug("getting programs for project " + projectId);
		
		Project project = projectReportManager.getProjectById(projectId);

		List<LabelValue> programs = convertBaseObjectCollectionToLabelValues(null, project.getPrograms());
		List<LabelValue> geographyMasters = convertBaseObjectCollectionToLabelValues(null, project.getGeographyMasters());
// 		List<LabelValue> functionalAreas = convertStringsToLabelValues(null, lookupManager.getDistinctFunctionalAreas(projectId, (User) getCurrentUser()));
		
		List<LabelValue> functionalAreas = convertStringsToLabelValues(null, ((User) getCurrentUser()).getFunctionalAreas(project));
		
		Map<String, List<LabelValue>> map = new HashMap<String, List<LabelValue>>();
		map.put("programOptions", programs);
		map.put("geographyMasterOptions", geographyMasters);
		map.put("functionalAreas", functionalAreas);
		
		return map;

	}
    

	@RequestMapping(value = "/reportingPeriods", method = RequestMethod.GET)
	// TODO:  refactor to accept JSON instead of list of params
	public @ResponseBody List<LabelValue> onReportingPeriodTypeChange(
			@RequestParam(value = "functionalArea", required = true) String functionalArea
			, @RequestParam(value = "reportingPeriodType", required = true) String reportingPeriodType
			, @RequestParam(value = "projectId", required = true) String projectId
			, @RequestParam(value = "programId", required = true) String programId
			, @RequestParam(value = "geographyMasterId", required = true) String geographyMasterId
			, @RequestParam(value = "reportType", required = true) String reportType
			, @RequestParam(value = "reportingPeriodYear", required = true) String reportingPeriodYear) {
		
		log.debug("getting reporting periods for project " + projectId);
		
		List<ReportingPeriod> availableReportingPeriods = projectReportManager.getAvailableReportingPeriods(functionalArea, reportingPeriodType, projectId, programId, geographyMasterId, reportType, reportingPeriodYear);
		
		return convertBaseObjectCollectionToLabelValues(new LabelValue("Select a reporting period ...", "0"), availableReportingPeriods);

	}
	
	@RequestMapping(value = "/validateActualValue", method = RequestMethod.POST)
	@ResponseBody
	public List<ValidationResult> onActualValueChange(@RequestBody final ProjectReport projectReport) {
		
		List<ValidationResult> validationResults = validator.validate(projectReport);

		return validationResults;
		
	}

    
    @RequestMapping(value="/**/submit", method = RequestMethod.POST)
    @PreAuthorize("#request.getParameter('cancel') == '' or hasPermission(#projectReport, 'isProjectReportUser')")
    public ModelAndView onSubmit(@ModelAttribute("projectReport") ProjectReport projectReport, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response) throws Exception {
    	
    	boolean isApproval = false;
    	
    	// TODO:  review how "actions" are passed as individual request parameters 
    	// and see if this should be refactored to make business logic more streamlined
    	// e.g., add single parameter and set to confirm, approve, reEdit, etc.
    	boolean validate = getValidate(request);
    	
    	if(log.isDebugEnabled()) log.debug("validate?  " + validate);
    			
    	String type = projectReport.getType();
    	
    	UserDetails activeUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		if(log.isDebugEnabled()) log.debug("cancel");
    		return new ModelAndView(getCancelView()+"/"+type);
        }

    	if(log.isDebugEnabled()) log.debug("entering 'onSubmit' method...");
        
        if (validate && validator != null) { // validator is null during testing
        	if(log.isDebugEnabled()) log.debug("validating...");
            validator.validate(projectReport, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
            	if(log.isDebugEnabled()) log.debug("has errors...");
            	return new ModelAndView("projectReportForm");
            }
        }


        // TODO:  move business logic into service layer and out of controller
        if (request.getParameter("confirm") != null) {
        	if(log.isDebugEnabled()) log.debug("confirming...");
        	projectReport.setStatus(ProjectReport.Status.CONFIRMED.toString());
        } else if (request.getParameter("approve") != null) {
        	if(log.isDebugEnabled()) log.debug("approving...");
        	projectReport.setStatus(ProjectReport.Status.APPROVED.toString());
            projectReport.setApproved(true);
            projectReport.setApprovedDate(new Date());
            
            isApproval = true;
            // TODO:  add logic to initiate trend indicator calculation and create records in F_METRIC
        } else if (request.getParameter("reEdit") != null) {
        	if(log.isDebugEnabled()) log.debug("reediting...");
        	projectReport.setStatus(ProjectReport.Status.PENDING.toString());
        	projectReport.setApproved(false);
            projectReport.setIsActualsTrendProcessed(Constants.N);
            projectReport.setIsFutureTrendsProcessed(Constants.N);
        }
        

        
        boolean isNew = (projectReport.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
        	projectReportManager.remove(projectReport);
            saveMessage(request, getText("projectReport.deleted", getText("projectReport.type."+type, request.getLocale()), locale));
        } else {
        	
        	if(isNew) {
        		if(log.isDebugEnabled()) log.debug("isNew...");

        		List<MetricProject> metricProjectList = projectReportManager.getMetricProjectsForReport(projectReport);
        		
        		// if no metrics are configured for this combo, alert user !!
        		if(metricProjectList.size() == 0) {
        			saveError(request, getText("projectReport.noMetricsConfigured", "", locale));
        			return showAddForm(request, projectReport.getType());
        		}
        				
        		projectReport.setCreatedBy(activeUser.getUsername());
        		projectReport.setCreatedDate(new Date());
            	projectReport.setModifiedBy(activeUser.getUsername());
            	projectReport.setModifiedDate(new Date());
            	
        		projectReport = projectReportManager.save(projectReport);
        		

        		
        		log.debug("controller.initializeMetrics");
        		projectReportManager.initializeMetrics(projectReport, metricProjectList);
        	}
        	
        	log.debug("controller.save(projectReport)");
            projectReport = projectReportManager.save(projectReport);
            
            if(isApproval) { projectReportManager.approve(projectReport); }
            
            String key = (isNew) ? "projectReport.added" : "projectReport.updated";
            saveMessage(request, getText(key, getText("projectReport.type."+type, request.getLocale()), locale));
        }

        if(isNew) {
        	Model model = initEditModel(request, projectReport);
        	RedirectView view = new RedirectView("/report/edit/"+type+"/"+projectReport.getId().toString(), false, true, false);
        	return new ModelAndView(view, model.asMap());
        } else {
        	return new ModelAndView(getSuccessView()+"/"+type);
        }
    }
    
    
    private boolean getValidate(HttpServletRequest request) {
    	if (request.getParameter("reEdit") != null || request.getParameter("saveNew") != null) {
            return false;
        }
		return true;
	}


	@RequestMapping(value="/add/{type}", method = RequestMethod.GET)
	protected ModelAndView showAddForm(HttpServletRequest request, @PathVariable(value="type") String type) {
		
    	Model model = initAddModel(type);
    	
        model.addAttribute("typeMsg", getText("projectReport.type."+type, request.getLocale()));
		
		return new ModelAndView("addProjectReportForm", model.asMap());
    }
    
    @RequestMapping(value="/{action}/{type}/{id}", method = RequestMethod.GET)
    @PreAuthorize(value="hasPermission(#id, 'isProjectReportUser')")
	protected ModelAndView showForm(HttpServletRequest request
			, @PathVariable(value="action") String action
			, @PathVariable(value="type") String type
			, @PathVariable(value="id") Long id) {
		
		ProjectReport projectReport;
		
		if (id!=null) {
			 projectReport = projectReportManager.get(id);			
		} else {
			return new ModelAndView("redirect:/reports");
		}
		
		if(projectReport.getStatus().equals("Pending")) {
			projectReport = projectReportManager.initializeMetrics(projectReport);
		}
		
		Model model = initEditModel(request, projectReport);
		
		return new ModelAndView("projectReportForm", model.asMap());
    }


	protected Model initEditModel(HttpServletRequest request, ProjectReport projectReport) {
		
		boolean isProjectReportApprover = projectReportApproverPermission.isAllowed(getCurrentAuthentication(), projectReport);
		
		String readonly = projectReport.getStatus().equals("Pending") ? "false" : "true";
		
		Model model = new ExtendedModelMap();
		model.addAttribute("typeMsg", getText("projectReport.type."+projectReport.getType(), request.getLocale()));
		model.addAttribute("projectReport", projectReport);
		model.addAttribute("isProjectReportApprover", isProjectReportApprover);
		model.addAttribute("readonly", readonly);
		
		return model;
	}


    
}
