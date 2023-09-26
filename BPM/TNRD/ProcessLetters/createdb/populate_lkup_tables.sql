/*
Created on 10/14/2015 by Raj A.
Description: This is a project & process specific file.
*/
insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (12,'CORP_ETL_PROC_LETTERS',1);

Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (41,2,13,2,12,'TNRD Process Letters','TNRD Letter Request Processing',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;