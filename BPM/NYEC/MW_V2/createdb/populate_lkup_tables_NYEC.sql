/*
Process: Manage Work V2 process.
v1 Raj A. 12-May-2015 Creation. Separated the insert for BPM_event_master and kept it in the project folder as it differs for every project.

****IMP: for initial deployment of this process (MW_V2) deploy corp/MW_V2/createdb/populate_lkup_tables.sql and 
also project-folder/MW_V2/createdb/populate_lkup_tables.sql
*/
insert into BPM_EVENT_MASTER VALUES(2001,1,6,1,2001,'NYEC OPS Manage Work V2','NYEC Operations Manage Work V2', sysdate, BPM_COMMON.GET_MAX_DATE);

commit;