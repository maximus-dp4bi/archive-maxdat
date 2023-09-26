package com.maximus.amp.webapp.controller;

import static org.hamcrest.Matchers.hasSize;
import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.test.context.support.WithSecurityContextTestExecutionListener;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;
import org.springframework.test.context.web.ServletTestExecutionListener;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Transactional
@TestExecutionListeners(listeners={ServletTestExecutionListener.class,
	    DependencyInjectionTestExecutionListener.class,
	    DirtiesContextTestExecutionListener.class,
	    TransactionalTestExecutionListener.class,
	    WithSecurityContextTestExecutionListener.class})
public class MetricProjectFormControllerTest extends BaseControllerTestCase {
    
	@Autowired
    private MetricProjectFormController controller;
    private MockMvc mockMvc;

    @Before
    public void setUp() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/pages/");
        viewResolver.setSuffix(".jsp");

        mockMvc = MockMvcBuilders.standaloneSetup(controller)
        		.setViewResolvers(viewResolver)
        		// .setCustomArgumentResolvers(new AuthenticationPrincipalArgumentResolver())
        		.build();

    }
    
    @Test
    @WithUserDetails("user")
    public void testGetMetrics() throws Exception {
        mockMvc.perform(
        		(get("/admin/metricProject/metrics"))
    			.param("projectId", "-2")
    			.param("programId", "-2")
    			.param("geographyMasterId", "-2")
            )
            .andExpect(status().isOk())
            .andExpect(content().contentType(APPLICATION_JSON_UTF8))
            .andExpect(jsonPath("$", hasSize(16)));

    }
    
    @Test
    public void testAdd() throws Exception {
        log.debug("testing add...");
        mockMvc.perform(get("/admin/metricProject/add/-1"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("metricProject"));
    }

    @Test
    public void testEdit() throws Exception {
        log.debug("testing edit...");
        mockMvc.perform(get("/admin/metricProject/edit/-1"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("metricProject"));
    }

    @Test
    @WithUserDetails("admin")
    public void testSave() throws Exception {
    	
        HttpSession session = mockMvc.perform(
        	post("/admin/metricProject")
	            .param("id", "-1")
        	)
            .andExpect(status().is3xxRedirection())
            .andExpect(model().hasNoErrors())
            .andReturn()
            .getRequest()
            .getSession();

        assertNotNull(session.getAttribute("successMessages"));
    }
    


    @Test
    @WithUserDetails("admin")
    @Ignore
    public void testRemove() throws Exception {
        HttpSession session = mockMvc.perform((post("/admin/projectForm"))
            .param("delete", "").param("id", "-2"))
            .andExpect(status().is3xxRedirection())
            .andReturn().getRequest().getSession();

        assertNotNull(session.getAttribute("successMessages"));
    }
}
