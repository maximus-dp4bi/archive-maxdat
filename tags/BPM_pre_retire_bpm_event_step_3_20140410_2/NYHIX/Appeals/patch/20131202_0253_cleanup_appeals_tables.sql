update corp_etl_control
set value = '90'
WHERE name='APP_LOOK_BACK_DAYS';

update corp_etl_control
set value = 0
where name = 'LAST_APPEAL_ID';

truncate table nyhbe_etl_process_appeals_rsn;
truncate table NYHBE_PROCESS_APPEALS_OLTP;
truncate table NYHBE_PROCESS_APPEALS_WIP_BPM;
delete from nyhbe_etl_process_appeals;

DELETE FROM BPM_UPDATE_EVENT_QUEUE WHERE BSL_ID = 23;
DELETE FROM BPM_INSTANCE_ATTRIBUTE where bi_id in (select bi_id from BPM_INSTANCE where bsl_id = 23);
DELETE FROM F_APPEALS_BY_DATE;
DELETE FROM D_APPEALS_CURRENT ;
DELETE FROM BPM_UPDATE_EVENT_QUEUE_ARCHIVE WHERE BSL_ID = 23;
DELETE FROM BPM_UPDATE_EVENT where bi_id in (select bi_id from BPM_INSTANCE where bsl_id = 23);
DELETE FROM BPM_INSTANCE WHERE BSL_ID = 23;

delete from d_appeals_action_comments
where action_comments is not null;

delete from d_appeals_incident_about
where incident_about is not null;

delete from d_appeals_incident_desc
where incident_description is not null;

delete from corp_etl_error_log
where process_name = 'APPEALS';

delete from bpm_logging
where bsl_id = 23;

COMMIT;