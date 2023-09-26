package com.maximus.amp.webapp.listener;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.type.Type;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.maximus.amp.model.AuditedObject;

public class AuditedObjectChangeInterceptorListener implements PropertyChangeListener<AuditedObject>  {
	/**
	 * Default serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	private static final Log log = LogFactory.getLog(AuditedObjectChangeInterceptorListener.class);
	
	@Override
	public <E> void onFlushDirty(Object entity, E oldVal, E newVal, String propertyName) {
	  
	  if(entity instanceof AuditedObject){
		  AuditedObject auditedEntity = (AuditedObject) entity;
	      // do something with entity
	      
	      String username = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
	      
	      auditedEntity.setModifiedBy(username);
	      auditedEntity.setModifiedDate(new Date());
	  }
      
	}

	@Override
	public <E> boolean onSave(Object entity, Serializable id, Object[] state,
			String[] propertyNames, Type[] types) {
		
		String username = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
		boolean isModified = false;
		
		if(entity instanceof AuditedObject){
			
			int propertyIndex = -1;
			String property = "";
			for(int x = 0; x < propertyNames.length; x++){
				if ("createdBy".equalsIgnoreCase(propertyNames[x])){
					propertyIndex = x;
					property = "createdBy";
				}else if ("createdDate".equalsIgnoreCase(propertyNames[x])){
					propertyIndex = x;
					property = "createdDate";
				}else if ("modifiedBy".equalsIgnoreCase(propertyNames[x])){
					propertyIndex = x;
					property = "modifiedBy";
				}else if ("modifiedDate".equalsIgnoreCase(propertyNames[x])){
					propertyIndex = x;
					property = "modifiedDate";
				}
				
				if(propertyIndex != -1){
					if(property.equals("createdBy") && (state[propertyIndex] == null)){
						state[propertyIndex] = username;
						isModified = true;
					}else if(property.equals("createdDate") && (state[propertyIndex] == null)){
						state[propertyIndex] = new Date();
						isModified = true;
					}else if(property.equals("modifiedBy") && (state[propertyIndex] == null)){
						state[propertyIndex] = username;
						isModified = true;
					}else if(property.equals("modifiedDate") && (state[propertyIndex] == null)){
						state[propertyIndex] = new Date();
						isModified = true;
					}
					propertyIndex = -1;
					property = "";
				}
			}
			

		}
		
		return isModified;
		
	}

}
