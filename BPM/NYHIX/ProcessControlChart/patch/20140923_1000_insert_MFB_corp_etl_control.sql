insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MFB_CURRENT_REPORTING_PERIOD','D','2014/11/08','Current reporting period for Mail Fax Batch metrics calculation',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MFB_WEEK_LOOKBACK_REPORTING_PERIOD','N','60','Number of weeks to look back to for Manage Work metrics calculation if calculation is weekly in case past weeks need to be recalculated',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MFB_MONTH_LOOKBACK_REPORTING_PERIOD','N','0','Number of month to look back to for Manage Work metrics calculation if calculation is monthly in case past months need to be recalculated',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MFB_REPORTING_PERIOD_TYPE','V','''WEEKLY''','Reporting period type for Manage Work',sysdate,sysdate);

COMMIT;