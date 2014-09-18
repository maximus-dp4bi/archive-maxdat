insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (8,'Send Info to TP','Information Request for a specific client that must be shared with a Trading Partner');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (8,'NYEC_ETL_SENDINFOTRADPART',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,8,2,'Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (9,'Info Request ID'); 

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (8,1,6,2,8,'NYEC OPS Send Info to TP','NYEC Operations Send Info to Trading Partner',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;