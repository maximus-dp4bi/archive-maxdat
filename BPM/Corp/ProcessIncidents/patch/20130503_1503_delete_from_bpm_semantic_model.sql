delete from BPM_INSTANCE_ATTRIBUTE
where BI_ID in (select BI_ID from BPM_INSTANCE
where BSL_ID=10);

delete from BPM_UPDATE_EVENT
where BI_ID in (select bi_id from BPM_INSTANCE
where BSL_ID=10);

delete from BPM_INSTANCE
where BSL_ID=10;

delete from F_PI_BY_DATE;

delete from D_PI_CURRENT;

delete from D_PI_ENROLLMENT_STATUS;

delete from D_PI_INCIDENT_ABOUT;

delete from D_PI_INSTANCE_STATUS;

delete from D_PI_JEOPARDY_STATUS;

delete from D_PI_LAST_UPDATE_BY;

delete from D_PI_INCIDENT_REASON;

delete from D_PI_TASK_ID;

delete from D_PI_INCIDENT_DESC;

delete from D_PI_INCIDENT_STATUS;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
where bsl_id=10;

delete from CORP_ETL_PROCESS_INCIDENTS;

delete from CORP_ETL_ERROR_LOG
where process_name='PROCESS INCIDENTS';

update corp_etl_control
set value=0
where name='LAST_INCIDENT_ID';

delete from CORP_ETL_CONTROL
where name= 'INC_LAST_CDC_START_TIME';

update CORP_ETL_CONTROL
set value=30
where name='INC_LOOK_BACK_DAYS';



commit;