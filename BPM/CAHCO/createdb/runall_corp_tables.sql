--------------------------------------------------------
--  Deploy corp tables found in BPM/Core/createdb folder 
--------------------------------------------------------
@@create_ETL_tables.sql
@@create_ETL_sequences.sql
@@create_ETL_triggers.sql
@@ETL_COMMON_pkg.sql
@@CORP_ETL_STAGE_pkg.sql
@@create_ETL_functions.sql
@@create_core_BPM_Event_tables.sql
@@create_sequences.sql
@@BPM_D_DATES.sql
@@BPM_COMMON_pkg.sql
@@create_triggers.sql
@@populate_BPM_D_HOURS.sql
@@populate_BPM_DATA_MODEL.sql
@@populate_HOLIDAYS.sql
@@populate_core_lkup_tables.sql
@@userlock.sql

--------------------------------------------------------
--  Deploy corp tables found in BPM/Admin/createdb folder 
--------------------------------------------------------
@@SVN_REVISION_KEYWORD_pkg.sql
@@SVN_REVISION_DEPLOYED.sql
@@MAXDAT_ADMIN_pkg.sql
@@MAXDAT_ADMIN_AUDIT_LOGGING.sql

--------------------------------------------------------
--  Deploy corp tables found in BPM/EventQueue/createdb folder 
--------------------------------------------------------
@@PROCESS_BPM_QUEUE_JOB.sql
@@PROCESS_BPM_QUEUE_pkg.sql
@@PBQJ_ADJUST_REASON_pkg.sql
@@PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql
@@BPM_UPDATE_EVENT_QUEUE.sql

--------------------------------------------------------
--  Deploy corp tables found in BPM/DataModel/BpmSemantic folder 
--------------------------------------------------------
@@BPM_SEMANTIC_PROJECT_pkg_spec.sql
@@BPM_SEMANTIC_pkg.sql
