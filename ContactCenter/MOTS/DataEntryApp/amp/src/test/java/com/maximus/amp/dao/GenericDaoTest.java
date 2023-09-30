package com.maximus.amp.dao;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.SessionFactory;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maximus.amp.Constants;
import com.maximus.amp.dao.hibernate.GenericDaoHibernate;
import com.maximus.amp.model.MetricProject;
import com.maximus.amp.model.User;

public class GenericDaoTest extends BaseDaoTestCase {
    Log log = LogFactory.getLog(GenericDaoTest.class);
    GenericDao<User, Long> genericDao;
    GenericDao<MetricProject, Long> metricProjectDao;
    
    @Autowired
    SessionFactory sessionFactory;

    @Before
    public void setUp() {
        genericDao = new GenericDaoHibernate<>(User.class, sessionFactory);
        metricProjectDao = new GenericDaoHibernate<>(MetricProject.class, sessionFactory);
    }

    @Test
    public void getUser() {
        User user = genericDao.get(-1L);
        assertNotNull(user);
        assertEquals("user", user.getUsername());
    }
    
    @Test
    public void testGetMetricsForReport() {
        HashMap<String, Object> queryParams = new HashMap<String, Object>();
        queryParams.put("functionalArea", "Contact Center");
        queryParams.put("projectId", -1L);
        queryParams.put("programId", -1L);
        queryParams.put("geographyMasterId", -1L);
        queryParams.put("isWeekly", null);
        queryParams.put("isMonthly", Constants.Y);
        queryParams.put("reportingPeriodEndDate", new GregorianCalendar(2015, 6, 15).getTime());
        
        List<MetricProject> metricProjectList = metricProjectDao.findByNamedQuery("getMetricsForForecastReport", queryParams);
        assertNotNull(metricProjectList);
        assertThat(metricProjectList.size(), equalTo(12));
    	
    }
}

