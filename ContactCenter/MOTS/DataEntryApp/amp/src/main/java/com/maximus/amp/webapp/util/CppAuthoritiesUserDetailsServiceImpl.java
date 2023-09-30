package com.maximus.amp.webapp.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.maximus.amp.dao.UserDao;
import com.maximus.amp.model.User;
 
public class CppAuthoritiesUserDetailsServiceImpl implements UserDetailsService {
 
    //private final transient Log log = LogFactory.getLog(CppAuthoritiesPopulator.class);
	private static final Log log = LogFactory.getLog(CppAuthoritiesUserDetailsServiceImpl.class);
	
    private UserDao userDao;
     
    @Autowired   
    public CppAuthoritiesUserDetailsServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }
     
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException, DataAccessException {
        User user = (User) userDao.loadUserByUsername(username);
        return user;
    }
}
