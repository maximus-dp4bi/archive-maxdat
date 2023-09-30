------------------------------------------------------------------------------------------------- 

Prerequisites: 
1. Database install with Maxdat schema and users created 

2. Install these 2 items as user sys as sysdba 

   A. Run this command: 
create role MAXDAT_READ_ONLY; 

   B. Run this script from 
svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/userlock.sql 

   C. Grant Create Public Synonym access to MAXDAT user. 

----------------------- 
1. CORE SCRIPTS SECTION 
----------------------- 

Core install sections from 
svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt 

-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT: 

-- Ordered list of files to deploy to install MAXDAT ETL core database schema. 
-- All files can be found at: 
-- svn://rcmxapp1d.maximus.com/maxdat/ 
-- or DB_INITIAL_LOAD_CORE_1.zip 

BPM/Core/createdb/create_ETL_tables.sql 
BPM/Core/createdb/create_ETL_sequences.sql 
BPM/Core/createdb/create_ETL_triggers.sql 
BPM/Core/createdb/ETL_COMMON_pkg.sql 
BPM/Core/createdb/CORP_ETL_STAGE_pkg.sql 
BPM/Core/createdb/create_ETL_functions.sql 

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
BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql 
BPM/Admin/createdb/MAXDAT_ADMIN_AUDIT_LOGGING.sql 
BPM/Admin/createdb/MAXDAT_ADMIN_pkg.sql 

BPM/Admin/createdb/GATHER_STATS_TABLE_CONFIG.sql 
BPM/Admin/createdb/MAXDAT_STATISTICS_pkg.sql 


---------------------------- 
2. CORPORATE SCRIPTS SECTION 
---------------------------- 

-- All files can be found at: 
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/ 
-- or DB_INITIAL_LOAD_CORP_1.zip 

Run order: 

1. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/create_ETL_initialize_tables.sql 
2. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/create_ETL_initialize_views.sql 
3. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/create_ETL_initialize_triggers.sql 

---------------------------------------- 
3. COATS PROJECT SCRIPTS SECTION - Part 1 
---------------------------------------- 

-- Files can be found at: 
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/createdb/ 

Run order: 

1. svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/createdb/populate_BPM_D_OPS_GROUP_TASK.sql 
2. svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/createdb/populate_BPM_PROJECT_LKUP.sql 
3. svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/createdb/MASH_views.sql 
 

---------------------------------------- 
4. COATS MANAGE WORK 
---------------------------------------- 

1. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_tables.sql 
2. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_sequences.sql 
3. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_views.sql 
4. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/SemanticModel_Manage_Work.sql 
5. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/CORP_ETL_MANAGE_WORK_pkg.sql 
6. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/MANAGE_WORK_pkg.sql 
7. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/populate_CORP_ETL_CONTROL.sql 
8. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/populate_lkup_tables.sql 
9. svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/ManageWork/createdb/populate_BPM_EVENT_MASTER.sql 
10. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/create_ETL_ManageWork_triggers.sql 
11. svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/createdb/BPM_SEMANTIC_PROJECT_pkg_body.sql 
12. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/insert_MW_list_lkup_status_order.sql 

---------------------------------------- 
5. COATS Production Planning 
---------------------------------------- 

1. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProductionPlanning/createdb/create_CORP_production_planning_bpm_tables.sql 
2. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProductionPlanning/createdb/create_micro_strat_grants.sql 
3. svn://rcmxapp1d.maximus.com/maxdat/BPM/COATS/ProductionPlanning/createdb/populate_production_planning_LKUP_tables.sql 

----------------- 
6. START BPM JOBS 
----------------- 

Please wait for all previous steps to be verified before executing this Step 6. 

Run to start BPM calculation and queue processing jobs that will 
process ETL staging table results when available. These jobs will 
populate Semantic data model tables. 

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