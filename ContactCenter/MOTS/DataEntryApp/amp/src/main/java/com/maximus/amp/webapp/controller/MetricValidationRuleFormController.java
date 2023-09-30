package com.maximus.amp.webapp.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricValidationRule;
import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.LookupManager;

@Controller
@RequestMapping("/admin/validationRule")
public class MetricValidationRuleFormController extends BaseFormController {
	
    private GenericManager<MetricValidationRule, Long> ruleManager = null;
    private LookupManager lookupManager = null;

    public MetricValidationRuleFormController() {
        setCancelView("redirect:/admin/metricDefinitionForm/edit");
        setSuccessView("redirect:/admin/metricDefinitionForm/edit");
    }
    
    private void initModel(Model model, MetricValidationRule validationRule) {
        
    	model.addAttribute("validationRule", validationRule);
    	
    }

    /**
     * Load user object from db before web data binding in order to keep properties not populated from web post.
     * 
     * @param request
     * @return
     */
    @ModelAttribute("validationRule")
    protected MetricValidationRule loadValidationRule(final HttpServletRequest request) {
        final String id = request.getParameter("id");
        if (isFormSubmission(request) && StringUtils.isNotBlank(id)) {
        // if (StringUtils.isNotBlank(metricId)) {
            return ruleManager.get(new Long(id));
        }
        return new MetricValidationRule();
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String onSubmit(@ModelAttribute("validationRule") MetricValidationRule validationRule, 
    		BindingResult errors, 
    		HttpServletRequest request, 
    		HttpServletResponse response 
//    		, @AuthenticationPrincipal User activeUser
    		, Model model) throws Exception {
    	
    	//  TODO:  it appears that this should be able to be done via the @AuthenticationPrincipal annotated method param;
    	UserDetails currentUser = getCurrentUser();

    	if (request.getParameter("cancel") != null) {
    		return getCancelView() + "/" + validationRule.getMetricDefinition().getId();
    	}

        if (validator != null) { // validator is null during testing
            validator.validate(validationRule, errors);

            if (errors.hasErrors() && request.getParameter("delete") == null) { // don't validate when deleting
                initModel(model, validationRule);
            	return "admin/validationRuleForm";
            }
        }

        log.debug("entering 'onSubmit' method...");

        boolean isNew = (validationRule.getId() == null);
        Locale locale = request.getLocale();

        if (request.getParameter("delete") != null) {
        	ruleManager.remove(validationRule.getId());
            saveMessage(request, getText("validationRule.deleted", locale));
        } else {
        	
        	validationRule = ruleManager.save(validationRule);
            String key = (isNew) ? "validationRule.added" : "validationRule.updated";
            saveMessage(request, getText(key, locale));
        }
        
        if(request.getParameter("addComparisonMetric")!=null){
        	return "redirect:/admin/comparisonMetric/add/"+validationRule.getId();
        }

        return getSuccessView() + "/" + validationRule.getMetricDefinition().getId();
    }


	@Autowired
    public void setLookupManager(@Qualifier("lookupManager") LookupManager lookupManager) {
        this.lookupManager = lookupManager;
    }
    
    
    @Autowired
    public void setMetricValidationRuleManager(@Qualifier("metricValidationRuleManager") GenericManager<MetricValidationRule, Long> ruleManager) {
        this.ruleManager = ruleManager;
    }
    
    @ModelAttribute
    @RequestMapping(value="/{action}/{id}", method=RequestMethod.GET)
    protected ModelAndView showForm(
    		HttpServletRequest request
 			, @PathVariable(value="id") Long id
 			, @PathVariable(value="action") String action) {

    	MetricValidationRule rule = null;
    	if(action.equals("add") && id != null) {
    		MetricDefinition metricDefinition = lookupManager.getOneOfTypeById(MetricDefinition.class, id);
    		rule = new MetricValidationRule(metricDefinition);
    	} else if (action.equals("edit") && id != null) {
    		rule = ruleManager.get(id);
    	} else {
    		return null;
    	}
    	
    	Model model = new ExtendedModelMap();
    	initModel(model, rule);
    	
    	return new ModelAndView("admin/validationRuleForm", model.asMap());

    }

}
