insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (2,'Process Application','Process additional information related to an application and determine if application can be completed.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2,'NYEC_ETL_PROCESS_APP',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,2,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'NYEC_PROCESS_APP','CALC_DNPACUR','Y');

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) values (2,1,6,2,2,'NYEC OPS Process Application','NYEC Operations Process Application',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;