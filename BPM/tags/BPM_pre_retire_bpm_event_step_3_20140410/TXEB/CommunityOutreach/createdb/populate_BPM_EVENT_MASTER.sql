Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) values 
(17,1,2,1,17,'Community Outreach','Coordinate Community Outreach Events',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;