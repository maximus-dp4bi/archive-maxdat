insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (14,'Manage Enrollment Activity','Manage Client Enrollment Activity.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (14,'CORP_ETL_MANAGE_ENROLL',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,14,2,'Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (14,'Client Enroll Status ID');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'MANAGE_ENROLL','CALC_DMECUR','Y');

commit;
