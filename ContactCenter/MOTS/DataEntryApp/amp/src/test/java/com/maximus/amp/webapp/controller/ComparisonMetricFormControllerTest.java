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
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Transactional
@TestExecutionListeners(listeners={ServletTestExecutionListener.class,
	    DependencyInjectionTestExecutionListener.class,
	    DirtiesContextTestExecutionListener.class,
	    TransactionalTestExecutionListener.class,
	    WithSecurityContextTestExecutionListener.class})
public class ComparisonMetricFormControllerTest extends BaseControllerTestCase {
    
	@Autowired
    private ComparisonMetricFormController controller;
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
    public void testAdd() throws Exception {
        log.debug("testing add...");
        mockMvc.perform(get("/admin/comparisonMetric/add/-1"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("comparisonMetric"));
    }

    @Test
    public void testEdit() throws Exception {
        log.debug("testing edit...");
        MvcResult result = mockMvc.perform(get("/admin/comparisonMetric/edit/-1"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("comparisonMetric"))
            .andReturn();
        

    }

    @Test
    @WithUserDetails("admin")
    public void testSave() throws Exception {
    	
        HttpSession session = mockMvc.perform(
        	post("/admin/comparisonMetric")
	            .param("metricValidationRule.id", "-1")
	            .param("compMetricDefinition.id", "-2")
	            .param("compMetricValueLocation", "CURRENT_ACTUAL")
	            .param("alias", "callsContained")
        	)
            .andExpect(status().is3xxRedirection())
            .andExpect(model().hasNoErrors())
            .andReturn()
            .getRequest()
            .getSession();

        assertNotNull(session.getAttribute("successMessages"));
    }
    

}

