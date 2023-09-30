package com.maximus.amp.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Hibernate;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.test.context.support.WithUserDetails;

import com.maximus.amp.Constants;
import com.maximus.amp.model.User;

@Transactional(Transactional.TxType.NOT_SUPPORTED)
public class UserManagerTest extends BaseManagerTestCase {
    private Log log = LogFactory.getLog(UserManagerTest.class);
    @Autowired
    @Qualifier(value="userManager")
    private UserManager mgr;
    @Autowired
    private RoleManager roleManager;

    @Before
    public void before() throws Exception {
        User user = new User();

        // call populate method in super class to populate test data
        // from a properties file matching this class name
        user = (User) populate(user);

        user.addRole(roleManager.getRole(Constants.USER_ROLE));

        user = mgr.saveUser(user);
        assertEquals("john", user.getUsername());
        assertEquals(1, user.getRoles().size());
    }

    @After
    public void after() {
        User user = mgr.getUserByUsername("john");
        mgr.removeUser(user.getId().toString());

        try {
            mgr.getUserByUsername("john");
            fail("Expected 'Exception' not thrown");
        } catch (Exception e) {
            log.debug(e);
            assertNotNull(e);
        }
    }

    @Test
    public void testGetUser() throws Exception {
        User user = mgr.getUserByUsername("john");
        assertNotNull(user);
    }

    @Test
    public void testSaveUser() throws Exception {
        User user = mgr.getUserByUsername("john");
        Hibernate.initialize(user);
        user.setPhoneNumber("303-555-1212");

        log.debug("saving user with updated phone number: " + user.getUsername());

        user = mgr.saveUser(user);
        assertEquals("303-555-1212", user.getPhoneNumber());
    }

    @Test
    public void testGetAll() throws Exception {
        List<User> found = mgr.getAll();
        log.debug("Users found: " + found.size());
        // don't assume exact number so tests can run in parallel
        assertFalse(found.isEmpty());
    }
}
