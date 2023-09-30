
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_LAST_OUTREACH_EVENT_ID','N',0,'Used to fetch Events from OLTP for Client Outreach Event Child Process',SYSDATE,SYSDATE);


Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_LAST_OUTREACH_ID','N',0,'Used to fetch Incidents from OLTP for Client Outreach Process',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CLIENT_OUTREACH_SLA_DAYS_TYPE','V','B','Indicates if the SLA Days is based on Business Days (B) or Calendar Days.(C). ',sysdate,sysdate);


Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('RUN_DAILY_CLIENT_OUTREACH_START','V','000001','Start Time for Client Outreach process to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('RUN_DAILY_CLIENT_OUTREACH_END','V','235959','End Time for Client Outreach process to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_MAX_OUTREACH_ID','N',28541501,'Used to fetch a range of data from OLTP for Client Outreach Adhoc process',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTREACH_EVENT_HISTORY_ID','N','27698694','Used to get the new outreach events from source',SYSDATE,SYSDATE);



commit;