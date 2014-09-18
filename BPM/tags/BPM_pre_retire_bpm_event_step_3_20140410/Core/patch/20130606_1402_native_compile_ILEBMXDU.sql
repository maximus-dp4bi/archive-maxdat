alter session set plsql_code_type = native;

alter package BPM_COMMON compile;
alter package CORP_ETL_MANAGE_WORK_PKG compile;
alter function GET_BUS_DATE compile;
alter function GET_INLIST_STR2 compile;	
alter function GET_INLIST_STR3 compile;
alter function GET_WEEKDAY compile;
alter procedure MAINTAIN_BPM_D_DATES compile;
alter package MANAGE_MAIL_FAX_DOC compile;
alter package PROCESS_BPM_QUEUE_JOB_CONTROL compile;

drop procedure PROCPRINTHELLOWORLD;

commit;

alter session set plsql_code_type = interpreted;
