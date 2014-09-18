insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (6,'Initiate Renewal','Initiate Renewal for eligible NY public health families');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (6,'NYEC_ETL_MONITOR_RENEWAL',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,6,2,'Y');

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (6,1,6,2,6,'NYEC OPS Initiate Renewal','NYEC Operations Initiate Renewal',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;
