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

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.maximus.amp.service.GenericManager;
import com.maximus.amp.service.MetricDefinitionManager;



public class MetricDefinitionControllerTest extends BaseControllerTestCase {
    @Autowired
    @Qualifier("metricDefinitionManager")
    private MetricDefinitionManager metricDefinitionManager;
    @Autowired
    private MetricDefinitionController controller;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/pages/");
        viewResolver.setSuffix(".jsp");

        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    @WithUserDetails(value="admin")
    public void testHandleAdminRequest() throws Exception {
        mockMvc.perform(get("/admin/metrics"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("metricDefinitionList"))
            .andExpect(view().name("admin/metricDefinitionList"));
    }

    @Test
    @WithUserDetails(value="user")
    public void testHandleHelpRequest() throws Exception {
        mockMvc.perform(get("/help/metrics"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("metricDefinitionList"))
            .andExpect(view().name("help/metricDefinitionList"));
    }

    
    @Test
    @WithUserDetails(value="admin")
    public void testSearch() throws Exception {
        // regenerate indexes
        metricDefinitionManager.reindex();

        Map<String,Object> model = mockMvc.perform((get("/admin/metrics")).param("q", "*"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("metricDefinitionList"))
            .andReturn()
            .getModelAndView()
            .getModel();

        List results = (List) model.get("metricDefinitionList");
        assertNotNull(results);
        assertThat(results.size(), greaterThan(4));
    }
}
