package com.maximus.amp.dao;


import static org.hamcrest.Matchers.greaterThan;
import static org.junit.Assert.assertThat;

import java.math.BigDecimal;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maximus.amp.model.ProjectReport;

public class ProjectReportDaoTest extends BaseDaoTestCase {

    @Autowired
    private ProjectReportDao dao;
    
    @Test
    public void testSQLQuery() {
    	
    	log.debug("test");
    	
    	ProjectReport projectReport = dao.get(-6L);
    	dao.approve(projectReport);
    	
    	Session session = dao.getSession();
    	SQLQuery sqlQuery = session.createSQLQuery("SELECT COUNT(*) FROM F_METRIC");
    	BigDecimal count = (BigDecimal) sqlQuery.uniqueResult();
    	
    	assertThat(count, greaterThan(BigDecimal.valueOf(88)));
    }

}
