Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) values (12,1,2,1,12,'ILEB Process Letters','ILEB Letter Request Processing',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;