package com.maximus.amp.webapp.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
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
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricType;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;

@Controller
@RequestMapping("/admin/metricDefinitionForm*")
public class MetricDefinitionFormController extends BaseFormController {
    private GenericManager<MetricDefinition, Long> metricDefinitionManager = null;
    private LookupManager lookupManager = null;

    @Autowired
    public void setMetricManager(@Qualifier("metricDefinitionManager") GenericManager<MetricDefinition, Long> metricManager) {
        this.metricDefinitionManager = metricManager;
    }

    public MetricDefinitionFormController() {
        setCancelView("redirect:/admin/metrics");
        setSuccessView("redirect:/admin/metrics");
    }


    @ModelAttribute
    @RequestMapping(value="/add", method=RequestMethod.GET)
    protected ModelAndView showAddForm(HttpServletRequest request, Model model) {

    	MetricDefinition metricDefinition = new MetricDefinition();
   		initModel(model, metricDefinition);
    	
    	return new ModelAndView("admin/metricDefinitionForm", model.asMap());

    }
    
    @ModelAttribute
    @RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
    protected ModelAndView showForm(HttpServletRequest request, Model model
 			, @PathVariable(value="id") Long id) {

    	MetricDefinition metricDefinition = null;
    	
    	if (id!=null) {
    		metricDefinition = metricDefinitionManager.get(new Long(id));
    	} else {
    		metricDefinition = new MetricDefinition();
    	}
    	
    	
    	initModel(model, metricDefinition);
    	
    	return new ModelAndView("admin/metricDefinitionForm", model.asMap());

    }

    @RequestMapping(method = RequestMethod.POST)
    public String onSubmit(@ModelAttribute("metricDefinition") MetricDefinition metricDefinition, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response 
//    		, @AuthenticationPrincipal User activeUser
    		, Model model) throws Exception {
    	
    	//  TODO:  it appears that this should be able to be done via the @AuthenticationPrincipal annotated method param;
    	UserDetails currentUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		return getCancelView();
    	}

        if (validator != null) { // validator is null during testing
            validator.validate(metricDefinition, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
                initModel(model, metricDefinition);
            	return "admin/metricDefinitionForm";
            }
        }

        log.debug("entering 'onSubmit' method...");

        boolean isNew = (metricDefinition.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
            metricDefinitionManager.remove(metricDefinition.getId());
            saveMessage(request, getText("metricDefinition.deleted", locale));
        } else {
        	
        	if(isNew) {
        		metricDefinition.setStatus("Active");
        		metricDefinition.setRecordEffDate(DateUtils.truncate(new Date(), Calendar.DATE));
        		metricDefinition.setRecordEndDate(new GregorianCalendar(2199, 12, 31).getTime());
        	}
        	
            metricDefinitionManager.save(metricDefinition);
            String key = (isNew) ? "metricDefinition.added" : "metricDefinition.updated";
            saveMessage(request, getText(key, locale));
        }
        
        if(request.getParameter("addValidationRule")!=null){
        	return "redirect:/admin/validationRule/add/"+metricDefinition.getId();
        }

        return getSuccessView();
    }
    
    private void initModel(Model model, MetricDefinition metricDefinition) {
        
    	model.addAttribute("metricDefinition", metricDefinition);
    	
//    	List<MetricType> metricTypeList = lookupManager.getAllMetricTypes();
//    	
//    	Map<Long, String> metricTypeMap = new LinkedHashMap<Long, String>();
//    	for(MetricType mt : metricTypeList) {
//    		metricTypeMap.put(mt.getId(), mt.getMetricTypeName());
//    	}
//    	
//        model.addAttribute("metricTypeMap", metricTypeMap);
    }
    
    

    
    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("metricDefinition")
    protected MetricDefinition loadMetric(final HttpServletRequest request) {
        final String metricId = request.getParameter("id");
        if (isFormSubmission(request) && StringUtils.isNotBlank(metricId)) {
        // if (StringUtils.isNotBlank(metricId)) {
            return metricDefinitionManager.get(new Long(metricId));
        }
        return new MetricDefinition();
    }

    @Autowired
    public void setLookupManager(LookupManager lookupManager) {
		this.lookupManager = lookupManager;
	}
    
}
