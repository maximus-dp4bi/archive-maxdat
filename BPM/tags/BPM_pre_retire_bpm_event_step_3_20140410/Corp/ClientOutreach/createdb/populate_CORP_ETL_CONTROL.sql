
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_LAST_OUTREACH_EVENT_ID','N',0,'Used to fetch Events from OLTP for Client Outreach Event Child Process',SYSDATE,SYSDATE);


Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_LAST_OUTREACH_ID','N',0,'Used to fetch Incidents from OLTP for Client Outreach Process',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CLIENT_OUTREACH_SLA_DAYS_TYPE','V','B','Indicates if the SLA Days is based on Business Days (B) or Calendar Days.(C). ',sysdate,sysdate);


Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_RUN_START_TIME','V','00:00:01','Start Time for Client Outreach process to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_RUN_END_TIME','V','23:59:59','End Time for Client Outreach process to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CO_MAX_OUTREACH_ID','N',28541501,'Used to fetch a range of data from OLTP for Client Outreach Adhoc process',SYSDATE,SYSDATE);


commit;