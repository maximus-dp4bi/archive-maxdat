insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LAST_INCIDENT_ID','N',0,'Used to fetch Incidents from OLTP for Process Incidents process',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('INC_LOOK_BACK_DAYS','N',30,'Looks back specified number of days while searching for new Incidents',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('INC_LAST_CDC_START_TIME','D','2013/02/17 16:00:00','Start time of the last change data capture',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('INCIDNTS_TO_LOOK_BACK','N','100','Number of incidents to look back',sysdate,sysdate);


commit;