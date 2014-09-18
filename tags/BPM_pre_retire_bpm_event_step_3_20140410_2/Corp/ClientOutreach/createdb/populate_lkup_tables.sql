insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (15,'Client Outreach',
'Conduct Client Outreach process includes all information necessary to monitor the receiving and processing of client outreach requests');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (15,'CORP_ETL_CLNT_OUTREACH',8);


insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,15,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'CLIENT_OUTREACH','CALC_DCORCUR','Y');


insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (15,'Outreach ID');

commit;
