package com.maximus.amp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Ignore;
import org.junit.Test;

public class ConnTest {

	@Test
	@Ignore("this test is for use in debugging jdbc urls")
	public void testConn() throws ClassNotFoundException, SQLException {
		   Class.forName ("oracle.jdbc.OracleDriver");

		   Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//rcmxdb4d.maximus.com:1542/maxdtdev.maximus.com", "", "");
		   
		   try {
		     Statement stmt = conn.createStatement();
		     try {
		       ResultSet rset = stmt.executeQuery("select BANNER from SYS.V_$VERSION");
		       try {
		         while (rset.next())
		           System.out.println (rset.getString(1));   // Print col 1
		       } 
		       finally {
		          try { rset.close(); } catch (Exception ignore) {}
		       }
		     } 
		     finally {
		       try { stmt.close(); } catch (Exception ignore) {}
		     }
		   } 
		   finally {
		     try { conn.close(); } catch (Exception ignore) {}
		   }
		  
	}
	
}
