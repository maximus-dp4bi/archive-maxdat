/*
Process: Manage Work V2 process.
v1 Raj A. 12-May-2015 Creation. Separated the insert for BPM_event_master and kept it in the project folder as it differs for every project.
v2 Raj A. 10/14/2015 Moved BPM_SOURCE_LKUP insert to project specific folder because it changes with each project (ex: NYHIX has BSTL_ID = 8, TN, )

IMPORTANT: 
For initial deployment of this process (MW_V2) deploy corp/MW_V2/createdb/populate_lkup_tables.sql and 
also project-folder/MW_V2/createdb/populate_lkup_tables.sql
*/
insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2001,'CORP_ETL_MW_V2',1);

insert into BPM_EVENT_MASTER VALUES(2001,1,8,1,2001,'NYHIX OPS Manage Work V2','NYHIX Operations Manage Work V2',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;