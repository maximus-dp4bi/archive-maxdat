insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_DATA_NUMDAYS','N','7','Number of days to add to the various dates',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_DATA_RUNDATE','D',TO_CHAR(sysdate,'mm/dd/yyyy'),'Next run date for the refresh data load',sysdate,sysdate);

commit;