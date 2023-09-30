insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LAST_JOB_ID','N',0,'Used to fetch job history records from OLTP for Manage Job Processing',sysdate,sysdate);

commit;