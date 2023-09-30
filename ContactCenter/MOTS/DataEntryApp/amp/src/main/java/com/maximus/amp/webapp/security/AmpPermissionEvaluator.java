package com.maximus.amp.webapp.security;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.core.Authentication;


public class AmpPermissionEvaluator implements PermissionEvaluator {
	
	private Map<String, Permission> permissionNameToPermissionMap = new HashMap<String, Permission>();
	
    public AmpPermissionEvaluator(Map<String, Permission> permissionNameToPermissionMap) {
        this.permissionNameToPermissionMap = permissionNameToPermissionMap;
    }

	@Override	
	public boolean hasPermission(Authentication authentication, Object targetDomainObject, Object permission) {
        boolean hasPermission = false;
        if (canHandle(authentication, targetDomainObject, permission)) {
            hasPermission = checkPermission(authentication, targetDomainObject, (String) permission);
        }
        return hasPermission;
	}

    private boolean checkPermission(Authentication authentication, Object targetDomainObject, String permissionKey) {
        verifyPermissionIsDefined(permissionKey);
        Permission permission = permissionNameToPermissionMap.get(permissionKey);
        return permission.isAllowed(authentication, targetDomainObject);
    }
    
    
    private void verifyPermissionIsDefined(String permissionKey) {
        if (!permissionNameToPermissionMap.containsKey(permissionKey)) {
            throw new PermissionNotDefinedException("No permission with key " + permissionKey + " is defined in " + this.getClass().toString());
        }
    }
    
    private boolean canHandle(Authentication authentication, Object targetDomainObject, Object permission) {
        return targetDomainObject != null && authentication != null && permission instanceof String;
    }
    
	@Override
	public boolean hasPermission(Authentication authentication, Serializable targetId, String targetType, Object permission) {
		throw new PermissionNotDefinedException("Id and Class permissions are not supperted by " + this.getClass().toString());
	}

}
