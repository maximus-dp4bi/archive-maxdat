insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (10,'Process Incidents',' Provide the means for an enrollee, potential enrollee, plan, provider, or others, including anonymous callers to report incidents and to provide support in the resolution of incidents. Incidents can be reported via mail/fax, phone or online.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (10,'CORP_ETL_PROCESS_INCIDENTS',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,10,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'DPY_PROCESS_INCIDENTS','CALC_DPICUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (10,'Incident ID'); 

commit;