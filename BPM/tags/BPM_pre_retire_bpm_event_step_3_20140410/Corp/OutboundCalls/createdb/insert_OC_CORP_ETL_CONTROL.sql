

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_LAST_ATTEMPT_ID','N','0','Used to fetch Dialer Attempt Id from OLTP for Outbound Call Detail Child process',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_LAST_JOB_ID','N','0','Value of the last successful Outbound Call job ID',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_LAST_ROW_ID','N','0','Value of the last successful Outbound Call job''s  ending row ID.',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_NUM_OF_DAYS','N','30','Outbound Call number of days to identify unique ETL instances. Initially 30 days.',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_DAILY_START','N','0900','Workbook to run once daily. Represents the hour value on 24-hour format.',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_DAILY_END','N','1059','Workbook to run once daily. Represents the hour value on 24-hour format.',SYSDATE,SYSDATE);

commit;