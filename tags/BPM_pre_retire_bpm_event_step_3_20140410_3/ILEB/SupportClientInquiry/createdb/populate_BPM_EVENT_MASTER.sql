insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (13,1,7,1,13,'ILEB Client Inquiry','Illinois EB Support Client Inquiries',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;