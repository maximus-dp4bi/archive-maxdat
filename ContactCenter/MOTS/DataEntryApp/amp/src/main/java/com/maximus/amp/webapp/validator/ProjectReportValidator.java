package com.maximus.amp.webapp.validator;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.maximus.amp.Constants;
import com.maximus.amp.model.ComparisonMetric;
import com.maximus.amp.model.Metric;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricValidationRule;
import com.maximus.amp.model.MetricValidationRule.MetricValueLocation;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ValidationResult;
import com.maximus.amp.service.LookupManager;
import com.maximus.amp.service.ProjectReportManager;

@Component(value="projectReportValidator")
public class ProjectReportValidator implements Validator {
	


	protected final Log log = LogFactory.getLog(getClass());
	
    @Autowired
    @Qualifier(value="beanValidator")
    Validator validator;
    
    @Autowired
    @Qualifier(value="lookupManager")
    private LookupManager lookupManager;
    
    @Autowired
    @Qualifier(value="projectReportManager")
    private ProjectReportManager projectReportManager;    
    
    @Autowired
    @Qualifier(value="expressionEvaluator")
    private ExpressionEvaluator expressionEvaluator;

	protected ValidationResult evaluateExpressionRule(Float value, String comment, ProjectReport projectReport, MetricValidationRule rule, ValidationResult validationResult) {

		if(log.isDebugEnabled()) log.debug(rule.getRuleName());
		
	    Map<String, Object> variables = new HashMap<String, Object>();
	    variables.put("metric", value);
		
		Metric compMetric = null;
		BigDecimal compValue = null;
		
		for(ComparisonMetric comparisonMetric : rule.getComparisonMetricSet()){
			
			MetricDefinition compMetricDef = comparisonMetric.getCompMetricDefinition();
			MetricValueLocation compMetricValueLocation = comparisonMetric.getCompMetricValueLocation();
			
			if(log.isDebugEnabled()) log.debug("compMetricDef:  " + compMetricDef.getMetricName());
			if(log.isDebugEnabled()) log.debug("compMetricValueLocation:  " + compMetricValueLocation.name());
			
			if(compMetricValueLocation.equals(MetricValueLocation.CURRENT_ACTUAL)) {
				
				compMetric = projectReport.getMetrics().get(compMetricDef.getId());
				if(compMetric != null) compValue = compMetric.getActualValue();
				
			} else if(compMetricValueLocation.equals(MetricValueLocation.CURRENT_FORECAST)) {
				
				compMetric = projectReport.getMetrics().get(compMetricDef.getId());
				if(compMetric != null) compValue = compMetric.getForecastValue();
				
			} else if(compMetricValueLocation.equals(MetricValueLocation.PRIOR_ACTUAL)) {
				
				// TODO:  optimize and pull up to validate(ProjectReport projectReport) method so that it is only happening once per validation
				ProjectReport priorActualsReport = projectReportManager.getPriorProjectReport(projectReport, Constants.ACTUALS);
				if(priorActualsReport == null) { return validationResult; }
				
				compMetric = priorActualsReport.getMetrics().get(compMetricDef.getId());
				if(compMetric != null) compValue = compMetric.getActualValue();
				
			} else if(compMetricValueLocation.equals(MetricValueLocation.PRIOR_FORECAST)) {
				
				// TODO:  optimize and pull up to validate(ProjectReport projectReport) method so that it is only happening once per validation				
				ProjectReport priorForecastReport = projectReportManager.getPriorProjectReport(projectReport, Constants.FORECASTS);
				if(priorForecastReport == null) { return validationResult; }
				
				if(log.isDebugEnabled()) log.debug("compMetricDef.id:  " + compMetricDef.getId());
				compMetric = priorForecastReport.getMetrics().get(compMetricDef.getId());
				
				if(log.isDebugEnabled()) log.debug("compMetric:  " + compMetric);
				if(compMetric != null) compValue = compMetric.getForecastValue();
				
			}
			
			if(log.isDebugEnabled()) log.debug("comp value:  " + compValue);
			
			if(compValue == null) { return validationResult; }
		    
			//  using float value as the expression engine was interpreting BigDecimal values without
			//  decimal places as integers..
		    variables.put(comparisonMetric.getAlias(), compValue.floatValue());
		}
				
		Boolean result = expressionEvaluator.evaluateBooleanExpression(rule.getRuleExpression(), variables);

		if(log.isDebugEnabled()) log.debug("validation result:  " + result);
		
	    if(result == false) {
	    	
	    	// TODO:  refactor this to be error code (ERROR vs. WARNING)??
	    	String errorCode = rule.getRuleValidationType();
	    	
	    	if(rule.getPreventSubmit() && rule.getAllowIgnoreWithComment() && StringUtils.isEmpty(comment)) {
	    		errorCode = Constants.ERROR;
	    	} else if (rule.getAllowIgnoreWithComment() && StringUtils.isNotEmpty(comment)) {
	    		// TODO:  log that a rule was ignored because of a comment ...
	    		errorCode = Constants.WARNING;
	    	}
	    	
	    	validationResult.addMessage(errorCode, rule.getRuleMessage());
	    }
	    
    	return validationResult;

	}
	
	private void rejectValue(Errors errors, String field, Pair<String, String> message) {
		
		errors.rejectValue(field, message.getLeft().toString(), "* " + message.getRight());
		
	}

	@Override
	public boolean supports(Class<?> clazz) {
		
		return ProjectReport.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		long start = System.currentTimeMillis();
		
		log.debug("validate");
		
		validator.validate(target, errors);
		
		if (errors.hasErrors()) { return; }
		
		ProjectReport projectReport = (ProjectReport) target;
		
		List<ValidationResult> validationResultList = validate(projectReport);

		for(ValidationResult result : validationResultList) {
			
			//  when validation is evaluated on submission of the form
			//  we only want to reject values if they contain an error
			//  not if they only contain a warning .. 
			if(result.isHasError()) {
				for(Pair<String, String> message : result.getMessages()) {
					rejectValue(errors, result.getField(), message);
				}
			}
		}
		
		long end = System.currentTimeMillis();
		log.debug("time elapsed during validation:  " + (end-start) + " ms.");
		
	}
	
	public List<ValidationResult> validate(ProjectReport projectReport) {
		
		List<ValidationResult> validationResultList = new ArrayList<ValidationResult>();
		
		String fieldSuffix = null;
		
		switch(projectReport.getType()){
			case Constants.ACTUALS : 
				fieldSuffix = Constants.DOT_ACTUAL_VALUE;
				break;
			case Constants.FORECASTS :
				fieldSuffix = Constants.DOT_FORECAST_VALUE;
				break;
		}
		
		// validate metrics
		for(Long key : projectReport.getMetrics().keySet()) {
		
			Metric metric = projectReport.getMetrics().get(key);
			
			//TODO:  review to see if this can be pushed up into AJAX method..
			if(metric.getMetricDefinition() == null) {
				metric.setMetricDefinition(lookupManager.getOneOfTypeById(MetricDefinition.class, key));
			}
			
			String field = "metrics['" + key.toString() + "']" + fieldSuffix;
						
			ValidationResult validationResult = validateMetric(projectReport, metric, field);
			
			if(!validationResult.getIsValid()) {
				validationResultList.add(validationResult);
			}
		
		}
		
		return validationResultList;
	}

//	// TODO:  consolidate this method..
//	public List<ValidationResult> validateAJAX(ProjectReport projectReport) {
//
//		List<ValidationResult> validationResultList = validate(projectReport);
//
//		return validationResultList;
//		
//	}

	protected ValidationResult validateBounds(final String reportType, final Metric metric, ValidationResult validationResult) {
		
		Long lowerBound = metric.getMetricDefinition().getLowerBound();
		Long upperBound = metric.getMetricDefinition().getUpperBound();
		
		if(reportType.equals(ProjectReport.ReportType.ACTUALS.toString())) {
			
			BigDecimal actualValue = metric.getActualValue();
			
			if(actualValue != null && lowerBound != null && actualValue.longValue() < lowerBound) {
				validationResult.addMessage(Constants.ERROR, metric.getMetricDefinition().getMetricName() + Constants._ACTUAL_ + Constants.VALUE_CANNOT_BE_LESS_THAN + lowerBound);
			}
			
			if(actualValue != null && upperBound != null && actualValue.longValue() > upperBound) {
				validationResult.addMessage(Constants.ERROR, metric.getMetricDefinition().getMetricName() + Constants._ACTUAL_ + Constants.VALUE_CANNOT_BE_GREATER_THAN + upperBound);
			}
			
			
		} else if(reportType.equals(ProjectReport.ReportType.FORECASTS.toString())) {
		
			BigDecimal forecastValue = metric.getForecastValue();
			
			if(forecastValue != null && lowerBound != null && forecastValue.longValue() < lowerBound) {
				validationResult.addMessage(Constants.ERROR, metric.getMetricDefinition().getMetricName() + Constants._FORECAST_ + Constants.VALUE_CANNOT_BE_LESS_THAN + lowerBound);
			}
			
			if(forecastValue != null && upperBound != null && forecastValue.longValue() > upperBound) {
				validationResult.addMessage(Constants.ERROR, metric.getMetricDefinition().getMetricName() + Constants._FORECAST_ + Constants.VALUE_CANNOT_BE_GREATER_THAN + upperBound);
			}
		}
		
		return validationResult;
	}



	public ValidationResult validateMetric(ProjectReport projectReport, Metric metric, String field) {
		ValidationResult validationResult = new ValidationResult(field);
		
		if(metric.getMetricDefinition().hasBounds()){
			validationResult = validateBounds(projectReport.getType(), metric, validationResult);
		}
		
		Set<MetricValidationRule> ruleSet = metric.getMetricDefinition().getRulesForReportType(projectReport.getType());
		if(ruleSet.size() > 0) {
			validationResult = validateRules(projectReport, metric, validationResult);
		}
		return validationResult;
	}
	
	private ValidationResult validateRules(ProjectReport projectReport, Metric metric, ValidationResult validationResult) {
		
		BigDecimal value = null;
		String comment = null;
		
		switch(projectReport.getType()){
			case Constants.ACTUALS : 
				value= metric.getActualValue();
				comment = metric.getActualComments();
				break;
			case Constants.FORECASTS :
				value = metric.getForecastValue();
				comment = metric.getForecastComments();
				break;
		}
		
		// CODEREVIEW:  this could be evaluated earlier and optimize the validation routine to execute fewer lines of code
		if(value == null) return validationResult;
		
		Set<MetricValidationRule> ruleSet = metric.getMetricDefinition().getRulesForReportType(projectReport.getType());
		for(MetricValidationRule rule : ruleSet) {
			// CODEREVIEW:  getIsExpressionRule can probably be removed
			if (rule.getIsExpressionRule() && rule.getRuleExpression()!= null) {
				evaluateExpressionRule(value.floatValue(), comment, projectReport, rule, validationResult);
			}
		}
		
		return validationResult;
		
	}

}
