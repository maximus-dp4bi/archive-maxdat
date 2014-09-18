
delete from BPM_INSTANCE_ATTRIBUTE
where bi_id in (7879,7880,7881);

delete from BPM_UPDATE_EVENT
where BI_ID in (7879,7880,7881);

delete from BPM_INSTANCE
where identifier in ('3937','3972','33732');

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

update corp_etl_control
set value=0
where name='LAST_INCIDENT_ID';

update corp_etl_control
set value='2013/02/17 16:00:00'
where name='INC_LAST_CDC_START_TIME';

commit;