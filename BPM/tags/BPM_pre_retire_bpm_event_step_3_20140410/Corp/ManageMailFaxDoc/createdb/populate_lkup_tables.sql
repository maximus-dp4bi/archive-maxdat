insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (9,'Process Mail Fax Docs','Process documents coming through mail and fax first into kofax then DMS and then MAXEB ');

insert into BPM_SOURCE_TYPE_LKUP(BSTL_ID,NAME) values (8,'DMS-MAXEB ETL');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (9,'CORP_ETL_MAILFAXDOC',8);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,9,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'MANAGE_MAIL_FAX_DOC','CALC_DMFDOCCUR','Y');

commit;

