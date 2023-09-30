-- All files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageJobs/createdb
-- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageJobs/createdb
-- or DB_INITIAL_LOAD_MANAGEJOBS_1.zip

Run order:
	
 1. create_ETL_ManageJobs_tables.sql
 2. create_ETL_ManageJobs_sequences.sql
 3. SemanticModel_Manage_Jobs.sql
 4. MANAGE_JOBS_pkg.sql
 5. populate_lkup_tables.sql
 6. (TXEB) populate_BPM_EVENT_MASTER.sql
 7. populate_BPM_ATTRIBUTE_LKUP.sql
 8. populate_BPM_ATTRIBUTE.sql
 9. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
10. INSERT_CORP_ETL_CONTROL.sql
11. (TXEB) INSERT_CORP_MJ_ETL_FILE_LKUP.sql
12. (TXEB) INSERT_CORP_MJ_FILE_CAL_LKUP.sql
13. create_ETL_ManageJobs_triggers.sql
14. create_ETL_ManageJobs_grants_public_syn.sql
