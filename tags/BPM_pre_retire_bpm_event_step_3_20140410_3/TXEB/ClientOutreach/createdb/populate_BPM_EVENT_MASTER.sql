Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (15,1,2,1,15,'Client Outreach','Conduct Client Outreach',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;