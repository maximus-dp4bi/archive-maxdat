Instructions to install TNRD Database Scripts

********************************************************************************
Prerequisites: 
1. Database install with Maxdat schema and users created
2. Install these 2 items as user sys as sysdba

   A. Download and run this script:
	svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/patch/20151001_1653_create_maxdat_user.sql 

   B. Run this command:
	create role MAXDAT_READ_ONLY;

   C. Download and run this script:
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/userlock.sql


-----------------------
1. CORE SCRIPTS SECTION
-----------------------

	(Core install sections from 
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt )
	
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  

	-- Ordered list of files to deploy to install MAXDAT ETL core database schema.
	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/

	BPM/Core/createdb/create_ETL_tables.sql
	BPM/Core/createdb/create_ETL_sequences.sql
	BPM/Core/createdb/create_ETL_triggers.sql
	BPM/Core/createdb/ETL_COMMON_pkg.sql
	BPM/Core/createdb/CORP_ETL_STAGE_pkg.sql
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
	BPM/DataModel/BpmSemantic/createdb/BPM_SEMANTIC_PROJECT_pkg_spec.sql
	BPM/DataModel/BpmSemantic/createdb/BPM_SEMANTIC_pkg.sql
	BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB.sql
	BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_pkg.sql
	BPM/EventQueue/createdb/PBQJ_ADJUST_REASON_pkg.sql
	BPM/Admin/createdb/MAXDAT_ADMIN_AUDIT_LOGGING.sql
	BPM/Admin/createdb/MAXDAT_ADMIN_pkg.sql
	BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql



----------------------------
2. CORPORATE SCRIPTS SECTION
----------------------------

 	Core install sections from 
	svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/doc/install_core_README.txt 
  	   Prerequisite: svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/

	Run order:

	1. create_ETL_initialize_tables.sql
	2. create_ETL_initialize_views.sql
	3. create_ETL_initialize_triggers.sql        


	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/

	Run order:

        1. populate_CORP_ETL_CONTROL.sql
        

----------------------------------------
3. TNRD PROJECT SCRIPTS SECTION - Part 1
----------------------------------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/createdb/

        Run order:
		
	1. populate_BPM_PROJECT_LKUP.sql
	2. BPM_LAST_ETL_RUN_SV.sql
	3. MASH_views.sql


----------------------------------------
4. CORP and TNRD PROCESS SCRIPTS SECTION
----------------------------------------

    -------------------------------------------------
    ManageWork

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/

        Run order:
	
	 1. create_ETL_MW_V2_tables.sql
	 2. SemanticModel_MW_V2.sql
	 3. create_ETL_MW_V2_sequences.sql
	 4. create_ETL_MW_V2_triggers.sql
	 5. create_ETL_MW_V2_views.sql
	 6. populate_CORP_ETL_CONTROL.sql
	 7. populate_CORP_ETL_CONTROL.sql
	 8. populate_D_MW_V2_TASK_TYPE.sql
	 9. populate_lkup_tables.sql 
	10. populate_Dimensions.sql
	11. CORP_ETL_MW_V2_pkg.sql
	12. MW_V2_pkg.sql

        -- Files can be found at:
        -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/MW_V2/createdb/

        13. populate_lkup_tables.sql  
  

	-------------------------------------------------
	ProcessLetters

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/ProcessLetters/createdb/

        Run order:
	
	 1. create_ETL_ProcessLetters_tables.sql
         2. SemanticModel_Process_Letters.sql
         3. create_ETL_ProcessLetters_sequences.sql
         4. create_ETL_ProcessLetters_triggers.sql
         5. TRG_AU_CORP_ETL_PROC_LETTERS_Q.sql
         6. TRG_AI_CORP_ETL_PROC_LETTERS_Q.sql       
         7. ETL_PROCESS_LETTERS_PKG.sql

         -- All files can be found at:
         -- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessLetters/createdb/
	 8. populate_lkup_tables.sql
         9. PROCESS_LETTERS_pkg.sql

         -- All files can be found at:
         -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/ProcessLetters/createdb/
	 10. populate_lkup_tables.sql
	 11. populate_CORP_ETL_CONTROL.sql 
        
   	-------------------------------------------------
	MailFaxBatch

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MailFaxBatch/createdb/

        Run order:
	
	   1. create_ETL_MailFaxBatch_tables.sql
         2. SemanticModel_Mail_Fax_Batch.sql
         3. create_ETL_MailFaxBatch_sequences.sql
         4. create_ETL_MailFaxBatch_triggers.sql
         5. create_ETL_MailFaxBatch_covered_indexes.sql
         6. populate_CORP_ETL_LIST_LKUP.sql        
         7. MAIL_FAX_BATCH_pkg.sql
         8. populate_lkup_tables.sql
         
         -- All files can be found at:
         -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/MailFaxBatch/createdb
         9. populate_CORP_ETL_CONTROL_table.sql  


----------------------------------------
5. TNRD PROJECT SCRIPTS SECTION - Part 2
---------------------------------------- 

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TNRD/createdb/

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
	
