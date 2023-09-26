package com.maximus.amp.webapp.validator;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

import java.math.BigDecimal;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;

import com.maximus.amp.dao.GenericDao;
import com.maximus.amp.model.Metric;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ValidationResult;
import com.maximus.amp.service.ProjectReportManager;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
    "classpath:/applicationContext-resources.xml",
    "classpath:/applicationContext-dao.xml",
    "classpath:/applicationContext-service.xml",
    "classpath:/applicationContext-test.xml",
    "/WEB-INF/applicationContext.xml",
    "/WEB-INF/applicationContext-validation.xml"
})
@Transactional
public class ProjectReportValidatorTest {
	
	protected final transient Log log = LogFactory.getLog(getClass());

	@Autowired
	ProjectReportManager manager = null;
	
	@Autowired
	@Qualifier(value="metricDefinitionDao")
	GenericDao<MetricDefinition, Long> metricDefinitionDao = null;
	
	@Autowired
	@Qualifier(value="projectReportValidator")
	ProjectReportValidator validator = null;
	

	
	@Test
	@WithUserDetails(value="user")
	public void testValidateBounds() {

		MetricDefinition abRateDef = metricDefinitionDao.get(-11L);
		ProjectReport projectReport = manager.get(-2L);
		
		Metric abRate = projectReport.getMetrics().get(abRateDef.getId());
		abRate.setActualValue(BigDecimal.valueOf(-10));
		
		BindException errors = new BindException(projectReport, "projectReport");
		validator.validate(projectReport, errors);
		
		assertThat(errors.getErrorCount(), is(1));
		
		errors = new BindException(projectReport, "projectReport");
		abRate.setActualValue(BigDecimal.valueOf(55));
		
		validator.validate(projectReport, errors);		
		assertThat(errors.getErrorCount(), is(0));
		
	}
	
	@Test
	@WithUserDetails(value="user")
	public void testCallsOfferedCannotExceedCallsCreated() {

		ProjectReport projectReport = manager.get(-6L);
		
		Metric callsCreated = projectReport.getMetricByDef(metricDefinitionDao.get(-1L));
		Metric callsOffered = projectReport.getMetricByDef(metricDefinitionDao.get(-3L));
		Metric callsHandled = projectReport.getMetricByDef(metricDefinitionDao.get(-4L));
		
		callsCreated.setActualValue(BigDecimal.valueOf(75));
		callsOffered.setActualValue(BigDecimal.valueOf(210));
		callsOffered.setActualComments("");
		callsHandled.setActualValue(BigDecimal.valueOf(74));
		
		// manager.save(projectReport);
		
		BindException errors = new BindException(projectReport, "projectReport");
		
		validator.validate(projectReport, errors);
		
		assertThat(errors.getErrorCount(), is(2));
		
		int errorCount = 0, warningCount = 0;
		
		for(FieldError e : errors.getFieldErrors()) {
			if(e.getCode().equals("ERROR")) { errorCount++; }
			else if(e.getCode().equals("WARNING")) { warningCount++; }
		}
		
		assertThat(errorCount, is(2));
		assertThat(warningCount, is(0));
		
		errors = new BindException(projectReport, "projectReport");
		callsCreated.setActualValue(BigDecimal.valueOf(211));
		callsOffered.setActualComments("Ignore me..");
		
		List<ValidationResult> validationResults = validator.validate(projectReport);
		
		errorCount = 0; 
		warningCount = 0;
		
		for(ValidationResult r : validationResults) {
			if(r.isHasError()) { errorCount++; }
			else if(r.isHasWarning()) { warningCount++; }
		}
		
		assertThat(errorCount, is(0));
		assertThat(warningCount, is(1));
		
	}
	
	@Test
	@WithUserDetails(value="user")
	public void testIgnoreCallsHandledCannotExceedCallsCreated() {
		
		ProjectReport projectReport = manager.get(-6L);
		
		
		Metric callsCreated = projectReport.getMetricByDef(metricDefinitionDao.get(-1L));
		Metric callsOffered = projectReport.getMetricByDef(metricDefinitionDao.get(-3L));
		Metric callsHandled = projectReport.getMetricByDef(metricDefinitionDao.get(-4L));
		
		callsCreated.setActualValue(BigDecimal.valueOf(100));
		callsOffered.setActualValue(BigDecimal.valueOf(99));
		callsHandled.setActualValue(BigDecimal.valueOf(210));
		callsHandled.setActualComments("");
		
		// manager.save(projectReport);
		
		BindException errors = new BindException(projectReport, "projectReport");
		
		validator.validate(projectReport, errors);
		
		assertThat(errors.getErrorCount(), is(1));
		
		List<ValidationResult> validationResults = validator.validate(projectReport);
		
		int errorCount = 0; 
		int warningCount = 0;
		
		for(ValidationResult vr : validationResults) {
			if(vr.isHasError()) { errorCount++; }
			else if(vr.isHasWarning()) { warningCount++; }
		}
		
		assertThat(errorCount, is(1));
		assertThat(warningCount, is(0));
		
		// callsCreated.setActualValue(BigDecimal.valueOf(211));
		callsHandled.setActualComments("Ignore me..");
		
		validationResults = validator.validate(projectReport);
		
		errorCount = 0; 
		warningCount = 0;
		
		for(ValidationResult vr : validationResults) {
			if(vr.isHasError()) { errorCount++; }
			else if(vr.isHasWarning()) { warningCount++; }
		}
		
		assertThat(errorCount, is(0));
		assertThat(warningCount, is(1));
		
	}
	

	
}
