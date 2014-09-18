insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (12,'Process Letters','Processing letter requests and receive outcome confirmation of letter processing');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (12,'CORP_ETL_PROC_LETTERS',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,MIN_NUM_JOBS,INIT_NUM_JOBS,MAX_NUM_JOBS,BATCH_SIZE,ENABLED) values (SEQ_PBQJC_ID.nextval,12,1,null,null,null,null,'Y');
insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,MIN_NUM_JOBS,INIT_NUM_JOBS,MAX_NUM_JOBS,BATCH_SIZE,ENABLED) values (SEQ_PBQJC_ID.nextval,12,2,null,null,null,null,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'PROCESS_LETTERS','CALC_DPLCUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (12,'Letter Request ID');

commit;

