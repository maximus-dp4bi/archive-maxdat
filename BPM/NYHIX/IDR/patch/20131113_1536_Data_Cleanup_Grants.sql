UPDATE CORP_ETL_CONTROL
  set value = 0
WHERE NAME = 'LAST_IDR_INCIDENT_ID';
commit;



TRUNCATE TABLE NYHX_ETL_IDR_INCIDENTS;
TRUNCATE TABLE NYHX_ETL_IDR_INCIDENTS_OLTP;
truncate table NYHX_ETL_IDR_INCIDENTS_wip;


DELETE BPM_UPDATE_EVENT_QUEUE WHERE BSL_ID = 21;
DELETE BPM_INSTANCE_ATTRIBUTE where bi_id in (select bi_id from BPM_INSTANCE where bsl_id = 21);


DELETE F_IDR_BY_DATE;

DELETE D_IDR_CURRENT ;
DELETE BPM_UPDATE_EVENT_QUEUE_ARCHIVE WHERE BSL_ID = 21;
DELETE BPM_UPDATE_EVENT where bi_id in (select bi_id from BPM_INSTANCE where bsl_id = 21);
DELETE BPM_INSTANCE WHERE BSL_ID = 21;

COMMIT;