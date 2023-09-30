package com.maximus.amp.dao;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

import java.math.BigDecimal;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maximus.amp.model.MetricDefinition;

public class MetricDefinitionDaoTest extends BaseDaoTestCase {

    @Autowired
    private MetricDefinitionDao dao;
    
    @Autowired
    private GenericDao<MetricDefinition, Long> metricDefinitionDao;
    
    @Test
    public void testSearchWithoutFilters() {
    	
    	log.debug("test");

    	// reindex all the data
        dao.reindex();
        
    	List<MetricDefinition> metrics = dao.search("*", false);
    	
    	Session session = dao.getSession();
    	SQLQuery sqlQuery = session.createSQLQuery("SELECT COUNT(*) FROM D_METRIC_DEFINITION");
    	BigDecimal count = (BigDecimal) sqlQuery.uniqueResult();
    	

    	
    	assertThat(metrics.size(), equalTo(count.intValue()));
    }

    @Test
    public void testSearchWithFilters() {
    	
    	log.debug("test");
    	// reindex all the data
        dao.reindex();
        
    	List<MetricDefinition> metrics = dao.search("*", true);
    	// List<MetricDefinition> metrics = metricDefinitionDao.search("*");
    	
    	Session session = dao.getSession();
    	SQLQuery sqlQuery = session.createSQLQuery("SELECT COUNT(*) FROM D_METRIC_DEFINITION WHERE (IS_WEEKLY = 'Y' OR IS_MONTHLY = 'Y')");
    	BigDecimal count = (BigDecimal) sqlQuery.uniqueResult();
    	    	
    	assertThat(metrics.size(), equalTo(count.intValue()));
    	
    }

    
}
