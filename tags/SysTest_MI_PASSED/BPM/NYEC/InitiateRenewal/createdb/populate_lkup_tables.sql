-- Manage Inbound Info

insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (6,'Initiate Renewal','Initiate Renewal for eligible NY public health families');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (6,'NYEC_ETL_MONITOR_RENEWAL',1);

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (6,1,6,2,6,'NYEC OPS Initiate Renewal','NYEC Operations Initiate Renewal',sysdate,to_date('20770707','YYYYMMDD'));
