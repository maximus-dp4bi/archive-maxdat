insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (11,'Manage Jobs','Process to support the timely processing of enrollment activities by ensuring information received or transmitted via interface file is processed as expected.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (11,'CORP_ETL_MANAGE_JOBS',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,MIN_NUM_JOBS,INIT_NUM_JOBS,MAX_NUM_JOBS,BATCH_SIZE,ENABLED) values (SEQ_PBQJC_ID.nextval,11,1,null,null,null,null,'Y');
insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,MIN_NUM_JOBS,INIT_NUM_JOBS,MAX_NUM_JOBS,BATCH_SIZE,ENABLED) values (SEQ_PBQJC_ID.nextval,11,2,null,null,null,null,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'MANAGE_JOBS','CALC_DMJCUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (11,'Job ID');

commit;