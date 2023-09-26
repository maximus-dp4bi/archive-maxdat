/*
Process: Manage Work V2 process.
v1 Raj A. 10/14/2015 Creation. This is a project & process specific file.

****IMP: for initial deployment of this process (MW_V2) deploy corp/MW_V2/createdb/populate_lkup_tables.sql and 
also project-folder/MW_V2/createdb/populate_lkup_tables.sql
*/

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (2001,'CORP_ETL_MW_V2',1);

Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (40,2,13,2,2001,'TNRD Manage Work V2','TNRD MW V2 Processing',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;