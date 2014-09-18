
insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (9,1,7,1,9,'ILEB Process Mail Fax Docs','ILEB Process mail fax documents',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;

