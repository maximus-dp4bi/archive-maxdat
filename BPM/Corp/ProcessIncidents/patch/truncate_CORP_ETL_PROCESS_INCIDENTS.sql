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

-- delete from D_PI_INCIDENT_DESC;

delete from D_PI_INCIDENT_STATUS;

delete from BPM_UPDATE_EVENT_QUEUE
where bsl_id=10;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
where bsl_id=10;

delete from corp_etl_process_incidents;

--update corp_etl_control set value = '0' where name = 'LAST_INCIDENT_ID';

--update corp_etl_control set value = '2000' where name = 'INC_LOOK_BACK_DAYS';

--delete from corp_etl_job_statistics where job_name = 'Process_Incidents_RUN_ALL'
--and job_id <= 9238;

commit;