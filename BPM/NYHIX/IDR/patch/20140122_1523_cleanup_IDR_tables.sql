UPDATE CORP_ETL_CONTROL
  set value = 0
WHERE NAME = 'LAST_IDR_INCIDENT_ID';
commit;

update corp_etl_control
set value = '180'
WHERE name='IDR_LOOK_BACK_DAYS';


TRUNCATE TABLE nyhx_etl_idr_incident_rsn;
TRUNCATE TABLE NYHX_ETL_IDR_INCIDENTS_OLTP;
truncate table NYHX_ETL_IDR_INCIDENTS_wip;
DELETE FROM NYHX_ETL_IDR_INCIDENTS;


DELETE FROM BPM_UPDATE_EVENT_QUEUE WHERE BSL_ID = 21;
DELETE FROM BPM_INSTANCE_ATTRIBUTE where bi_id in (select bi_id from BPM_INSTANCE where bsl_id = 21);
DELETE FROM F_IDR_BY_DATE;
DELETE FROM D_IDR_CURRENT ;
DELETE FROM BPM_UPDATE_EVENT_QUEUE_ARCHIVE WHERE BSL_ID = 21;
DELETE FROM BPM_UPDATE_EVENT where bi_id in (select bi_id from BPM_INSTANCE where bsl_id = 21);
DELETE FROM BPM_INSTANCE WHERE BSL_ID = 21;

delete from d_idr_action_comments
where action_comments is not null;

delete from d_idr_incident_about
where incident_about is not null;

delete from d_idr_incident_description
where incident_description is not null;


COMMIT;