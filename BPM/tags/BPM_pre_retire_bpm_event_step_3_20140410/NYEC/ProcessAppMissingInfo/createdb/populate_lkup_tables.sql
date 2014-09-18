insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (4,'Process Application Missing Info','Missing information needed to process an application.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (4,'NYEC_ETL_PROCESS_APP_MI',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,4,2,'Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (6,'Missing Info ID');

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (4,1,6,2,4,'NYEC OPS Process Application MI','NYEC Operations Process Application Missing Info',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;