package com.maximus.amp.webapp.controller;

import static org.hamcrest.Matchers.equalTo;
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
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.maximus.amp.model.Project;
import com.maximus.amp.service.GenericManager;



public class ProjectControllerTest extends BaseControllerTestCase {
    @Autowired
    @Qualifier("projectManager")
    private GenericManager<Project, Long> genericManager;
    
    @Autowired
    private ProjectController controller;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/pages/");
        viewResolver.setSuffix(".jsp");

        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    public void testHandleAdminRequest() throws Exception {
    	
    	log.debug("testHandleAdminRequest");
    	
        mockMvc.perform(get("/admin/projects"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("projectList"))
            .andExpect(view().name("admin/projectList"));
    }
    
    @Test
    public void testSearch() throws Exception {
    	
    	log.debug("test search");
    	
        // regenerate indexes
        genericManager.reindex();

        Map<String,Object> model = mockMvc.perform((get("/admin/projects")).param("q", "*"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("projectList"))
            .andReturn()
            .getModelAndView()
            .getModel();

        List results = (List) model.get("projectList");
        assertNotNull(results);
        assertThat(results.size(), equalTo(3));
    }
}
