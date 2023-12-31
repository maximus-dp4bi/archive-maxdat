
insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (2004,'Process Documents','FEDQIC Process Documents');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2005,'FEDQIC_ETL_DOCUMENTS',6);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (383,2005,2,'Y'); 

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (384,2005,0,'Y'); 

update PROCESS_BPM_QUEUE_JOB_CONFIG set MIN_NUM_JOBS = 1, INIT_NUM_JOBS = 1, MAX_NUM_JOBS = 100, BATCH_SIZE = 100;

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) values (163,'Process_Documents','CALC_DDOCCUR','N'); 

insert into BPM_EVENT_MASTER values (2003, 3,14, 3,2004,'FEDQIC Documents','FEDQIC Documents',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;
