insert into BPM_PROCESS_LKUP values(24,'NYHIX Process Mail Fax Docs V2','Process documents coming through mail and fax first into kofax then DMS and then MAXEB version 2');

--insert into BPM_SOURCE_TYPE_LKUP values(8,'DMS-MAXEB ETL');

insert into BPM_SOURCE_LKUP values(24,'NYHIX_ETL_MAIL_FAX_DOC V2',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,24,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) values (SEQ_PBCJC_ID.nextval,'NYHIX_MAIL_FAX_DOC_V2','CALC_D_NYHIX_MFD_CUR_V2','Y');

insert into BPM_EVENT_MASTER VALUES(24,1,8,1,24,'NYHIX Process Mail Fax Doc V2','NYHIX Process Mail Fax Doc V2',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;