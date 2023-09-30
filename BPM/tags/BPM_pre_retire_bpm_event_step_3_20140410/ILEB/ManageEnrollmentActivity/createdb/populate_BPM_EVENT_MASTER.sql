insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (14,1,7,1,14,'ILEB Manage Enrollment','Illinois EB DPY Manage Enrollment Activity',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;