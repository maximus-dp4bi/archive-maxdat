insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (10,1,2,1,10,'TXEB Process Incidents','Texas EB DPY Process Incidents',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;