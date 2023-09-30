/*
Process: MW Rel 6 process.
v1 Guy T. 13-Oct-2017 Creation.
****IMP: for initial deployment of this process (MW Rel 6) deploy corp/MW/createdb/populate_lkup_tables.sql and 
also project-folder/MW/createdb/populate_lkup_tables.sql
*/
--insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (2002,'Manage Work','Review and perform work assigned.');

--insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2002,'CORP_ETL_MW',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,2002,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'MW','CALC_DMWCUR','Y');

--insert into BPM_EVENT_MASTER VALUES(2002,1,0,1,2002,'OPS MW Rel 6','Operations MW Rel 6',sysdate,BPM_COMMON.GET_MAX_DATE);
INSERT INTO PROCESS_BPM_QUEUE_JOB_CTRL_CFG (MAX_TOTAL_NUM_JOBS, NUM_JOBS_TO_DEL_DURING_ADJUST, NUM_JOBS_TO_ADD_DURING_ADJUST, NUM_GROUP_CYCLES_BEFORE_ADD, CONTROL_JOB_SLEEP_SECONDS, LOCK_TIMEOUT_SECONDS, PROCESS_SLEEP_SECONDS, PROCESS_BATCH_SECONDS, START_DELAY_SECONDS, STOP_DELAY_SECONDS, PROCESSING_ENABLED) 
VALUES (64, 1, 4, 2, 30, 300, 120, 10, 10, 5, 'Y');

commit;