***** MODIFICATION HISTORY ***************************************************************************
Instructions to install NYHIX Database Scripts
----------------
2013/08/09 S.Pagadrai  - Created
2013/11/01 s.Pagadrai  - Updated with mail fax doc process scripts


******************************************************************************************************

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
	Core install sections from 
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt  
	
	-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: sp57859[maxdat])


	-- Ordered list of files to deploy to install MAXDAT ETL core database schema.
	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/

	BPM/Core/createdb/create_ETL_tables.sql
	BPM/Core/createdb/create_ETL_sequences.sql
	BPM/Core/createdb/create_ETL_triggers.sql
	BPM/Core/createdb/ETL_COMMON_pkg.sql
	BPM/Core/createdb/create_ETL_functions.sql

	-- Ordered list of files to deploy to install MAXDAT BPM core database schema.
	-- All files can be found at: 
	-- svn://rcmxapp1d.maximus.com/maxdat/
	

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
	Corp install sections from 
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/doc/install_core_README.txt 
  	Prerequisite: svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/
	

	Run order 

	1.create_ETL_initialize_tables.sql
	2.create_ETL_initialize_views.sql
	3.create_ETL_initialize_triggers.sql
        

----------------------------------------
3. NYHIX PROJECT SCRIPTS SECTION - Part 1
----------------------------------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/createdb/
	
        Run order 
	
	1. populate_BPM_D_OPS_GROUP_TASK.sql
	2. populate_BPM_PROJECT_LKUP.sql
	3. MASH_views.sql

----------------------------------------
4. CORP and NYHIX PROCESS SCRIPTS SECTION
----------------------------------------

        -------------------------------------------------
        ManageWork

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/
	
        Run order 
	
	 1. create_ETL_ManageWork_tables.sql
	 2. create_ETL_ManageWork_sequences.sql
	 3. create_ETL_ManageWork_views.sql
	 4. SemanticModel_Manage_Work.sql
	 5. CORP_ETL_MANAGE_WORK_pkg.sql
	 6. MANAGE_WORK_pkg.sql
	 7. populate_CORP_ETL_CONTROL.sql
	 8. populate_lkup_tables.sql
	 9. (svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ManageWork/createdb/) populate_BPM_EVENT_MASTER.sql 
	10. create_ETL_ManageWork_triggers.sql
	11. (svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ManageWork/createdb/) populate_corp_etl_list_lkup.sql
                
        -------------------------------------------------
	MailFaxDocBatch

	<future deployment>
	
        -------------------------------------------------
	MailFaxDoc
	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxDoc/createdb/

	 1. create_ETL_NYHIX_Mail_Fax_Doc_tables.sql
	 2. create_ETL_NYHIX_Mail_Fax_Doc_sequences.sql
	 3. create_ETL_NYHIX_Mail_Fax_Doc_triggers.sql
	 4. populate_CORP_ETL_CONTROL.sql
	 5. populate_CORP_ETL_LIST_LKUP.sql
	 6. populate_lkup_tables.sql
	 7. populate_BPM_ATTRIBUTE_LKUP.sql
	 8. populate_BPM_ATTRIBUTE.sql
	 9. SemanticModel_NYHIX_MAIL_FAX_DOC.sql
	10. NYHIX_MAIL_FAX_DOC_pkg.sql
	11. (svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxDoc/patch/) BPM_EVENT_PROJECT_pkg_body.sql
	12. (svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxDoc/patch/) BPM_SEMANTIC_PROJECT_pkg_body.sql

----------------------------------------
5. NYHIX PROJECT SCRIPTS SECTION - Part 2
---------------------------------------- 

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/createdb/


        Run order 
	
	1. BPM_EVENT_PROJECT_pkg_body.sql
	2. BPM_SEMANTIC_PROJECT_pkg_body.sql


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