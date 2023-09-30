package com.maximus.amp.service;


import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.hamcrest.Matchers.nullValue;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.security.test.context.support.WithUserDetails;

import com.maximus.amp.Constants;
import com.maximus.amp.dao.GenericDao;
import com.maximus.amp.model.ActualsReport;
import com.maximus.amp.model.ForecastsReport;
import com.maximus.amp.model.GeographyMaster;
import com.maximus.amp.model.Metric;
import com.maximus.amp.model.Program;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ProjectReport;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.ReportingPeriod.ReportingPeriodType;
import com.maximus.amp.model.User;


@Transactional
public class ProjectReportManagerTest extends BaseManagerTestCase {
	
	@Autowired
	ProjectReportManager projectReportManager = null;
	
	@Autowired 
	LookupManager lookupManager = null;
	
	@Autowired 
	UserManager userManager = null;
	
	@Autowired 
	GenericDao<Metric, Long> metricDao;
	
	@Rule
	public final ExpectedException exception = ExpectedException.none();
	
	protected ProjectReport createActualsReport(Project project, Program program, GeographyMaster geographyMaster, ReportingPeriod reportingPeriod) {
		ProjectReport actualsReport = new ActualsReport(project, program, geographyMaster, reportingPeriod);
		actualsReport.setFunctionalArea("Contact Center");
		actualsReport.setCreatedBy("admin");
		actualsReport.setCreatedDate(new Date());
		actualsReport.setModifiedBy("admin");
		actualsReport.setModifiedDate(new Date());
		return projectReportManager.save(actualsReport);
	}
	
	private ProjectReport createAndInitializeActualsReport(Project project, Program program, GeographyMaster geographyMaster, ReportingPeriod reportingPeriod) {
		return projectReportManager.initializeMetrics(createActualsReport(project, program, geographyMaster, reportingPeriod));
	}
	
	
	private ProjectReport createAndInitializeForecastsReport(Project project, Program program, GeographyMaster geographyMaster, ReportingPeriod reportingPeriod) {
		return projectReportManager.initializeMetrics(createForecastsReport(project, program, geographyMaster, reportingPeriod));
	}
	
	protected ProjectReport createForecastsReport(Project project, Program program, GeographyMaster geographyMaster, ReportingPeriod reportingPeriod) {
		ProjectReport forecastsReport = new ForecastsReport(project, program, geographyMaster, reportingPeriod);
		forecastsReport.setFunctionalArea("Contact Center");
		forecastsReport.setCreatedBy("admin");
		forecastsReport.setCreatedDate(new Date());
		forecastsReport.setModifiedBy("admin");
		forecastsReport.setModifiedDate(new Date());
		return projectReportManager.save(forecastsReport);
	}
	
	
	@Test
	public void testCalculateActualForecastVarianceFormat() {
		
		ProjectReport projectReport = projectReportManager.get(-2L);
		
		Metric metric3 = projectReport.getMetrics().get(-3L);
		Metric metric2 = projectReport.getMetrics().get(-2L);
		Metric metric1 = projectReport.getMetrics().get(-1L);
		
		metric3.setActualValue(BigDecimal.valueOf(96));
		metric2.setActualValue(BigDecimal.valueOf(80));
		metric1.setActualValue(BigDecimal.valueOf(75));
		
		projectReport = projectReportManager.save(projectReport);
		
		metric3 = projectReport.getMetrics().get(-3L);
		metric2 = projectReport.getMetrics().get(-2L);
		metric1 = projectReport.getMetrics().get(-1L);
		
		assertThat(metric3.getActualForecastVarianceFormat(), is(equalTo(3L)));
		assertThat(metric2.getActualForecastVarianceFormat(), is(equalTo(2L)));
		assertThat(metric1.getActualForecastVarianceFormat(), is(equalTo(1L)));
		
	}

	@Test
	public void testGetAvailableReportingPeriods() {
		
		List<ReportingPeriod> reportingPeriods = projectReportManager.getAvailableReportingPeriods("Contact Center", ReportingPeriodType.WEEKLY.getValue(), "-1", "-1", "-1", "actuals", "2015");
		
		assertThat(reportingPeriods, is(notNullValue()));
		assertThat(reportingPeriods.size(), greaterThan(3));
	}

	@Test
	public void testGetPriorProjectReport() {
		
		ProjectReport projectReport = projectReportManager.get(-6L);
		
		ProjectReport priorProjectReport = projectReportManager.getPriorProjectReport(projectReport, Constants.ACTUALS);
		
		assertThat(priorProjectReport.getId(), equalTo(-2L));
	}
	
	@Test
	public void testGetProjectByName() {
		Project project = projectReportManager.getProjectById("-1");
		
		assertThat(project, is(notNullValue()));
	}
	
	@Test
	public void testGetProjectReportsByUserDetails() {
		
		User user = userManager.getUserByUsername("user");
		
		List<ProjectReport> projectReports = projectReportManager.getProjectReportsByUserDetails(user, ProjectReport.ReportType.ACTUALS.toString());
		
		assertNotNull(projectReports);
		assertThat(projectReports.size(), is(equalTo(9)));

	}
	
	@Test
	@WithUserDetails(value="user")
	public void testInitializeBackOfficeForecastMetrics() {
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -3L);
		
		
		ProjectReport forecastsReport = new ForecastsReport(project, program, geographyMaster, reportingPeriod);
		forecastsReport.setFunctionalArea("Back Office");
		forecastsReport.setCreatedBy("admin");
		forecastsReport.setCreatedDate(new Date());
		forecastsReport.setModifiedBy("admin");
		forecastsReport.setModifiedDate(new Date());
		
		forecastsReport = projectReportManager.save(forecastsReport);
		
		projectReportManager.initializeMetrics(forecastsReport);
		
		forecastsReport = projectReportManager.save(forecastsReport);
		
		assertThat(forecastsReport.getMetrics(), is(notNullValue()));
		assertThat(forecastsReport.getMetrics().size(), is(equalTo(4)));
		
	}
	
	
	@Test
	@WithUserDetails(value="user")
	public void testInitializeForecastAndThenActualsMetrics() {
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -1L);
		
		ProjectReport forecastsReport = createForecastsReport(project, program, geographyMaster, reportingPeriod);
		
		forecastsReport = projectReportManager.save(forecastsReport);
		Long forecastReportId = forecastsReport.getId();
		
		projectReportManager.initializeMetrics(forecastsReport);
		
		forecastsReport = projectReportManager.get(forecastReportId);
		
//		assertThat(forecastsReport.getMetrics(), is(notNullValue()));
//		assertThat(forecastsReport.getMetrics().size(), is(greaterThan(6)));
		
		log.debug("initialize actuals");
		
		ProjectReport actualsReport = createActualsReport(project, program, geographyMaster, reportingPeriod);
		
		actualsReport = projectReportManager.save(actualsReport);
		
		projectReportManager.initializeMetrics(actualsReport);
		
		actualsReport = projectReportManager.save(actualsReport);
		
		assertThat(actualsReport.getMetrics(), is(notNullValue()));
		assertThat(actualsReport.getMetrics().size(), equalTo(forecastsReport.getMetrics().size()));

	}

	@Test
	@WithUserDetails(value="user")
	public void testInitializeForecastMetrics() {
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -3L);
		
		
		ProjectReport forecastsReport = createForecastsReport(project, program,
				geographyMaster, reportingPeriod);
		
		forecastsReport = projectReportManager.save(forecastsReport);
		
		projectReportManager.initializeMetrics(forecastsReport);
		
		forecastsReport = projectReportManager.save(forecastsReport);
		
		assertThat(forecastsReport.getMetrics(), is(notNullValue()));
		assertThat(forecastsReport.getMetrics().size(), is(equalTo(12)));
		
	}
	
	@Test
	@WithUserDetails(value="user")
	public void testRemoveForecastsReportWithNoActualsReport() {
		
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 99);
		
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -4L);
		
		ProjectReport forecastsReport = createAndInitializeForecastsReport(project, program, geographyMaster, reportingPeriod);
		Long forecastReportId = forecastsReport.getId();
		
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 111);
				
		projectReportManager.remove(forecastsReport);
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 99);
		
		exception.expect(ObjectRetrievalFailureException.class);
		projectReportManager.get(forecastReportId);
		
	}
	
	@Test
	@WithUserDetails(value="user")
	public void testRemoveForecastsReportWithActualsReport() {
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -4L);
		
		createAndInitializeActualsReport(project, program, geographyMaster, reportingPeriod);
		ProjectReport forecastsReport = createAndInitializeForecastsReport(project, program, geographyMaster, reportingPeriod);
		Long forecastReportId = forecastsReport.getId();
				
		projectReportManager.remove(forecastsReport);
		
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 111);
		
		exception.expect(ObjectRetrievalFailureException.class);
		projectReportManager.get(forecastReportId);
		
	}
	
	@Test
	@WithUserDetails(value="user")
	public void testRemoveActualssReportWithNoForecastsReport() {
		
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 99);
		
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -4L);
		
		ProjectReport actualsReport = createAndInitializeActualsReport(project, program, geographyMaster, reportingPeriod);
		Long actualsReportId = actualsReport.getId();
		
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 111);
				
		projectReportManager.remove(actualsReport);
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 99);
		
		exception.expect(ObjectRetrievalFailureException.class);
		projectReportManager.get(actualsReportId);
		
	}
	
	@Test
	@WithUserDetails(value="user")
	public void testRemoveActualsReportWithForecastsReport() {
		
		Project project = lookupManager.getOneOfTypeById(Project.class, -1L);
		Program program = lookupManager.getOneOfTypeById(Program.class, -1L);
		GeographyMaster geographyMaster = lookupManager.getOneOfTypeById(GeographyMaster.class, -1L);
		ReportingPeriod reportingPeriod = lookupManager.getOneOfTypeById(ReportingPeriod.class, -4L);
		
		createAndInitializeForecastsReport(project, program, geographyMaster, reportingPeriod);
		ProjectReport actualsReport = createAndInitializeActualsReport(project, program, geographyMaster, reportingPeriod);
		Long actualsReportId = actualsReport.getId();
				
		projectReportManager.remove(actualsReport);
		
		assertThatCollectionSizeEqualTo(metricDao.getAll(), 111);
		
		exception.expect(ObjectRetrievalFailureException.class);
		projectReportManager.get(actualsReportId);
		
	}



}
