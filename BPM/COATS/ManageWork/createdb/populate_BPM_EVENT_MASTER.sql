insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (1,5,4,1,1,'COATS Manage Work','COATS Manage Work',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;