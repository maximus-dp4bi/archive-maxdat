Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('ACTIVITY_RANGE_DAYS','N','60','Used to check Activity date range for Community Activity CHLD',sysdate,sysdate);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('ACTIVITY_UPDATE_DAY','N',4,'CMOR CHLD 1-S, 2-M, 3-T, 4-W, 5-TH, 6-F, 7-SA',sysdate,sysdate);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('ACTIVITY_DAY_OF_MON','N',1,'used to enter day of month for CMOR',sysdate,sysdate);


Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CMOR_RUN_START_TIME','V','20:00:00','Start Time for Community Outreach process to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CMOR_RUN_END_TIME','V','22:30:00','End Time for Community Outreach process to run',SYSDATE,SYSDATE);


commit;