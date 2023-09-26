insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_STG_LOOK_BACK_DAYS','N','2','Number of days to look back when inserting/updating letters so records will not be missed',sysdate,sysdate);

commit;
