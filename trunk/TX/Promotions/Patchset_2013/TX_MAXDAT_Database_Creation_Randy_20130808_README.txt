Instructions to install TXEB Database Scripts

********************************************************************************
Prerequisites: 
1. Database install with Maxdat schema and users created
2. Install these 2 items as user sys as sysdba

   A. Run this command:
	create role MAXDAT_READ_ONLY;

   B. Run this script from either
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/
	or DB_INITIAL_LOAD_CORE_1.sql

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
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/doc/install_core_README.txt 
  	   Prerequisite: svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/
	-- or DB_INITIAL_LOAD_CORP_1.zip

	Run order 

	1.create_ETL_initialize_tables.sql
	2.create_ETL_initialize_views.sql
	3.create_ETL_initialize_triggers.sql
        

----------------------------------------
3. TXEB PROJECT SCRIPTS SECTION - Part 1
----------------------------------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/createdb/
	-- or all files from DB_INITIAL_LOAD_TXEB_1.zip

        Run order 
	
	1. populate_BPM_D_OPS_GROUP_TASK.sql
	2. populate_BPM_PROJECT_LKUP.sql
	3. createdb/MASH_views.sql


----------------------------------------
4. CORP and TXEB PROCESS SCRIPTS SECTION
----------------------------------------

        -------------------------------------------------
        ManageWork

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/
	-- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageJobs/createdb/)
	-- or all files from DB_INITIAL_LOAD_MANAGEWORK_1.zip

        Run order 
	
	 1. create_ETL_ManageWork_tables.sql
	 2. create_ETL_ManageWork_sequences.sql
	 3. create_ETL_ManageWork_views.sql
	 4. SemanticModel_Manage_Work.sql
	 5. CORP_ETL_MANAGE_WORK_pkg.sql
	 6. MANAGE_WORK_pkg.sql
	 7. populate_CORP_ETL_CONTROL.sql
	 8. (TXEB) populate_BPM_EVENT_MASTER.sql
	 9. populate_lkup_tables.sql
	10. populate_BPM_ATTRIBUTE_LKUP.sql
	11. populate_BPM_ATTRIBUTE.sql
	12. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
	13. create_ETL_ManageWork_triggers.sql
	14. create_ETL_ManageWork_grants_public_syn.sql
        
        
        -------------------------------------------------
	ManageMailFaxDoc

	-- Files can be found at:
	-- (Corp) svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageMailFaxDoc/createdb
        -- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageMailFaxDoc/createdb
	-- or all files from DB_INITIAL_LOAD_MAILFAXDOC_1.zip

	Run order:
	 1. (TXEB) create_ETL_Mailfaxdoc_tables.sql
	 2. (TXEB) create_ETL_Mailfaxdoc_sequences.sql
	 3. (Corp) SemanticModel_Manage_Mail_Fax_Doc.sql
	 4. (Corp) MANAGE_MAIL_FAX_DOC_pkg.sql
	 5. (TXEB) populate_CORP_ETL_CONTROL.sql
	 6. (TXEB) populate_CORP_ETL_LIST_LKUP.sql
	 7. (TXEB) populate_CORP_INSTANCE_CLEANUP_TABLE.sql
	 8. (TXEB) populate_BPM_EVENT_MASTER.sql
	 9. (Corp) populate_lkup_tables.sql
	10. (Corp) populate_BPM_ATTRIBUTE_LKUP.sql
	11. (Corp) populate_BPM_ATTRIBUTE.sql
	12. (Corp) populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
	13. (TXEB) create_ETL_Mailfaxdoc_triggers.sql
	14. (TXEB) create_ETL_Mailfaxdoc_grants_public_syn.sql
       
       
        -------------------------------------------------
	ProcessIncidents

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessIncidents/createdb
        -- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessIncidents/createdb
	-- or DB_INITIAL_LOAD_PROCESSINCIDENTS_1.zip

        Run order:
        
         1. create_ETL_ProcessIncidents_tables.sql
         2. create_ETL_ProcessIncidents_sequences.sql
         3. SemanticModel_DPY_ProcessIncidents.sql
         4. DPY_PROCESS_INCIDENTS_pkg.sql
	 5. (TXEB) populate_BPM_EVENT_MASTER.sql
         6. populate_lkup_tables.sql
         7. populate_BPM_ATTRIBUTE_LKUP.sql
         8. populate_BPM_ATTRIBUTE.sql
         9. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
        10. create_ETL_ProcessIncidents_triggers.sql

        
        -------------------------------------------------
	ManageJobs

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageJobs/createdb
        -- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageJobs/createdb
	-- or DB_INITIAL_LOAD_MANAGEJOBS_1.zip

        Run order:
	
	 1. create_ETL_ManageJobs_tables.sql
	 2. create_ETL_ManageJobs_sequences.sql
	 3. SemanticModel_ILEB_Manage_Jobs.sql
	 4. MANAGE_JOBS_pkg.sql
	 5. (TXEB) populate_BPM_EVENT_MASTER.sql
	 6. populate_lkup_tables.sql
	 7. populate_BPM_ATTRIBUTE_LKUP.sql
	 8. populate_BPM_ATTRIBUTE.sql
	 9. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
	10. INSERT_CORP_ETL_CONTROL.sql
	11. (TXEB) INSERT_CORP_MJ_ETL_FILE_LKUP.sql
        12. (TXEB) INSERT_CORP_MJ_FILE_CAL_LKUP.sql
	13. create_ETL_ManageJobs_triggers.sql
	14. create_ETL_ManageJobs_grants_public_syn.sql


	-------------------------------------------------
	ProcessLetters

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessLetters/createdb
	-- or DB_INITIAL_LOAD_PROCESSLETTERS_1.zip

        Run order:
	
	 1. create_ETL_ProcessLetters_tables.sql
         2. create_ETL_ProcessLetters_sequences.sql  
         3. SemanticModel_Process_Letters.sql
         4. PROCESS_LETTERS_pkg.sql
         5. populate_BPM_EVENT_MASTER.sql
         6. populate_lkup_tables.sql
         7. populate_BPM_ATTRIBUTE_LKUP.sql
         8. populate_BPM_ATTRIBUTE.sql
         9. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
        10. populate_CORP_ETL_CONTROL.sql
        11. populate_CORP_ETL_LIST_LKUP.sql
        12. create_ETL_ProcessLetters_triggers.sql


       -------------------------------------------------
	SupportClientInquiry

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/createdb
        -- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/SupportClientInquiry/createdb
	-- or DB_INITIAL_LOAD_SUPPORTCLIENTINQUIRY_1.zip

	Run order:

	 1. create_ETL_SupportClientInquiry_tables.sql
	 2. create_ETL_SupportClientInquiry_sequences.sql
	 3. SemanticModel_Support_Client_Inquiry.sql
	 4. CLIENT_INQUIRY_pkg.sql
         5. (TXEB) populate_BPM_EVENT_MASTER.sql
	 5. populate_lkup_tables.sql
	 6. populate_BPM_ATTRIBUTE_LKUP.sql
	 7. populate_BPM_ATTRIBUTE.sql
	 8. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
	 9. create_ETL_Support_Client_Inquiry_triggers.sql
	10. create_ETL_Support_Client_Inquiry_grants_public_syn.sql

	-------------------------------------------------
	ManageEnrollmentActivity
	<future deployment>


----------------------------------------
5. TXEB PROJECT SCRIPTS SECTION - Part 2
---------------------------------------- 

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/createdb/
	-- or all files from DB_INITIAL_LOAD_TXEB_1.zip

        Run order 
	
	1. BPM_EVENT_PROJECT_pkg_body.pkg
	2. BPM_SEMANTIC_PROJECT_pkg_body.sql
	3. create_all_grants_public_syn.sql

-----------------
6. START BPM JOBS
-----------------

	Run to start BPM calculation and queue processing jobs that will 
	process ETL staging table results when available.  These jobs will 	
	populate the BPM Event and Semantic data model tables.

	1. execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

	Note: Job cans be stopped via: 
		execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;