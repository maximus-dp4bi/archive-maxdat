insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_CRM_RUNDATE','D',TO_CHAR(sysdate,'mm/dd/yyyy'),'Next run date for the refresh data load',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_MFD_RUNDATE','D','07/01/2020','Next run date for the refresh data load',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_PI_RUNDATE','D','07/01/2020','Next run date for the refresh data load',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_MFB_RUNDATE','D','07/01/2020','Next run date for the refresh data load',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_DEMO_PL_RUNDATE','D','09/30/2020','Next run date for the refresh data load',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_CRM_DATA_CURDATE','D',TO_CHAR(sysdate,'mm/dd/yyyy'),'Use this date to update all dates for the CRM module',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_MFD_DATA_CURDATE','D','07/01/2020','Use this date to update all dates for the MFD module',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_PI_DATA_CURDATE','D','07/01/2020','Use this date to update all dates for the PI module',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_MFB_DATA_CURDATE','D','07/01/2020','Use this date to update all dates for the MFB module',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REFRESH_PL_DATA_CURDATE','D','09/30/2020','Use this date to update all dates for the PL module',sysdate,sysdate);

commit;