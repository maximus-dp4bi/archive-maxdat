insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) values (19,1,7,1,19,'Process Online Info','Process Online Information',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;
