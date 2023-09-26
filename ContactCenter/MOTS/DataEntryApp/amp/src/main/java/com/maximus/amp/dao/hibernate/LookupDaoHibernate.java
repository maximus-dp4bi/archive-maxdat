package com.maximus.amp.dao.hibernate;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.maximus.amp.dao.LookupDao;
import com.maximus.amp.model.GeographyMaster;
import com.maximus.amp.model.MetricType;
import com.maximus.amp.model.Program;
import com.maximus.amp.model.Project;
import com.maximus.amp.model.ReportingPeriod;
import com.maximus.amp.model.Role;
import com.maximus.amp.model.User;

/**
 * Hibernate implementation of LookupDao.
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 *      Modified by jgarcia: updated to hibernate 4
 */
@Repository(value="lookupDao")
public class LookupDaoHibernate implements LookupDao {
    private Log log = LogFactory.getLog(LookupDaoHibernate.class);
    private final SessionFactory sessionFactory;

    /**
     * Initialize LookupDaoHibernate with Hibernate SessionFactory.
     * @param sessionFactory
     */
    @Autowired
    public LookupDaoHibernate(final SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @SuppressWarnings("unchecked")
	public <T> List<T> getAllOfType(Class<T> clazz) {
		Session session = sessionFactory.getCurrentSession();
        return session.createCriteria(clazz).list();
	}
	
    @Override
    @SuppressWarnings("unchecked")
	public <T> List<T> getAllOfTypeSorted(Class<T> clazz, String sortBy) {
		Session session = sessionFactory.getCurrentSession();
        return session.createCriteria(clazz)
        		.addOrder(Order.asc(sortBy))
        		.list();
	}

	public List<Project> getAllProjects() {
        return getAllOfType(Project.class);
	}


	@Override
	public List<String> getDistinctFunctionalAreas() {
		Session session = sessionFactory.getCurrentSession();
        
        Query namedQuery = session.getNamedQuery("getDistinctFunctionalAreas");
        return (List<String>) namedQuery.list();
             
        
	}

	@Override
	public List<String> getDistinctFunctionalAreas(String projectId, User user) {
		Session session = sessionFactory.getCurrentSession();
        
        Query namedQuery = session.getNamedQuery("getDistinctFunctionalAreasByProject");
        namedQuery.setParameter("projectId", Long.parseLong(projectId));
        namedQuery.setParameter("user", user);
        
        return (List<String>) namedQuery.list();
	}

	@SuppressWarnings("unchecked")
	public <T, PK extends Serializable> T getOneOfTypeById(Class<T> clazz, PK id) {
		
        Session session = sessionFactory.getCurrentSession();
        return (T) session.createCriteria(clazz)
        		.add(Restrictions.eq("id", id))
        		.uniqueResult();
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReportingPeriod> getReportingPeriodsByType(String type) {
		Session session = sessionFactory.getCurrentSession();
        return (List<ReportingPeriod>) session.createCriteria(ReportingPeriod.class)
        		.add(Restrictions.eq("type", type))
        		.addOrder(Order.asc("endDate"))
        		.list();
		
	}

	/**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public List<Role> getRoles(String type) {
        log.debug("Retrieving all role names...");
        Session session = sessionFactory.getCurrentSession();
        return session.createCriteria(Role.class)
        		.add(Restrictions.eq("type", type))
        		.list();
    }
}
