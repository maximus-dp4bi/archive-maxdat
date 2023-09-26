------------------------------------------------------------------------------------------------- 

Install these 2 items as user sys as sysdba (If these do not already exist)

   A. Run this command: 
create role MAXDAT_READ_ONLY; 

   B. Run this script from 
svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/userlock.sql 


----------------------- 
1. CORE SCRIPTS SECTION 
----------------------- 

   All files can be found at : svn://rcmxapp1d.maximus.com/maxdat/
   Run these SQL scripts below in the new database as the the Oracle user MAXDAT: 

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

   All files can be found at: svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/ 
   Run order: 

create_ETL_initialize_tables.sql 
create_ETL_initialize_views.sql 
create_ETL_initialize_triggers.sql

---------------------------------------- 
3. CADIR PROJECT SCRIPTS SECTION - Part 1 
---------------------------------------- 

   Files can be found at: svn://rcmxapp1d.maximus.com/maxdat/BPM/CADIR/createdb/ 
   Run order: 

create_d_staff_table_views.sql
populate_BPM_PROJECT_LKUP.sql 
populate_HOLIDAYS.sql
BPM_LAST_ETL_RUN_SV.sql
MASH_views.sql 

---------------------------------------- 
4. CADIR MANAGE WORK 
---------------------------------------- 

   Files can be found at: svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb/ 
   Run order: 

create_ETL_ManageWork_tables.sql 
create_ETL_ManageWork_sequences.sql 
create_ETL_ManageWork_views.sql 
SemanticModel_Manage_Work.sql 
MANAGE_WORK_pkg.sql 
populate_CORP_ETL_CONTROL.sql 
populate_lkup_tables.sql 
create_ETL_ManageWork_triggers.sql 


---------------------------------------- 
5. CORP Production Planning 
---------------------------------------- 

   Files can be found at: svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProductionPlanning/createdb/ 
   Run order: 

create_CORP_production_planning_bpm_tables.sql 
create_micro_strat_grants.sql 

---------------------------------------- 
6. CADIR PROJECT SCRIPTS SECTION - Part 2 
---------------------------------------- 

   Run the following:
svn://rcmxapp1d.maximus.com/maxdat/BPM/CADIR/ManageWork/createdb/populate_BPM_EVENT_MASTER.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/CADIR/ManageWork/createdb/cadir_etl_manage_work_pkg.sql

----------------- 
7. START BPM JOBS 
----------------- 

Please wait for all previous steps to be verified before executing this Step 7. 

Run to start BPM calculation and queue processing jobs that will 
process ETL staging table results when available. These jobs will 
populate Semantic data model tables. 

1. execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS; 

Note: Job cans be stopped via: 
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS; 


-------------
8. SMOKE TEST
-------------

	Wait 5 minutes for all the jobs to start up in the background.

	Verify that there are no SEVERE or WARNING errors:

		select * from BPM_LOGGING;

	Verify that MaxDat BPM queue processing jobs are running:
	(should be several BSL_IDs and BDM_IDs with jobs SLEEPING 
	 or PROCESSING (rare at this stage)

		select * from PROCESS_BPM_QUEUE_JOB 
		where STATUS != 'STOPPED' order by BSL_ID asc, BDM_ID asc;