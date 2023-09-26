ALTER TABLE app_individual_stg
ADD (CLIENT_FNAME VARCHAR2(40)
     ,CLIENT_LNAME VARCHAR2(40)
     ,CLIENT_MI VARCHAR2(25)
     ,CLIENT_LAST_UPDATE_DATE DATE);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPINDVCLIENT_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the client.last_update_date from the previous run. update_ts of the most recent client record from the previous run.',sysdate,sysdate);

commit;

