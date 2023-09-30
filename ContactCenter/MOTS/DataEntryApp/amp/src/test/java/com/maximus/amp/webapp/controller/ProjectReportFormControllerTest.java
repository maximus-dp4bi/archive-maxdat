package com.maximus.amp.webapp.controller;

import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.isA;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import javax.servlet.Filter;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithSecurityContextTestExecutionListener;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;
import org.springframework.test.context.web.ServletTestExecutionListener;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.maximus.amp.model.ActualsReport;
import com.maximus.amp.model.ForecastsReport;

@Transactional
@TestExecutionListeners(listeners={ServletTestExecutionListener.class,
	    DependencyInjectionTestExecutionListener.class,
	    DirtiesContextTestExecutionListener.class,
	    TransactionalTestExecutionListener.class,
	    WithSecurityContextTestExecutionListener.class})
public class ProjectReportFormControllerTest extends BaseControllerTestCase {
    
	@Autowired
    private Filter springSecurityFilterChain;
	
	@Autowired
    private ProjectReportFormController controller;
    private MockMvc mockMvc;
    
    
    @Before
    public void setUp() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/pages/");
        viewResolver.setSuffix(".jsp");

        mockMvc = MockMvcBuilders.standaloneSetup(controller)
//        		.addFilters(springSecurityFilterChain)
        		.setViewResolvers(viewResolver)
        		.build();

    }

    @Test
    @WithUserDetails("user")
    public void testAddActuals() throws Exception {
        log.debug("testing add...");
        mockMvc.perform(
        		get("/report/add/actuals")
        ).andExpect(status().isOk())
        .andExpect(model().attributeExists("projectReport"))
        .andExpect(model().attribute("projectReport", isA(ActualsReport.class)))
        .andExpect(view().name("addProjectReportForm"));
    }

    @Test
    @WithUserDetails("user")
    public void testAddForecasts() throws Exception {
        log.debug("testing add...");
        mockMvc.perform(
        		get("/report/add/forecasts")
        ).andExpect(status().isOk())
        .andExpect(model().attributeExists("projectReport"))
        .andExpect(model().attribute("projectReport", isA(ForecastsReport.class)))
        .andExpect(view().name("addProjectReportForm"));
    }
    
    @Test
    @WithUserDetails("user")
    public void testEdit() throws Exception {
        log.debug("testing edit...");
        mockMvc.perform(get("/report/edit/actuals/-1"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("projectReport"));
    }

    @Test
    @WithUserDetails("user")
    public void testSave() throws Exception {
    	
    	// TODO:  review why the object to be authorized is a Project and not a ProjectReport
        HttpSession session = mockMvc.perform(
        	post("/report/submit")
        		.param("id", "-1")
        	)
            .andExpect(model().hasNoErrors())
        	.andExpect(status().is3xxRedirection())
            .andReturn()
            .getRequest()
            .getSession();

        assertNotNull(session.getAttribute("successMessages"));
    }

    @Test
    @WithUserDetails("admin")
    @Ignore("disabling delete")
    public void testRemove() throws Exception {
        HttpSession session = mockMvc.perform((post("/report/submit"))
            .param("delete", "").param("id", "-2"))
            .andExpect(status().is3xxRedirection())
            .andReturn().getRequest().getSession();

        assertNotNull(session.getAttribute("successMessages"));
    }
    
    @Test
    @WithUserDetails("user")
    public void testGetProjectOptions() throws Exception {
        mockMvc.perform(
        		(get("/report/project"))
        		.param("projectId", "-1")
            )
            .andExpect(status().isOk())
            .andExpect(content().string(containsString("programOptions")))
            .andExpect(content().string(containsString("geographyMasterOptions")));

    }
    
    @Test
    @WithUserDetails("user")
    public void testGetReportingPeriodOptions() throws Exception {
        mockMvc.perform(
        		(get("/report/reportingPeriods"))
        		.param("functionalArea", "Contact Center")
    			.param("reportingPeriodType", "WEEKLY")
    			.param("projectId", "-1")
    			.param("programId", "-1")
    			.param("geographyMasterId", "-1")
    			.param("reportType", "actuals")
    			.param("reportingPeriodYear", "2015")
            )
            .andExpect(status().isOk())
            .andExpect(content().contentType(APPLICATION_JSON_UTF8))
            .andExpect(jsonPath("$", hasSize(8)));

    }
        
	@Test
    @WithUserDetails("user")
    public void testValidateAJAX() throws Exception {
    	String projectReportJSON = "{"
	    	+"\"id\":\"-6\","
	    	+"\"type\":\"actuals\","
	    	+"\"functionalArea\":\"Contact Center\","
			+"\"reportingPeriod\":{ \"id\":\"-15\"}," //, \"type\":\"weekly\", \"startDate\":\"06/07/2015\", \"endDate\":\"06/13/2015\"},"
			+"\"project\":{ \"id\":\"-1\"},"
			+"\"program\":{ \"id\":\"-1\"},"
			+ "\"geographyMaster\":{ \"id\":\"-1\"},"
	    	+"\"metrics\": {"
		    	+ "\"-1\":{\"actualValue\":\"20.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-2\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-3\":{\"actualValue\":\"100.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-4\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-5\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-6\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-7\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-8\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-9\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-10\":{\"actualValue\":\"120.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
		    	+",\"-11\":{\"actualValue\":\"100.0\",\"actualComments\":\"\",\"actualValueNotSupplied\":\"false\"}"
	    	+"}"
	    	+ "}";
    	
    	log.debug(projectReportJSON);
    	
    	MvcResult result = mockMvc.perform(
                post("/report/validateActualValue")
                .contentType(MediaType.APPLICATION_JSON)
                .content(projectReportJSON))
                .andExpect(status().isOk())
                .andReturn();
    	
    	log.debug(result.getResponse().getContentAsString());
    	
    	ObjectMapper mapper = new ObjectMapper();
    	
    	JsonNode rootNode = mapper.readValue(result.getResponse().getContentAsString(), JsonNode.class);
    	
    	//  since calls offered (-3) and calls handled (-4) exceed calls created (-1), there should be 2 child elements
    	assertThat(rootNode.size(), equalTo(2));
    	assertThat(rootNode.get(0).get("isValid").asBoolean(), equalTo(false));
    	
    	
    	
    }
}
