insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CALLREC_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the call_record.create_ts from the previous run. create_ts of the most recent call record record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CALLREC_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the call_record.update_ts from the previous run. update_ts of the most recent call record record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DIALER_RESPONSE_JOB_ID','N',1,'This is the max job_id loaded in ETL_L_DIALER_RESPONSE_STG',sysdate,sysdate);


commit;