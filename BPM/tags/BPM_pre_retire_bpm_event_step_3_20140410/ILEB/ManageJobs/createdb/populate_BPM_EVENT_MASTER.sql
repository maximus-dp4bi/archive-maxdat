insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) values (11,1,7,1,11,'ILEB Manage Jobs','ILEB Manage Jobs Processing',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;
