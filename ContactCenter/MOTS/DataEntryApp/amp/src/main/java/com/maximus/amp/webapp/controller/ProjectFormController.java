package com.maximus.amp.webapp.controller;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.model.Division;
import com.maximus.amp.model.GeographyMaster;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.Program;
import com.maximus.amp.model.Project;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;

@Controller
@RequestMapping("/admin/project")
public class ProjectFormController extends BaseFormController {
	
    private GenericManager<Project, Long> projectManager = null;
    private GenericManager<Program, Long> programManager = null;
    private GenericManager<GeographyMaster, Long> geographyManager = null;
    private LookupManager lookupManager = null;
    
//    @Autowired
//    private ConversionService conversionService;
//    @InitBinder
//    protected void initBinder(ServletRequestDataBinder binder) {
//        binder.setConversionService(conversionService);
//    }


    public ProjectFormController() {
        setCancelView("redirect:/admin/projects");
        setSuccessView("redirect:/admin/projects");
    }
    
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        binder.registerCustomEditor(Division.class, "division", new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	            if (!text.isEmpty()){
	            	Division d = lookupManager.getOneOfTypeById(Division.class, Long.parseLong(text));
	            	setValue(d);
	            }
	        }
        });
    }
    
    
    private void initModel(Model model, Project project) {
        
    	List<MetricProject> metricProjects = null;
    	model.addAttribute("project", project);
    	
    	
    	if(project.getId()!=null){
    		metricProjects = lookupManager.getMetricProjects(project);
    	} else {
    		metricProjects = new ArrayList<MetricProject>();
    	}
    	    	
    	model.addAttribute("divisions", lookupManager.getAllOfType(Division.class));    	
        model.addAttribute("metricProjects", metricProjects);
        model.addAttribute("programs", lookupManager.getAllOfTypeSorted(Program.class, "programName"));
        model.addAttribute("geographyMasters", lookupManager.getAllOfTypeSorted(GeographyMaster.class, "geographyName"));
        
    }

    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("project")
    protected Project loadProject(final HttpServletRequest request) {
        final String id = request.getParameter("id");
        if (isFormSubmission(request) && StringUtils.isNotBlank(id)) {
        // if (StringUtils.isNotBlank(metricId)) {
            return projectManager.get(new Long(id));
        }
        return new Project();
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String onSubmit(@ModelAttribute("project") Project project, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response 
//    		, @AuthenticationPrincipal User activeUser
    		, Model model) throws Exception {
    	
    	String view = getSuccessView();
    	
    	//  TODO:  it appears that this should be able to be done via the @AuthenticationPrincipal annotated method param;
    	UserDetails currentUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		return getCancelView();
    	}

        if (validator != null) { // validator is null during testing
            validator.validate(project, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
                initModel(model, project);
            	return "admin/projectForm";
            }
        }

        log.debug("entering 'onSubmit' method...");

        boolean isNew = (project.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
        	projectManager.remove(project.getId());
            saveMessage(request, getText("project.deleted", locale));
        } else {
        	
        	if(isNew) {
        		project.setCreatedDate(new Date());
        	}
        	
        	project.setModifiedDate(new Date());
        	
        	
        	final String[] programs = request.getParameterValues("programSelect");
        	final String[] geographyMasters = request.getParameterValues("geographySelect");

            if (programs != null) {
                project.getPrograms().clear();
                for (final String programId : programs) {
                    project.addProgram(lookupManager.getOneOfTypeById(Program.class, Long.parseLong(programId)));
                }
            } else {
            	project.getPrograms().clear();
            }
        	
            if (geographyMasters != null) {
                project.getGeographyMasters().clear();
                for (final String geographyMasterId : geographyMasters) {
                    project.addGeographyMaster(lookupManager.getOneOfTypeById(GeographyMaster.class, Long.parseLong(geographyMasterId)));
                }
            } else {
            	project.getGeographyMasters().clear();
            }
            
            project = projectManager.save(project);
            
            if(request.getParameter("addProgram") != null) {
            	final String programName = request.getParameter("programName");
            	
            	Program program = new Program(programName);
            	program = programManager.save(program);
            	project.addProgram(program);
            	project = projectManager.save(project);
            	
            	view = getEditProjectView(project);
            }

            if(request.getParameter("addGeography") != null) {
            	final String geographyName = request.getParameter("geographyName");
//            	final String countryName = request.getParameter("countryName");
//            	final String stateName = request.getParameter("stateName");
//            	final String regionName = request.getParameter("regionName");
//            	final String provinceName = request.getParameter("provinceName");
//            	final String districtName = request.getParameter("districtName");
            	
            	GeographyMaster geography = new GeographyMaster(geographyName);
            	
            	geography = geographyManager.save(geography);
            	project.addGeographyMaster(geography);
            	project = projectManager.save(project);
            	
            	view = getEditProjectView(project);
            }
            
            
        	
            String key = (isNew) ? "project.added" : "project.updated";
            saveMessage(request, getText(key, locale));
        }

        if(request.getParameter("addMetricProject")!=null){
        	return "redirect:/admin/metricProject/add/"+project.getId();
        }

        if(request.getParameter("addProjectUser")!=null){
        	return "redirect:/admin/projectUser/add/"+project.getId();
        }
        
        return view;
        
    }


	protected String getEditProjectView(Project project) {
		return "redirect:/admin/project/edit/" + project.getId();
	}


	@Autowired
    public void setLookupManager(@Qualifier("lookupManager") LookupManager lookupManager) {
        this.lookupManager = lookupManager;
    }
    
    
    @Autowired
    public void setProjectManager(@Qualifier("projectManager") GenericManager<Project, Long> projectManager) {
        this.projectManager = projectManager;
    }
    
    @ModelAttribute
    @RequestMapping(value="/add", method=RequestMethod.GET)
    protected ModelAndView showAddForm(HttpServletRequest request, Model model) {

    	Project project = new Project();
   		initModel(model, project);
    	
    	return new ModelAndView("admin/projectForm", model.asMap());

    }
    
    @ModelAttribute
    @RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
    protected ModelAndView showForm(HttpServletRequest request, Model model
 			, @PathVariable(value="id") Long id) {

    	Project project = null;
    	
    	if (id!=null) {
    		project = projectManager.get(new Long(id));
    	} else {
    		project = new Project();
    	}
    	
    	
    	initModel(model, project);
    	
    	return new ModelAndView("admin/projectForm", model.asMap());

    }

    @Autowired
	public void setProgramManager(@Qualifier("programManager") GenericManager<Program, Long> programManager) {
		this.programManager = programManager;
	}

    @Autowired
	public void setGeographyManager(@Qualifier("programManager") GenericManager<GeographyMaster, Long> geographyManager) {
		this.geographyManager = geographyManager;
	}

}

