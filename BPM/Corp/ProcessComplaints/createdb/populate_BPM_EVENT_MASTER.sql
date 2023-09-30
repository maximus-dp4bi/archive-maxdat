
insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (22,1,8,1,22,'Process Complaints Incidents','Process Complaints Incidents',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;

