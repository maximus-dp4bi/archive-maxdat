Instructions to install TX Database Scripts

********************************************************************************
Prerequisites: 
1. Database install with Maxdat schema and users created

-----------------------
1. CREATE DATABASE TABLES, SEQUENCES, TRIGGERS AND VIEWS
-----------------------

	-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip
	
	scripts/create_staging_tables_sequences_triggers.sql
	scripts/create_dimensional_tables_sequences_triggers.sql
	scripts/grant_select_on_views_to_maxdat_read_only.sql
	scripts/ALTER_CC_F_AGENT_BY_DATE_MODIFY_WFM_FIELDS.sql
	scripts/MODIFY_CC_S_AGENT_WORK_DAY_FIELDS.sql
	
