package com.maximus.amp.dao.hibernate.interceptor;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;

import com.maximus.amp.model.AuditedObject;
import com.maximus.amp.webapp.listener.AuditedObjectChangeInterceptorListener;
import com.maximus.amp.webapp.listener.PropertyChangeListener;
 
/**
 * Intercept changes on entities
 * 
 * Per this post:
 * http://duckranger.com/2012/12/capturing-property-changes-with-spring-jpa-and-hibernate/
 * 
 * @author Cecil Beeland
 *
 */
@SuppressWarnings("rawtypes")
public class PropertyChangeInterceptor extends EmptyInterceptor {
 
  private static final long serialVersionUID = 1L;
  private Map<Class, PropertyChangeListener<?>> listeners;
  private static final String EMPTY_STRING = "";
  
  public PropertyChangeInterceptor() {
	    listeners = new HashMap<Class, PropertyChangeListener<?>>();
	    listeners.put(AuditedObject.class, new AuditedObjectChangeInterceptorListener());
	  }

  @SuppressWarnings("unchecked")
  @Override
  public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, Object[] previousState, String[] propertyNames,
    Type[] types) {
	  
	PropertyChangeListener listener;
	boolean report = false;
 
	if(entity instanceof AuditedObject){
		listener = listeners.get(AuditedObject.class);
	}else{
		listener = listeners.get(entity.getClass());
	}
     
    //Only check for changes if an entity-specific listener was registered
    if (listener != null) {
      
      //Iterate over each attribute in entity
      for (int i = 0; i < currentState.length; i++) {
    	  if (currentState[i] == null){
    		    
    		    //If current value is null, and previous is empty string, consider value unchanged and do nothing
    		    //Else if field has been nulled-out, update
    		    if ((previousState[i] != null)
    		    		&& (!EMPTY_STRING.equals(previousState[i]))){
    		    report = true;  
    		    }
    		    //Else both are null - do nothing
    		    report = false;

    		//If current value is empty-string, and previous is null, consider value unchanged and do nothing  
    	  } else if ((EMPTY_STRING.equals(currentState[i])) && (previousState[i] == null)){
    		  	report = false;
    		  
    		  //Else, if current value and previous value are different, update
    		} else if (!currentState[i].equals(previousState[i])) {
    		    report = true;
    		}
 
        if (report) {
          listener.onFlushDirty(entity, previousState[i], currentState[i], propertyNames[i]);
          report = false;
        }
      }
    } 
    return false;
  }
  
	public boolean onSave(
			Object entity, 
			Serializable id, 
			Object[] state, 
			String[] propertyNames, 
			Type[] types) {
		
		PropertyChangeListener listener;
		boolean isModified = false;
	 
		if(entity instanceof AuditedObject){
			listener = listeners.get(AuditedObject.class);
		}else{
			listener = listeners.get(entity.getClass());
		}
	     
	    //Only check for changes if an entity-specific listener was registered
	    if (listener != null) {
	    	isModified = listener.onSave(entity, id, state, propertyNames, types);
	    }
	
		return isModified;
	}
 
}
