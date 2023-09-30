prompt PL/SQL Developer import file
prompt Created on Tuesday, July 10, 2012 by m18957
set feedback off
set define off
prompt Loading CORP_ETL_LIST_LKUP...
insert into CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS)
values ( 'MI_TASK_TYPE', 'LIST', 'State Data Entry Task - MI', 'Missing Information', 'STEP_INSTANCE_ID', 32381, Sysdate -1, to_date('07-07-7777', 'dd-mm-yyyy'), 'Monitor Type for Tasks', sysdate, sysdate);
commit;
prompt 1 records loaded
set feedback on
set define on
prompt Done.
