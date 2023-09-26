package com.maximus.amp.webapp.listener;

import java.util.Date;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.event.spi.PersistEvent;
import org.hibernate.event.spi.PersistEventListener;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.maximus.amp.model.AuditedObject;

/**
 * This class was a prototype in an attempt to leverage HibernateIntegrator Event Listeners
 * 
 * https://hibernate.atlassian.net/browse/HHH-6945
 * http://stackoverflow.com/questions/8616146/eventlisteners-using-hibernate-4-0-with-spring-3-1-0-release
 * http://esus.com/hibernate-4-integrator-pattern-springs-di/
 * 
 * @author cecil.beeland
 *
 */
public class AuditedObjectChangeListener implements PersistEventListener {
	/**
	 * Default serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	private static final Log log = LogFactory.getLog(AuditedObjectChangeListener.class);
	
	@Override
	public void onPersist(PersistEvent event) throws HibernateException {
		// TODO Auto-generated method stub
		log.debug("Entering AuditedObjectChangeListener");

        if(event.getObject() instanceof AuditedObject) {
            AuditedObject entity = (AuditedObject) event.getObject();
            // do something with entity
            
            String username = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
            
            if(entity.getId() == null){
            	entity.setCreatedBy(username);
            	entity.setCreatedDate(new Date());
            }
            entity.setModifiedBy(username);
            entity.setModifiedDate(new Date());
        }
	}

	@Override
	public void onPersist(PersistEvent event, Map createdAlready)
			throws HibernateException {
		// TODO Auto-generated method stub
		log.debug("Entering AuditedObjectChangeListener onPersist STUB");
	}

}
