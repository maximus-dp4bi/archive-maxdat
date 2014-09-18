alter session set plsql_code_type = native;

alter package BPM_COMMON compile;
alter package BPM_EVENT compile;
alter package BPM_EVENT_PROJECT compile;
alter package BPM_SEMANTIC compile;
alter package BPM_SEMANTIC_PROJECT compile;
alter package CORP_ETL_MANAGE_WORK_PKG compile;
alter package ETL_COMMON compile;
alter package MAIL_FAX_BATCH compile;
alter package MANAGE_WORK compile;
alter package MAXDAT_ADMIN compile;
alter package NYHIX_MAIL_FAX_DOC compile;
alter package PBQJ_ADJUST_REASON compile;
alter package PROCESS_BPM_QUEUE compile;
alter package PROCESS_BPM_QUEUE_JOB_CONTROL compile;
alter package PROCESS_COMPLAINTS_INCIDENTS compile;
alter package SVN_REVISION_KEYWORD compile;

alter session set plsql_code_type = interpreted;