package com.maximus.amp.webapp.controller;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.DataBinder;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.model.ComparisonMetric;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricValidationRule;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;

@Controller
@RequestMapping("/admin/comparisonMetric")
public class ComparisonMetricFormController extends BaseFormController {
	
    private GenericManager<ComparisonMetric, Long> comparisonMetricManager = null;
    private LookupManager lookupManager = null;

    public ComparisonMetricFormController() {
        setCancelView("redirect:/admin/validationRule/edit");
        setSuccessView("redirect:/admin/validationRule/edit");
    }
    
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        binder.registerCustomEditor(MetricDefinition.class, "compMetricDefinition", new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	            if (!text.isEmpty()){
	            	MetricDefinition md = lookupManager.getOneOfTypeById(MetricDefinition.class, Long.parseLong(text));
	            	setValue(md);
	            }
	        }
        });
    }

    
    private void initModel(Model model, ComparisonMetric comparisonMetric) {
        
    	model.addAttribute("comparisonMetric", comparisonMetric);
    	
    	List<MetricDefinition> metrics = lookupManager.getMetricDefinitionsSortedByFuncAreaAndName();
    	List<String> metricValueLocations = new ArrayList<String>();
    	
    	for(MetricValidationRule.MetricValueLocation loc : MetricValidationRule.MetricValueLocation.values()){
    		metricValueLocations.add(loc.name());
    	}
    	
        model.addAttribute("metricDefinitions", convertBaseObjectCollectionToLabelValues(null, metrics));
        model.addAttribute("metricValueLocations", convertStringsToLabelValues(null, metricValueLocations));
    }

    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("comparisonMetric")
    protected ComparisonMetric loadComparisonMetric(final HttpServletRequest request) {
        final String id = request.getParameter("id");
        if (isFormSubmission(request) && StringUtils.isNotBlank(id)) {
        // if (StringUtils.isNotBlank(metricId)) {
            return comparisonMetricManager.get(new Long(id));
        }
        return new ComparisonMetric();
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String onSubmit(@ModelAttribute("comparisonMetric") ComparisonMetric comparisonMetric, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response 
//    		, @AuthenticationPrincipal User activeUser
    		, Model model) throws Exception {
    	
    	//  TODO:  it appears that this should be able to be done via the @AuthenticationPrincipal annotated method param;
    	UserDetails currentUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		return getCancelView() + "/" + comparisonMetric.getMetricValidationRule().getId();
    	}

        if (validator != null) { // validator is null during testing
            validator.validate(comparisonMetric, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
                initModel(model, comparisonMetric);
            	return "admin/validationRuleForm";
            }
        }

        log.debug("entering 'onSubmit' method...");

        boolean isNew = (comparisonMetric.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
        	comparisonMetricManager.remove(comparisonMetric.getId());
            saveMessage(request, getText("comparisonMetric.deleted", locale));
        } else {
        	
        	comparisonMetricManager.save(comparisonMetric);
            String key = (isNew) ? "comparisonMetric.added" : "comparisonMetric.updated";
            saveMessage(request, getText(key, locale));
        }

        return getSuccessView() + "/" + comparisonMetric.getMetricValidationRule().getId();
    }


	@Autowired
    public void setLookupManager(@Qualifier("lookupManager") LookupManager lookupManager) {
        this.lookupManager = lookupManager;
    }
    
    
    @Autowired
    public void setComparisonMetricManager(@Qualifier("comparisonMetricManager") GenericManager<ComparisonMetric, Long> comparisonMetricManager) {
        this.comparisonMetricManager = comparisonMetricManager;
    }
    
    @ModelAttribute
    @RequestMapping(value="/{action}/{id}", method=RequestMethod.GET)
    protected ModelAndView showForm(
    		HttpServletRequest request
 			, @PathVariable(value="id") Long id
 			, @PathVariable(value="action") String action) {

    	ComparisonMetric comparisonMetric = null;
    	if(action.equals("add") && id != null) {
    		MetricValidationRule validationRule = lookupManager.getOneOfTypeById(MetricValidationRule.class, id);
    		comparisonMetric = new ComparisonMetric(validationRule);
    	} else if (action.equals("edit") && id != null) {
    		comparisonMetric = comparisonMetricManager.get(id);
    	} else {
    		return null;
    	}
    	
    	Model model = new ExtendedModelMap();
    	initModel(model, comparisonMetric);
    	
    	return new ModelAndView("admin/comparisonMetricForm", model.asMap());

    }

}
