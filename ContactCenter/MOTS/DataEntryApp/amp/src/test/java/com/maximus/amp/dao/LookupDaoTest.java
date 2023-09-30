package com.maximus.amp.dao;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maximus.amp.model.Project;
import com.maximus.amp.model.User;

/**
 * This class tests the current LookupDao implementation class
 * @author mraible
 */
public class LookupDaoTest extends BaseDaoTestCase {
    @Autowired
    LookupDao lookupDao;

    @Test
    public void testGetRoles() {
        List roles = lookupDao.getRoles("APPLICATION");
        log.debug(roles);
        assertTrue(roles.size() == 2);
    }
    
    @Test
    public void testGetDistinctFunctionalAreas() {
    	List<String> functionalAreas = lookupDao.getDistinctFunctionalAreas();
    	
    	assertThat(functionalAreas, notNullValue());
    	assertThat(functionalAreas.size(), equalTo(2));
    }
    
    @Test
    public void testGetDistinctFunctionalAreasByProject() {
    	
    	User user = lookupDao.getOneOfTypeById(User.class, -1L);
    	List<String> functionalAreas = lookupDao.getDistinctFunctionalAreas("-1", user);
    	
    	assertThat(functionalAreas, notNullValue());
    	assertThat(functionalAreas.size(), equalTo(2));
    	

    	functionalAreas = lookupDao.getDistinctFunctionalAreas("-2", user);
    	
    	assertThat(functionalAreas, notNullValue());
    	assertThat(functionalAreas.size(), equalTo(0));
    	
    	user = lookupDao.getOneOfTypeById(User.class, -5L);
    	
    	functionalAreas = lookupDao.getDistinctFunctionalAreas("-2", user);
    	
    	assertThat(functionalAreas, notNullValue());
    	assertThat(functionalAreas.size(), equalTo(1));

    	
    }
}
