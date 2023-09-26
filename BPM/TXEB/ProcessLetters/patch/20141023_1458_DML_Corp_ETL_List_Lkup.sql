/*
Added below two global controls by Raj A. on 10/23/2014. 
For performance improvement of TX PL. Intially checking processing (three letter types) saturday only.
*/
create index CEPL_LETTER_TYPE on corp_etl_proc_letters(letter_type);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_TYPE_EXCLUDE_DAYS','LETTER_TYPE_EXCLUSION','7',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Exclude processing this letter type this day of the week. 1 for Sunday; 7 for Saturday.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_TYPES_TO_EXCLUDE','LETTER_TYPE_EXCLUSION','Checkup Due Letter,Checkup Reminder Letter,Enrollment Reminder',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Exclude processing these letter types specific day/s of the week. 1 for Sunday; 7 for Saturday.',SYSDATE,SYSDATE);
commit;  