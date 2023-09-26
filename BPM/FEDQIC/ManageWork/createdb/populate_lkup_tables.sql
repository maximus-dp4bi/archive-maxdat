/*
Process: MW Rel 6 process.
v1 Guy T. 13-Oct-2017 Creation.
****IMP: for initial deployment of this process (MW Rel 6) deploy corp/MW/createdb/populate_lkup_tables.sql and 
also project-folder/MW/createdb/populate_lkup_tables.sql
*/

delete process_bpm_queue_job_batch;
delete process_bpm_queue_job;
delete process_bpm_queue_job_config;
delete process_bpm_queue_job_ctrl_cfg;
delete BPM_EVENT_MASTER;
delete BPM_SOURCE_LKUP;
delete PROCESS_BPM_CALC_JOB_CONFIG; 
delete BPM_PROJECT_LKUP;
delete BPM_PROCESS_LKUP; 
delete BPM_PROGRAM_LKUP;
delete BPM_SOURCE_TYPE_LKUP;

insert into BPM_PROGRAM_LKUP (BPRG_ID,NAME) values (3,'ENTELLITRAK');
insert into BPM_SOURCE_TYPE_LKUP (BSTL_ID,NAME) values (6,'ENTELLITRAK ETL');

insert into BPM_PROJECT_LKUP(BPRJ_ID,NAME) values (14,'Federal QIC'); 
insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (2002,'MW','Review and perform work assigned and integrate production planning.');
insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2003,'FEDQIC_ETL',6);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,2003,2,'Y');
insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,2003,0,'Y');
update PROCESS_BPM_QUEUE_JOB_CONFIG set MIN_NUM_JOBS = 1, INIT_NUM_JOBS = 1, MAX_NUM_JOBS = 100, BATCH_SIZE = 100;

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'MW','CALC_DMWCUR','Y');

insert into BPM_EVENT_MASTER VALUES(42,3,14,3,2002,'Federal QIC','Federal QIC',sysdate,BPM_COMMON.GET_MAX_DATE);

INSERT INTO PROCESS_BPM_QUEUE_JOB_CTRL_CFG (MAX_TOTAL_NUM_JOBS, NUM_JOBS_TO_DEL_DURING_ADJUST, NUM_JOBS_TO_ADD_DURING_ADJUST, NUM_GROUP_CYCLES_BEFORE_ADD, CONTROL_JOB_SLEEP_SECONDS, LOCK_TIMEOUT_SECONDS, PROCESS_SLEEP_SECONDS, PROCESS_BATCH_SECONDS, START_DELAY_SECONDS, STOP_DELAY_SECONDS, PROCESSING_ENABLED) 
VALUES (64, 1, 4, 2, 30, 300, 120, 10, 10, 5, 'Y');

commit;