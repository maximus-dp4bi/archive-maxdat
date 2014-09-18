/*
Created on 11-Sep-2013 by Raj A.
Process: NYHIX IDR Incidents Process.
*/

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LAST_IDR_INCIDENT_ID','N',0,'Used to fetch IDR Incidents from OLTP for IDR Incidents process',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('IDR_LOOK_BACK_DAYS','N',90,'Looks back specified number of days while searching for new IDR Incidents',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('IDRS_TO_LOOK_BACK','N','100','Number of IDR incidents to look back',sysdate,sysdate);


commit;