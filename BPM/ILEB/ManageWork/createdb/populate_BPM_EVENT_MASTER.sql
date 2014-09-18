insert into bpm_event_master (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,name,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (1,1,7,1,1,'ILEB OPS Manage Work','ILEB Operations Manage Work',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;