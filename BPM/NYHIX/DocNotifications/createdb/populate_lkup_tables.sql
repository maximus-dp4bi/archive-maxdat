insert into BPM_PROCESS_LKUP values(30,'NYHIX Process Mail Fax Doc Notifications','Document Notification process is to monitor that all document notifications received from the NYSOH Portal are verified.');

--insert into BPM_SOURCE_TYPE_LKUP values(9,'MAXEB ETL');

insert into BPM_SOURCE_LKUP values(30,'NYHIX_ETL_DOC_NOTIFICATIONS',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,30,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) values (SEQ_PBCJC_ID.nextval,'NYHIX_DOC_NOTIFICATIONS','CALC_D_NYHIX_DN_CUR','Y');

insert into BPM_EVENT_MASTER VALUES(30,1,8,1,30,'NYHIX Process Doc Notifications','NYHIX Process Doc Notifications',sysdate,BPM_COMMON.GET_MAX_DATE);

insert into BPM_IDENTIFIER_TYPE_LKUP VALUES(22,'Document Notification ID');

commit;