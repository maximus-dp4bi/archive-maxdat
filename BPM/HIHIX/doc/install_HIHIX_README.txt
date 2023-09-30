Instructions to install HIHIX Database Scripts

********************************************************************************
Prerequisites: 
1. Database install with Maxdat schema and users created
2. Install these 2 items as user sys as sysdba

   A. Run this command:
	create role MAXDAT_READ_ONLY;

   B. Run this script from either
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/
	or DB_INITIAL_LOAD_CORE_1.zip

		userlock.sql


-----------------------
1. CORE SCRIPTS SECTION
-----------------------

	Core install sections from 
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt  
	
	-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- Ordered list of files to deploy to install MAXDAT ETL core database schema.
	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/
	-- or DB_INITIAL_LOAD_CORE_1.zip

	BPM/Core/createdb/create_ETL_tables.sql
	BPM/Core/createdb/create_ETL_sequences.sql
	BPM/Core/createdb/create_ETL_triggers.sql
	BPM/Core/createdb/ETL_COMMON_pkg.sql
	BPM/Core/createdb/create_ETL_functions.sql

	-- Ordered list of files to deploy to install MAXDAT BPM core database schema.
	-- All files can be found at: 
	-- svn://rcmxapp1d.maximus.com/maxdat/
	-- or DB_INITIAL_LOAD_CORE_1.zip

	BPM/Core/createdb/create_core_BPM_Event_tables.sql
	BPM/Core/createdb/create_sequences.sql
	BPM/Core/createdb/BPM_D_DATES.sql
	BPM/Core/createdb/BPM_COMMON_pkg.sql
	BPM/Core/createdb/create_triggers.sql
	BPM/Core/createdb/populate_BPM_D_HOURS.sql
	BPM/Core/createdb/populate_BPM_DATA_MODEL.sql
	BPM/Core/createdb/populate_HOLIDAYS.sql
	BPM/Core/createdb/populate_core_lkup_tables.sql

	BPM/Admin/createdb/SVN_REVISION_KEYWORD_pkg.sql
	BPM/Admin/createdb/SVN_REVISION_DEPLOYED.sql
	BPM/EventQueue/createdb/BPM_UPDATE_EVENT_QUEUE.sql

	BPM/DataModel/BpmEvent/createdb/BPM_EVENT_PROJECT_pkg_spec.sql
	BPM/DataModel/BpmEvent/createdb/BPM_EVENT_pkg.sql
	BPM/DataModel/BpmSemantic/createdb/BPM_SEMANTIC_PROJECT_pkg_spec.sql
	BPM/DataModel/BpmSemantic/createdb/BPM_SEMANTIC_pkg.sql
	BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB.sql
	BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_pkg.sql
	BPM/EventQueue/createdb/PBQJ_ADJUST_REASON_pkg.sql
	BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql
	BPM/Admin/createdb/MAXDAT_ADMIN_AUDIT_LOGGING.sql
	BPM/Admin/createdb/MAXDAT_ADMIN_pkg.sql


----------------------------
2. CORPORATE SCRIPTS SECTION
----------------------------

 	Core install sections from 
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt 
  	   Prerequisite: svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/
	-- or DB_INITIAL_LOAD_CORP_1.zip

	Run order:

	1.create_ETL_initialize_tables.sql
	2.create_ETL_initialize_views.sql
	3.create_ETL_initialize_triggers.sql
        

----------------------------------------
3. HIHIX PROJECT SCRIPTS SECTION - Part 1
----------------------------------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/HIHIX/createdb/
	-- or all files from DB_INITIAL_LOAD_HIHIX_1.zip

    Run order:
	
	1. populate_BPM_D_OPS_GROUP_TASK.sql
	2. populate_BPM_PROJECT_LKUP.sql
	3. MASH_views.sql


----------------------------------------
4. CORP and HIHIX PROCESS SCRIPTS SECTION
----------------------------------------

       -------------------------------------------------
	SupportClientInquiry

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/createdb
        -- or (HIHIX) svn://rcmxapp1d.maximus.com/maxdat/BPM/HIHIX/SupportClientInquiry/createdb
	-- or DB_INITIAL_LOAD_SUPPORTCLIENTINQUIRY_1.zip

	Run order:

	 1. create_ETL_SupportClientInquiry_tables.sql
	 2. create_ETL_SupportClientInquiry_sequences.sql
	 3. SemanticModel_Support_Client_Inquiry.sql
	 4. CLIENT_INQUIRY_pkg.sql
	 5. populate_lkup_tables.sql
     	 6. (HIHIX) populate_BPM_EVENT_MASTER.sql
	 7. create_ETL_SupportClientInquiry_triggers.sql
	 8. create_ETL_SupportClientInquiry_grants_public_syn.sql



----------------------------------------
5. HIHIX PROJECT SCRIPTS SECTION - Part 2
---------------------------------------- 

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/HIHIX/createdb/
	-- or all files from DB_INITIAL_LOAD_HIHIX_1.zip

    Run order:
	
	1. BPM_SEMANTIC_PROJECT_pkg_body.sql

-----------------
6. START BPM JOBS
-----------------

	Run to start BPM calculation and queue processing jobs that will 
	process ETL staging table results when available.  These jobs will 	
	populate the BPM Event and Semantic data model tables.

	1. execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

	Note: Job cans be stopped via: 
		execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;