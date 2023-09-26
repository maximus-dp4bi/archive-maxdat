/*
Process: Manage Work V2 process.
v1 Raj A. 25-Sep-2014 Creation.
v2 Raj A. 12-May-2015 Separated the insert for BPM_event_master and kept it in the project folder as it differs for every project.
v3 Raj A. 10/14/2015 Moved BPM_SOURCE_LKUP insert to project specific folder because it changes with each project (ex: NYHIX has ProcessLetters BSTL_ID=8 and TNRD  BSTL_ID=1)

****IMP: for initial deployment of this process (MW_V2) deploy corp/MW_V2/createdb/populate_lkup_tables.sql and 
also project-folder/MW_V2/createdb/populate_lkup_tables.sql
*/
insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (2001,'Manage Work V2','Review and perform work assigned.');

--insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2001,'CORP_ETL_MW_V2',1);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,2001,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'MW_V2','CALC_DMWCUR_V2','Y');

--insert into BPM_EVENT_MASTER VALUES(2001,1,8,1,2001,'NYHIX OPS Manage Work V2','NYHIX Operations Manage Work V2',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;