package com.maximus.amp.service.impl;

import static org.junit.Assert.assertTrue;

import javax.transaction.Transactional;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.ldap.authentication.LdapAuthenticationProvider;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
    "classpath:/applicationContext-resources.xml",
    "classpath:/applicationContext-dao.xml",
    "classpath:/applicationContext-service.xml",
	"/WEB-INF/applicationContext.xml",
    "/WEB-INF/security.xml"
})
@Ignore("until a local dev env LDAP server solution is found")
public class LdapAuthenticationTest {
	
    @Autowired
    private ApplicationContext applicationContext;
    
    @Autowired
    private LdapAuthenticationProvider ldapAuthProvider;
    
    @Test
    @Transactional
    public void testLdapAuthentication() {
    	
    	Authentication authentication = new UsernamePasswordAuthenticationToken("clay.rowland", "G@laxyHiker");
    	assertTrue(ldapAuthProvider.authenticate(authentication).isAuthenticated());
    	
    }

}
