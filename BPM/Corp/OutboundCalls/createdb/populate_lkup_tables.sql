insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (20,'Outbound Dialer Calls',
'The scope of Process Outbound Calls deployment is to monitor call attempts and the outcome of call attempts made through the use of the outbound dialer.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (20,'CORP_ETL_PROC_OUTBND_CALL',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,20,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'OUTBOUND_CALLS','CALC_DOBCCUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (20,'CEPOC ID');

commit;