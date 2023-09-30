package com.maximus.amp.dao.hibernate.integrator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.event.service.spi.EventListenerRegistry;
import org.hibernate.event.spi.EventType;
import org.hibernate.integrator.spi.Integrator;
import org.hibernate.metamodel.source.MetadataImplementor;
import org.hibernate.service.spi.SessionFactoryServiceRegistry;

import com.maximus.amp.webapp.listener.AuditedObjectChangeListener;

/**
 * Hooks up Hibernate event listeners.
 * This class was a prototype in an attempt to leverage HibernateIntegrator Event Listeners
 * 
 * https://hibernate.atlassian.net/browse/HHH-6945
 * http://stackoverflow.com/questions/8616146/eventlisteners-using-hibernate-4-0-with-spring-3-1-0-release
 * http://esus.com/hibernate-4-integrator-pattern-springs-di/
 *
 * @author Cecil Beeland
 */
public class HibernateIntegrator implements Integrator {
	
	private final Log log = LogFactory.getLog(HibernateIntegrator.class);
    
	@Override
	public void integrate(Configuration configuration, SessionFactoryImplementor sessionFactory,
			SessionFactoryServiceRegistry serviceRegistry) {
		
		// As you might expect, an EventListenerRegistry is the thing with which event listeners are registered  It is a
        // service so we look it up using the service registry
        final EventListenerRegistry eventListenerRegistry = serviceRegistry.getService( EventListenerRegistry.class );

        // If you wish to have custom determination and handling of "duplicate" listeners, you would have to add an
        // implementation of the org.hibernate.event.service.spi.DuplicationStrategy contract like this
        //eventListenerRegistry.addDuplicationStrategy( myDuplicationStrategy );

        // EventListenerRegistry defines 3 ways to register listeners:
        //     1) This form overrides any existing registrations with
        //eventListenerRegistry.setListeners( EventType.AUTO_FLUSH, myCompleteSetOfListeners );
        
        //     2) This form adds the specified listener(s) to the beginning of the listener chain
        //eventListenerRegistry.prependListeners( EventType.AUTO_FLUSH, myListenersToBeCalledFirst );
        
        //     3) This form adds the specified listener(s) to the end of the listener chain
        eventListenerRegistry.appendListeners(EventType.PERSIST, new AuditedObjectChangeListener());
	}

	@Override
	public void integrate(MetadataImplementor arg0,
			SessionFactoryImplementor arg1, SessionFactoryServiceRegistry arg2) {
		// Nothing to do. This form is intended for use with the new metamodel code scheduled for completion in 5.0

	}
	

	@Override
	public void disintegrate(SessionFactoryImplementor sessionFactory, SessionFactoryServiceRegistry serviceRegistry) {
		// nothing to do
	}

}