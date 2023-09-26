column tablespacename new_value tablespace_name noprint 
select 'MAXDAT_LAEB_DATA' tablespacename from dual;
column role_name new_value role_name noprint
select 'MAXDAT_LAEB_READ_ONLY' role_name from dual;
@@create_ETL_tables.sql
@@create_core_BPM_Event_tables.sql
@@BPM_D_DATES.sql
@@GATHER_STATS_TABLE_CONFIG.sql
@@create_ETL_sequences.sql
@@create_sequences.sql
@@BPM_COMMON_pkg.sql
@@ETL_COMMON_pkg.sql
@create_ETL_functions.sql
@@create_ETL_triggers.sql
@@create_triggers.sql
@@CORP_ETL_STAGE_pkg.sql
@@populate_BPM_D_HOURS.sql
@@populate_BPM_DATA_MODEL.sql
@@populate_HOLIDAYS.sql
@@MAXDAT_ADMIN_AUDIT_LOGGING.sql
@@BPM_UPDATE_EVENT_QUEUE.sql
@@PROCESS_BPM_QUEUE_JOB.sql
@@SVN_REVISION_KEYWORD_pkg.sql
@@BPM_SEMANTIC_PROJECT_pkg_spec.sql
@@BPM_SEMANTIC_pkg.sql
@@PROCESS_BPM_QUEUE_pkg.sql
@@PBQJ_ADJUST_REASON_pkg.sql
@@PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql
@@MAXDAT_ADMIN_pkg.sql
@@MAXDAT_STATISTICS_pkg.sql
@@create_d_dates_materialized_views.sql