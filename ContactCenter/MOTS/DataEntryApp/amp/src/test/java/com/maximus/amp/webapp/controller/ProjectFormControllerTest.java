package com.maximus.amp.webapp.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
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
public class ProjectFormControllerTest extends BaseControllerTestCase {
    
	@Autowired
    private ProjectFormController controller;
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
        mockMvc.perform(get("/admin/project/add"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("project"));
    }

    @Test
    public void testEdit() throws Exception {
        log.debug("testing edit...");
        mockMvc.perform(get("/admin/project/edit/-1"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("project"));
    }

    @Test
    @WithUserDetails("admin")
    public void testSave() throws Exception {
    	
        HttpSession session = mockMvc.perform(
        	post("/admin/project")
	            .param("projectName", "AwZkYtCtRuSbHuMvHuVpFeIlJfNlSoBvFyOxXvGqTjFkAzBqHo")
	            .param("division.id", "-1")
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
    public void testAddValidationRule() throws Exception {
    	
        HttpSession session = mockMvc.perform(
        	post("/admin/project/edit/-1")
//        		.principal(new TestingAuthenticationToken(new User("admin"), null))
	            .param("addValidationRule", "")
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
