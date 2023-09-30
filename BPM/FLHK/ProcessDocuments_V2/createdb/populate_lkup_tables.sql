insert into BPM_SOURCE_TYPE_LKUP values(11, 'VIDA ETL');

insert into BPM_PROCESS_LKUP values(35,'FLHK Process Mail Fax Documents','The process represents how a document is received into Vida and work identified and created.');

--insert into BPM_SOURCE_TYPE_LKUP values(11,'VIDA ETL');

insert into BPM_SOURCE_LKUP values(35,'FLHK_ETL_DOCUMENTS_V2',11);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,35,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) values (SEQ_PBCJC_ID.nextval,'FLHK_DOCUMENTS','CALC_D_FLHK_DOCUMENTS_CUR','Y');

insert into BPM_EVENT_MASTER VALUES(35,5,12,1,35,'FLHK Process Mail Fax Documents','FLHK Process Mail Fax Documents',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;