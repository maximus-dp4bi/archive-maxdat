-- Manage Inbound Info

insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (5,'Process Missing Info','Missing information needed to complete processing an application.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (5,'NYEC_ETL_PROCESS_MI',1);

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (7,'Missing Task ID');

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (5,1,6,2,5,'NYEC OPS Process MI','NYEC Operations Process Missing Info',sysdate,to_date('20770707','YYYYMMDD'));
