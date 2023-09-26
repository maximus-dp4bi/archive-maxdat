insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_ACTIVITY_TIMEOUT','V','Y','Alert Monitoring Activity Timeout',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_TIMEOUT_THRESHOLD','N','48','Alert Monitoring - max how many hours to wait before timeout',sysdate,sysdate);

commit;


