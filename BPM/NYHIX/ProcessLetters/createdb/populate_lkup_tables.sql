/*
v1 06/10/2014 Raj A.  Creation
v2 10/14/2015 Raj A.  Moved BPM_SOURCE_LKUP insert to project specific folder because it changes with each project (ex: NYHIX has BSTL_ID=8 and TNRD  BSTL_ID=1)
                      Removed it from BPM/Corp/ProcessLetters/createdb/populate_lkup_tables.sql
*/
insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (12,'CORP_ETL_PROC_LETTERS',8);

Insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (12,1,8,1,12,'NYHIX Process Letters','NYHIX Letter Request Processing',sysdate,BPM_COMMON.GET_MAX_DATE);

commit;