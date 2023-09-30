insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LOOK_BACK_INCIDENT_STATUS_HIST','N','1','Number of days to look back',sysdate,sysdate);

commit;

