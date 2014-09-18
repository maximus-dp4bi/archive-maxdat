Instructions to install UKEX Database Scripts

********************************************************************************
Prerequisites: 
1. Database install with Maxdat schema and users created
2. Install these 2 items as user sys as sysdba

   A. Run this command:
	create role MAXDAT_READ_ONLY;

   B. Run this script:
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/userlock.sql


-----------------------
1. CORE SCRIPTS SECTION
-----------------------

	-- Run these SQL scripts below in the new database as the the Oracle user MAXDAT:  
	-- 	(or as a proxy login to MAXDAT - Example: rk50472[maxdat])
	-- Some the scripts that follow create Public Synonyms, so the MAXDAT user should have that permission
	-- All files can be found at:
	-- 	svn://rcmxapp1d.maximus.com/maxdat/


	-- Ordered list of files to deploy to install MAXDAT ETL core database schema.

	BPM/Core/createdb/create_ETL_tables.sql
	BPM/Core/createdb/create_ETL_sequences.sql
	BPM/Core/createdb/create_ETL_triggers.sql
	BPM/Core/createdb/ETL_COMMON_pkg.sql
	BPM/Core/createdb/create_ETL_functions.sql

	-- Ordered list of files to deploy to install MAXDAT BPM core database schema.
	
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
	BPM/Core/createdb/CORP_ETL_STAGE_pkg.sql


----------------------------
2. CORPORATE SCRIPTS SECTION
----------------------------

	-- Ordered list to install files for Corporate

	BPM/Corp/createdb/create_ETL_initialize_tables.sql
	BPM/Corp/createdb/create_ETL_initialize_views.sql
	BPM/Corp/createdb/create_ETL_initialize_triggers.sql
        

----------------------------------------
3. UKEX PROJECT SCRIPTS SECTION - PART 1
----------------------------------------

	-- Ordered list to install files for Exeter Managed Work
	
	BPM/UKEX/createdb/populate_BPM_REGION_LKUP.sql
	BPM/UKEX/createdb/populate_BPM_PROJECT_LKUP.sql
	BPM/UKEX/createdb/createdb/MASH_views.sql


----------------------------------------
4. CORP and UKEX MANAGE WORK SCRIPTS SECTION
----------------------------------------

	-- Ordered list to install files for Managed Work
	
	BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_tables.sql
	BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_sequences.sql
	BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_views.sql
	BPM/Corp/ManageWork/createdb/SemanticModel_Manage_Work.sql
	BPM/Corp/ManageWork/createdb/CORP_ETL_MANAGE_WORK_pkg.sql
	BPM/Corp/ManageWork/createdb/MANAGE_WORK_pkg.sql
	BPM/Corp/ManageWork/createdb/populate_CORP_ETL_CONTROL.sql
	BPM/Corp/ManageWork/createdb/populate_lkup_tables.sql
	BPM/UKEX/ManageWork/createdb/populate_BPM_EVENT_MASTER.sql
	BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_triggers.sql
        
        
----------------------------------------
5. UKEB PROJECT SCRIPTS SECTION - Part 2
---------------------------------------- 

	-- Ordered list to finish files for Exeter Managed Work
	
	BPM/UKEX/createdb/BPM_EVENT_PROJECT_pkg_body.sql
	BPM/UKEX/createdb/BPM_SEMANTIC_PROJECT_pkg_body.sql


-----------------
6. START BPM JOBS
-----------------

	Run to start BPM calculation and queue processing jobs that will 
	process ETL staging table results when available.  These jobs will 	
	populate the BPM Event and Semantic data model tables.

	1. execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

	Note: Job cans be stopped via: 

		execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;


-------------
7. SMOKE TEST
-------------

	Wait 5 minutes for all the jobs to start up in the background.

	Verify that there are no SEVERE or WARNING errors:

		select * from BPM_LOGGING;

	Verify that MaxDat BPM queue processing jobs are running:
	(should be several BSL_IDs and BDM_IDs with jobs SLEEPING 
	 or PROCESSING (rare at this stage)

		select * from PROCESS_BPM_QUEUE_JOB 
		where STATUS != 'STOPPED' order by BSL_ID asc, BDM_ID asc;
	