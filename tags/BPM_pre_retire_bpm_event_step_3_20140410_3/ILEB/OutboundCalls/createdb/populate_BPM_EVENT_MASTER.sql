Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (20,1,7,1,20,'Outbound Call','Outbound Dialer Call',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;

