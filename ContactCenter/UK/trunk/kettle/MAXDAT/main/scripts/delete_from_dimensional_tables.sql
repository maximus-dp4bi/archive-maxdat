use uk_hws
go

DELETE MAXDAT.CC_F_ACTUALS_IVR_INTERVAL ;
DELETE MAXDAT.CC_F_ACTUALS_QUEUE_INTERVAL ;
DELETE MAXDAT.CC_F_AGENT_ACTIVITY_BY_DATE ;
DELETE MAXDAT.CC_F_AGENT_BY_DATE ;
DELETE MAXDAT.CC_F_FORECAST_INTERVAL ;
DELETE MAXDAT.CC_F_IVR_SELF_SERVICE_USAGE ;

DELETE MAXDAT.CC_D_PRODUCTION_PLAN_HORIZON ;
DELETE MAXDAT.CC_D_PRODUCTION_PLAN;
DELETE MAXDAT.CC_D_ACTIVITY_TYPE ;
DELETE MAXDAT.CC_D_AGENT ;
DELETE MAXDAT.CC_D_CONTACT_QUEUE ;
DELETE MAXDAT.CC_D_GEOGRAPHY_MASTER ;
DELETE MAXDAT.CC_D_COUNTRY ;
DELETE MAXDAT.CC_D_DATES ;
DELETE MAXDAT.CC_D_DISTRICT ;
DELETE MAXDAT.CC_D_FORECAST_NOTES ;
DELETE MAXDAT.CC_D_GROUP ;
DELETE MAXDAT.CC_D_INTERVAL ;
DELETE MAXDAT.CC_D_IVR_SELF_SERVICE_PATH ;
DELETE MAXDAT.CC_D_PROD_PLANNING_TARGET ;
DELETE MAXDAT.CC_D_PROGRAM ;
DELETE MAXDAT.CC_D_PROJECT_TARGETS ;
DELETE MAXDAT.CC_D_PROJECT ;
DELETE MAXDAT.CC_D_PROVINCE ;
DELETE MAXDAT.CC_D_REGION ;
DELETE MAXDAT.CC_D_SITE ;
DELETE MAXDAT.CC_D_STATE ;
DELETE MAXDAT.CC_D_TARGET ;
DELETE MAXDAT.CC_D_UNIT_OF_WORK ;

DELETE FROM MAXDAT.CC_F_ACTUALS_IVR_INTERVAL; 
DELETE FROM MAXDAT.CC_F_ACTUALS_QUEUE_INTERVAL; 
DELETE FROM MAXDAT.CC_F_AGENT_ACTIVITY_BY_DATE;
DELETE FROM MAXDAT.CC_F_AGENT_BY_DATE; 
DELETE FROM MAXDAT.CC_F_FORECAST_INTERVAL; 
DELETE FROM MAXDAT.CC_F_IVR_SELF_SERVICE_USAGE; 
DELETE FROM MAXDAT.CC_D_ACTIVITY_TYPE; 
DELETE FROM MAXDAT.CC_D_AGENT; 
DELETE FROM MAXDAT.CC_D_CONTACT_QUEUE; 
DELETE FROM MAXDAT.CC_D_PRODUCTION_PLAN_HORIZON; 
DELETE FROM MAXDAT.CC_D_PRODUCTION_PLAN; 
DELETE FROM MAXDAT.CC_D_GEOGRAPHY_MASTER; 
DELETE FROM MAXDAT.CC_D_COUNTRY; 
DELETE FROM MAXDAT.CC_D_DATES; 
DELETE FROM MAXDAT.CC_D_DISTRICT; 
DELETE FROM MAXDAT.CC_D_FORECAST_NOTES; 
DELETE FROM MAXDAT.CC_D_GROUP; 
DELETE FROM MAXDAT.CC_D_INTERVAL; 
DELETE FROM MAXDAT.CC_D_IVR_SELF_SERVICE_PATH; 
DELETE FROM MAXDAT.CC_D_PROD_PLANNING_TARGET; 
DELETE FROM MAXDAT.CC_D_PROGRAM; 
DELETE FROM MAXDAT.CC_D_PROJECT_TARGETS; 
DELETE FROM MAXDAT.CC_D_PROJECT; 
DELETE FROM MAXDAT.CC_D_PROVINCE; 
DELETE FROM MAXDAT.CC_D_REGION; 
DELETE FROM MAXDAT.CC_D_SITE; 
DELETE FROM MAXDAT.CC_D_STATE; 
DELETE FROM MAXDAT.CC_D_TARGET; 
DELETE FROM MAXDAT.CC_D_UNIT_OF_WORK;

DELETE FROM MAXDAT.CC_L_ERROR;
DELETE FROM MAXDAT.CC_L_TRANSFORMATION;
DELETE FROM MAXDAT.CC_L_PATCH_LOG;
DELETE FROM MAXDAT.CC_S_TMP_ACTUALEVENTTIMELINE;
DELETE FROM MAXDAT.CC_S_TMP_CISCO_AGENT_INTERVAL;
DELETE FROM MAXDAT.CC_S_TMP_CISCO_AGENT_LOGOUT;
DELETE FROM MAXDAT.CC_S_TMP_CISCO_A_SG_INTERVAL;
DELETE FROM MAXDAT.CC_S_TMP_CISCO_C_T_INTERVAL;
DELETE FROM MAXDAT.CC_S_AGENT_ABSENCE;
DELETE FROM MAXDAT.CC_S_AGENT_SUPERVISOR;
DELETE FROM MAXDAT.CC_S_AGENT_WORK_DAY;
DELETE FROM MAXDAT.CC_S_ACD_AGENT_ACTIVITY;
DELETE FROM MAXDAT.CC_S_ACD_INTERVAL;
DELETE FROM MAXDAT.CC_S_WFM_INTERVAL;
DELETE FROM MAXDAT.CC_S_CONTACT_QUEUE;
DELETE FROM MAXDAT.CC_S_ACD_INTERVAL_PERIOD;
DELETE FROM MAXDAT.CC_S_CALL_DETAIL;
DELETE FROM MAXDAT.CC_S_FCST_INTERVAL;
DELETE FROM MAXDAT.CC_S_IVR_INTERVAL;
DELETE FROM MAXDAT.CC_S_IVR_SELF_SERVICE_USAGE;
DELETE FROM MAXDAT.CC_S_IVR_SELF_SERVICE_PATH;
DELETE FROM MAXDAT.CC_S_INTERVAL;
DELETE FROM MAXDAT.CC_S_PRODUCTION_PLAN_HORIZON;
DELETE FROM MAXDAT.CC_S_TIMEZONEAM;
DELETE FROM MAXDAT.CC_S_TMP_INTERVAL;
DELETE FROM MAXDAT.CC_S_WFM_AGENT_ACTIVITY;
DELETE FROM MAXDAT.CC_S_AGENT;
DELETE FROM MAXDAT.CC_S_PRODUCTION_PLAN;
DELETE FROM MAXDAT.CC_C_ACTIVITY_TYPE;
DELETE FROM MAXDAT.CC_C_PROJECT_CONFIG;
DELETE FROM MAXDAT.CC_C_CONTACT_QUEUE;
DELETE FROM MAXDAT.CC_C_FILTER;
DELETE FROM MAXDAT.CC_C_LOOKUP;
DELETE FROM MAXDAT.CC_C_UNIT_OF_WORK;


delete FROM MAXDAT.cc_a_adhoc_job;

DELETE FROM MAXDAT.CC_F_ACTUALS_IVR_INTERVAL;-- where d_date_id=129427;  
DELETE FROM MAXDAT.CC_F_ACTUALS_QUEUE_INTERVAL;-- where d_date_id=129427; 
DELETE FROM MAXDAT.CC_F_AGENT_ACTIVITY_BY_DATE;-- where d_date_id=129427;
DELETE FROM MAXDAT.CC_F_AGENT_BY_DATE;-- where d_date_id=129427; 
DELETE FROM MAXDAT.CC_F_FORECAST_INTERVAL;-- where d_date_id=129427; 
DELETE FROM MAXDAT.CC_F_IVR_SELF_SERVICE_USAGE;-- where d_date_id=129427; 

DELETE FROM MAXDAT.CC_D_AGENT; 
DELETE FROM MAXDAT.CC_D_CONTACT_QUEUE; 
DELETE FROM MAXDAT.CC_D_PRODUCTION_PLAN_HORIZON; 
DELETE FROM MAXDAT.CC_D_PRODUCTION_PLAN; 
DELETE FROM MAXDAT.CC_D_GROUP; 
DELETE FROM MAXDAT.CC_D_SITE; 
DELETE FROM MAXDAT.CC_L_ERROR;
DELETE FROM MAXDAT.CC_L_TRANSFORMATION;

DELETE FROM MAXDAT.CC_S_AGENT_ABSENCE;
DELETE FROM MAXDAT.CC_S_AGENT_SUPERVISOR;
DELETE FROM MAXDAT.CC_S_AGENT_WORK_DAY;
DELETE FROM MAXDAT.CC_S_ACD_AGENT_ACTIVITY;
DELETE FROM MAXDAT.CC_S_ACD_INTERVAL;
DELETE FROM MAXDAT.CC_S_WFM_INTERVAL;
DELETE FROM MAXDAT.CC_S_CONTACT_QUEUE;
DELETE FROM MAXDAT.CC_S_ACD_INTERVAL_PERIOD;
DELETE FROM MAXDAT.CC_S_CALL_DETAIL;
DELETE FROM MAXDAT.CC_S_FCST_INTERVAL;
DELETE FROM MAXDAT.CC_S_IVR_INTERVAL;
DELETE FROM MAXDAT.CC_S_IVR_SELF_SERVICE_USAGE;
DELETE FROM MAXDAT.CC_S_IVR_SELF_SERVICE_PATH;
DELETE FROM MAXDAT.CC_S_INTERVAL;
DELETE FROM MAXDAT.CC_S_PRODUCTION_PLAN_HORIZON;
DELETE FROM MAXDAT.CC_S_TIMEZONEAM;
DELETE FROM MAXDAT.CC_S_TMP_INTERVAL;
DELETE FROM MAXDAT.CC_S_WFM_AGENT_ACTIVITY;
DELETE FROM MAXDAT.CC_S_AGENT;
DELETE FROM MAXDAT.CC_S_PRODUCTION_PLAN;
delete FROM MAXDAT.cc_s_agent_supervisor;

delete  FROM MAXDAT.cc_a_adhoc_job;
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-09-30 00:00:00','2013-10-01 00:00:00',1);

insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-01 00:00:00','2013-10-02 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-02 00:00:00','2013-10-03 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-03 00:00:00','2013-10-04 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-04 00:00:00','2013-10-05 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-05 00:00:00','2013-10-06 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-06 00:00:00','2013-10-07 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-07 00:00:00','2013-10-08 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-08 00:00:00','2013-10-09 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-09 00:00:00','2013-10-10 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-10 00:00:00','2013-10-11 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2013-10-11 00:00:00','2013-10-12 00:00:00',1);


go

/*


insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-01 00:00:00','2014-11-02 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-02 00:00:00','2014-11-03 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-03 00:00:00','2014-11-04 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-04 00:00:00','2014-11-05 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-05 00:00:00','2014-11-06 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-06 00:00:00','2014-11-07 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-07 00:00:00','2014-11-08 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-08 00:00:00','2014-11-09 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-09 00:00:00','2014-11-10 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-10 00:00:00','2014-11-11 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-11 00:00:00','2014-11-12 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-12 00:00:00','2014-11-13 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-13 00:00:00','2014-11-14 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-14 00:00:00','2014-11-15 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-15 00:00:00','2014-11-16 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-16 00:00:00','2014-11-17 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-17 00:00:00','2014-11-18 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-18 00:00:00','2014-11-19 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-19 00:00:00','2014-11-20 00:00:00',1);
insert into MAXDAT.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)values('load_contact_center','2014-11-20 00:00:00','2014-11-21 00:00:00',1);

go

set rowcount 10
select count(*), interval_date from maxdat.cc_s_acd_interval
group by interval_date
order by interval_date


set rowcount 0


select d_date,count(*)
FROM MAXDAT.CC_F_ACTUALS_QUEUE_INTERVAL f inner join MAXDAT.cc_d_dates d
on f.d_date_id=d.d_date_id
group by d_date
order by d_date

select d_date,count(*)
FROM MAXDAT.cc_f_agent_by_date f inner join MAXDAT.cc_d_dates d
on f.d_date_id=d.d_date_id
group by d_date
order by d_date
*/


/*
INSERT INTO [MAXDAT].[CC_S_AGENT]
([LOGIN_ID] ,[PROJECT_CONFIG_ID] ,[FIRST_NAME] ,[LAST_NAME] ,[MIDDLE_INITIAL] ,[JOB_TITLE] ,[LANGUAGE]
,[SITE_NAME] ,[SITE_DESCRIPTION] ,[HOURLY_RATE] ,[RATE_CURRENCY] ,[AGENT_GROUP] ,[EXTRACT_DT] ,[HIRE_DATE]
,[TERMINATION_DATE] ,[LAST_UPDATE_DT] ,[LAST_UPDATE_BY] ,[RECORD_EFF_DT] ,[RECORD_END_DT])
SELECT peripheralnumber, LoginName,(select project_config_id from MAXDAT.CC_C_PROJECT_CONFIG where program_name='EB')
,'[FirstName]','[LastName]','[MiddleName]','Unknown' [JobTitle],'Default' [Language],
'Default' SITE_NAME,'Default' SITE_DESCRIPTION, 0 HOURLY_RATE,
'EUR' RATE_CURRENCY, 'ACD' AGENT_GROUP, getdate() EXTRACT_DT,
'01/01/1900' HIRE_DATE, null TERMINATION_DATE, 
getdate() LAST_UPDATE_DT, 'MAXDAT' LAST_UPDATE_BY,
'01/01/1900 ' RECORD_EFF_DT,'12/31/2999' RECORD_END_DT
select * FROM [UK_HWS].[dbo].[Person]
GO

*/
