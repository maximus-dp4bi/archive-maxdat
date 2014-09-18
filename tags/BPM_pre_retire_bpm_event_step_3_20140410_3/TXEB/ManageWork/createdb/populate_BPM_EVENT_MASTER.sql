insert into bpm_event_master (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,name,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (1,1,2,1,1,'TXEB OPS Manage Work','TXEB Operations Manage Work',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;