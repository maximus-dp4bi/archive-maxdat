Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LAST_TRANSACTION_ID','N','0','Used to fetch transaction or activity log  history records from OLTP for Process Online Info',sysdate,sysdate);

commit;