package com.maximus.amp.webapp.listener;

import org.hibernate.envers.RevisionListener;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.maximus.amp.model.envers.AmpRevisionEntity;

public class AmpRevisionListener implements RevisionListener {

	@Override
	public void newRevision(Object revisionEntity) {
        AmpRevisionEntity ampRevEntity = (AmpRevisionEntity) revisionEntity;
        
        String username = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();

        ampRevEntity.setUsername(username);
	}

}
