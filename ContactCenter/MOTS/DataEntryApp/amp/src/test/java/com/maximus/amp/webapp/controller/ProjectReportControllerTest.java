package com.maximus.amp.webapp.controller;

import static org.hamcrest.Matchers.greaterThan;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.test.context.support.WithSecurityContextTestExecutionListener;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;
import org.springframework.test.context.web.ServletTestExecutionListener;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.maximus.amp.service.ProjectReportManager;

@Transactional
@TestExecutionListeners(listeners={ServletTestExecutionListener.class,
	    DependencyInjectionTestExecutionListener.class,
	    DirtiesContextTestExecutionListener.class,
	    TransactionalTestExecutionListener.class,
	    WithSecurityContextTestExecutionListener.class})
public class ProjectReportControllerTest extends BaseControllerTestCase {

    @Autowired
    private ApplicationContext applicationContext;

	@Autowired
    private ProjectReportController controller;

	private MockMvc mockMvc;

    @Before
    public void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    @WithUserDetails("admin")
    public void testHandleRequest() throws Exception {
        mockMvc.perform(get("/reports/actuals"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("projectReportList"))
            .andExpect(view().name("projectReportList"));
    }

    @Test
    @WithUserDetails("user")
    @Ignore("until we implement search")
    public void testSearch() throws Exception {
        // reindex before searching
        ProjectReportManager userManager = (ProjectReportManager) applicationContext.getBean("projectReportManager");
        userManager.reindex();

        Map<String,Object> model = mockMvc.perform((get("/reports")).param("q", "TX EB"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("projectReportList"))
            .andExpect(view().name("projectReportList"))
            .andReturn()
            .getModelAndView()
            .getModel();

        List results = (List) model.get("projectReportList");
        assertNotNull(results);
        assertThat(results.size(), greaterThan(1));
    }
}
