-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT:  
-- (or as a proxy login to MAXDAT)   Example: rk50472[maxdat]


-- Ordered list of files to deploy to install MAXDAT ETL core database schema.
-- All files can be found in SVN at: svn://rcmxapp1d.maximus.com/maxdat/

BPM/Core/createdb/create_ETL_tables.sql
BPM/Core/createdb/create_ETL_sequences.sql
BPM/Core/createdb/create_ETL_triggers.sql
BPM/Core/createdb/ETL_COMMON_pkg.sql
BPM/Core/createdb/CORP_ETL_STAGE_pkg.sql
BPM/Core/createdb/create_ETL_functions.sql


-- Ordered list of files to deploy to install MAXDAT BPM core database schema.
-- All files can be found in SVN at: svn://rcmxapp1d.maximus.com/maxdat/

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
BPM/Admin /createdb/MAXDAT_ADMIN_AUDIT_LOGGING.sql
BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql
BPM/Admin /createdb/MAXDAT_ADMIN_pkg.sql

