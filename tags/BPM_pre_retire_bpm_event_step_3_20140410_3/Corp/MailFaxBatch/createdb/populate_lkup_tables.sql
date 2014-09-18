
insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values ('16','Process Mail Fax Batch','Information needed to provide batch level monitoring on all inbound client information received via mail or fax and processed through KOFAX.');

INSERT INTO BPM_SOURCE_TYPE_LKUP (BSTL_ID,NAME) values (10,'KOFAX-MAXEB ETL');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (16,'CORP_ETL_MFB_BATCH',10);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,16,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED)  
values (SEQ_PBCJC_ID.nextval,'MAIL_FAX_BATCH','CALC_DMFBCUR','Y');

commit;



