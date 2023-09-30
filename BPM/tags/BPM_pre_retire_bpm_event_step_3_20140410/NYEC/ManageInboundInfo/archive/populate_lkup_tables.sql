-- Manage Inbound Info

insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (3,'Manage Inbound Info','Provide batch, envelope and document reporting for projects using the MAXe ATS system and KOFAX system.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (3,'NYEC_ETL_MANAGE_INBOUND_INFO',1);

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (5,'Envelope ID');

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (3,1,6,2,3,'NYEC OPS Manage Inbound Info','NYEC Operations Manage Inbound Info',sysdate,to_date('20770707','YYYYMMDD'));