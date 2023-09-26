insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MIN_NUM_OBSERVATIONS','N','8','Minimum number of observations for calculating MW control chart parameters',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_NUM_OBSERVATIONS','N','20','Maximum number of observations for calculating MW control chart parameters',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('NUM_ALLOWABLE_GAPS','N','0','Number of allowable gaps in time periods reported for MW metrics',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('NUM_STANDARD_ERRORS','N','3','Number of standard errors for MW control chart calculation',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('RECALC_NUM_OBSERVATIONS_1','N','12','MW Number of observations used for control chart parameters recalculation at 1/3',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('RECALC_NUM_OBSERVATIONS_2','N','16','MW Number of observations used for control chart parameters recalculation at 2/3',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TREND_INDICATOR_CALCULATION_1','V','CONTROL CHART','Trend indicator calculation method for MW',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TREND_INDICATOR_CALCULATION_2','V','DELTA','Trend indicator calculation method for MW',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TREND_INDICATOR_CALCULATION_3','V','NO TREND','Trend indicator calculation method for MW',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MW_CURRENT_REPORTING_PERIOD','D','2014/09/13','Current reporting period for Manage Work metrics calculation',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MW_WEEK_LOOKBACK_REPORTING_PERIOD','N','52','Number of weeks to look back to for Manage Work metrics calculation if calculation is weekly in case past weeks need to be recalculated',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MW_MONTH_LOOKBACK_REPORTING_PERIOD','N','0','Number of month to look back to for Manage Work metrics calculation if calculation is monthly in case past months need to be recalculated',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MW_REPORTING_PERIOD_TYPE','V','''WEEKLY''','Reporting period type for Manage Work',sysdate,sysdate);

COMMIT;