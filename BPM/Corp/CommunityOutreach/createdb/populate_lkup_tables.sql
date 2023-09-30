insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (17,'Community Outreach','Process is to promote the use of available State programs to the community by coordinating community outreach events.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (17,'CORP_ETL_COMM_OUTREACH',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,17,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'COMMUNITY_OUTREACH','CALC_DCMORCUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (17,'Outreach Session ID');

Commit;