package com.maximus.amp.service;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;
import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.maximus.amp.model.ActualsReport;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ReportingPeriod;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
    "classpath:/applicationContext-resources.xml",
    "classpath:/applicationContext-dao.xml",
    "classpath:/applicationContext-service.xml",
    "classpath:/applicationContext-test.xml"
})
@Transactional
public class LookupManagerTest extends BaseManagerTestCase {

	@Autowired
	LookupManager lookupManager;
	
	// TODO:  mock the dao in this test ...
	@Test
	public void testGetPriorReportingPeriod() {
    	ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -2L);
    	ActualsReport actualsReport = new ActualsReport();
    	actualsReport.setReportingPeriod(reportingPeriod);
    	
    	ReportingPeriod priorReportingPeriod = lookupManager.getPriorReportingPeriod(actualsReport);
    	
    	assertThat(priorReportingPeriod.getId(), equalTo(-1L));		
	}
	
	@Test
	public void testGetMetricsForProject() {
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		List<MetricProject> metricProjects = lookupManager.getMetricProjects(project);
		
		assertThat(metricProjects, notNullValue());
		assertThat(metricProjects.size(), equalTo(17));
	}
	
	
	@Test
	public void testGetNewMetricDefinitions() {
		
		List<MetricDefinition> metricDefs = lookupManager.getNewMetricDefinitions(-1L, -1L, -1L);
		
		assertThat(metricDefs, notNullValue());
		assertThat(metricDefs.size(), equalTo(0));
		
		metricDefs = lookupManager.getNewMetricDefinitions(-2L, -2L, -2L);
		
		assertThat(metricDefs, notNullValue());
		assertThat(metricDefs.size(), equalTo(16));

	}
}
