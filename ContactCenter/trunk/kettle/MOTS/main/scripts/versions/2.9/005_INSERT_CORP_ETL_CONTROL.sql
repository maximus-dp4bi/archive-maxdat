insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MIN_NUM_OBSERVATIONS','N','8','Minimum number of observations for calculating control chart parameters',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_NUM_OBSERVATIONS','N','20','Maximum number of observations for calculating control chart parameters',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('NUM_ALLOWABLE_GAPS','N','0','Number of allowable gaps in time periods reported',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('NUM_STANDARD_ERRORS','N','3','Number of standard errors',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('RECALC_NUM_OBSERVATIONS_1','N','12','Number of observations used for control chart parameters recalculation at 1/3',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('RECALC_NUM_OBSERVATIONS_2','N','16','Number of observations used for control chart parameters recalculation at 2/3',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TREND_INDICATOR_CALCULATION_1','V','CONTROL CHART','Trend indicator calculation method',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TREND_INDICATOR_CALCULATION_2','V','DELTA','Trend indicator calculation method',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TREND_INDICATOR_CALCULATION_3','V','NO TREND','Trend indicator calculation method',sysdate,sysdate);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.9','005','005_INSERT_CORP_ETL_CONTROL');

COMMIT;