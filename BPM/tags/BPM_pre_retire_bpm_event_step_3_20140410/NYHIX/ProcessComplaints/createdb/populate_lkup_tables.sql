insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (22,'NYHIX Process Complaints Incidents','NYHIX Process Complaints Incidents');

insert into BPM_SOURCE_TYPE_LKUP(BSTL_ID,NAME) values (9,'MAXEB ETL');

insert into BPM_IDENTIFIER_TYPE_LKUP(BIL_ID, name) values (10,'Incident ID');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (22,'NYHX_ETL_COMPLAINTS_INCIDENTS',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,22,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'PROCESS_COMPLAINTS_INCIDENTS','CALC_DCMPLCUR','Y');

commit;

