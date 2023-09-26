package com.maximus.amp.service.impl;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.ReferralException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import org.junit.Ignore;
import org.junit.Test;

public class JavaLdapTest {
	
	private static final String FILTER = "(sAMAccountName=user.name)";
	private static final String PASSWORD = "pwd";
	private static final String PROVIDER_URL = "ldaps://[insert ldap url here]:636";
	private static final String SECURITY_PRINCIPAL = "[insert ldap svc account DN here]";
	private static final String SECURITY_CREDENTIALS = "[insert ldap svc account pwd here]";	
	private static final String SEARCH_BASE = "[insert ldap search base here]";

	
	public Hashtable initEnv() {
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env.put(Context.PROVIDER_URL, PROVIDER_URL);
		env.put(Context.SECURITY_AUTHENTICATION, "simple");
		env.put(Context.REFERRAL, "follow");
		
		return env;
	}
	
	
	@Test
	@Ignore
	public void testJavaLdapConn() throws NamingException {
		
		System.out.println(System.getProperty("javax.net.ssl.trustStore")); 
		System.out.println(System.getProperty("javax.net.ssl.keyStore"));

		Hashtable env = initEnv();
		env.put(Context.SECURITY_PRINCIPAL, SECURITY_PRINCIPAL);
		env.put(Context.SECURITY_CREDENTIALS, SECURITY_CREDENTIALS);
		

		// Create the initial context
		DirContext ctx = new InitialDirContext(env);
		
		SearchControls searchControls = new SearchControls();
	    searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
	    searchControls.setTimeLimit(30000);
		

		NamingEnumeration ne = ctx.search(SEARCH_BASE,FILTER,searchControls);
		
		
        if(!ne.hasMore()) {
                System.out.println("Not Found");
        } else {
                System.out.println("Success");
                SearchResult sr = (SearchResult)ne.next();
                System.out.println(">>>" + sr.getName());
                
                String userDn = sr.getNameInNamespace();

        		env = initEnv();
        		env.put(Context.SECURITY_PRINCIPAL, userDn);
        		env.put(Context.SECURITY_CREDENTIALS, PASSWORD);

                ctx = new InitialDirContext(env);
        }
		
		System.out.println("Success");
		

		
		
	}
	
}
