insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (7,'Process State Review','Provide the state a way to review application results,and approve or reject');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (7,'NYEC_ETL_STATE_REVIEW',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,7,2,'Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (8,'State Review Task ID'); 

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (7,1,6,2,7,'NYEC OPS Process State Review','NYEC Operations Process State Review',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;
