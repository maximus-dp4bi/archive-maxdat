-- All files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageJobs/createdb
-- or (project) svn://rcmxapp1d.maximus.com/maxdat/BPM/(project)/ManageJobs/createdb
-- or DB_INITIAL_LOAD_MANAGEJOBS_1.zip

Run order:
	
 1. create_ETL_ManageJobs_tables.sql
 2. create_ETL_ManageJobs_sequences.sql
 3. SemanticModel_Manage_Jobs.sql
 4. MANAGE_JOBS_pkg.sql
 5. populate_lkup_tables.sql
 6. (project) populate_BPM_EVENT_MASTER.sql
 7. INSERT_CORP_ETL_CONTROL.sql
 8. create_ETL_ManageJobs_triggers.sql
 9. create_ETL_ManageJobs_grants_public_syn.sql
