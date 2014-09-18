/*
Created on 10-Jun-2014 by Raj A.
*/
Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (12,1,8,1,12,'NYHIX Process Letters','NYHIX Letter Request Processing',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;