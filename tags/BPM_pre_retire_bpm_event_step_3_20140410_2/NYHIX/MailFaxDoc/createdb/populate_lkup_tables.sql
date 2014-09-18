insert into BPM_PROCESS_LKUP values(18,'NYHIX Process Mail Fax Docs','Process documents coming through mail and fax first into kofax then DMS and then MAXEB');

insert into BPM_SOURCE_TYPE_LKUP values(8,'DMS-MAXEB ETL');

insert into BPM_SOURCE_LKUP values(18,'NYHIX_ETL_MAIL_FAX_DOC',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,18,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) values (SEQ_PBCJC_ID.nextval,'NYHIX_MAIL_FAX_DOC','CALC_D_NYHIX_MF_CUR','Y');

insert into BPM_EVENT_MASTER VALUES(18,1,8,1,18,'NYHIX Process Mail Fax Doc','NYHIX Process Mail Fax Doc',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;