insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (1,'Manage Work','Review and perform work assigned.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (1,'CORP_ETL_MANAGE_WORK',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,1,2,'Y');

commit;