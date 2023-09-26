package com.maximus.amp.dao.hibernate;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.maximus.amp.dao.ProjectReportDao;
import com.maximus.amp.model.ProjectReport;

@Repository
public class ProjectReportDaoHibernate extends GenericDaoHibernate<ProjectReport, Long> implements ProjectReportDao {
	
    /**
     * Constructor to create a Generics-based version using ProjectReport as the entity
     */
    public ProjectReportDaoHibernate() {
        super(ProjectReport.class);
    }
    
    @Transactional
    public void approve(ProjectReport projectReport) {
    	
        Session sess = getSession();
        
        Query namedQuery = sess.getNamedQuery("SP_MERGE_F_METRIC");
        namedQuery.setParameter("projectReportId", projectReport.getId());
        
        namedQuery.executeUpdate();
        
    }

	
}
