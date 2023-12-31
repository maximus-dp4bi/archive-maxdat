insert into CORP_ETL_MFB_BATCH (CEMFBB_ID,BATCH_GUID,BATCH_ID,BATCH_NAME,CREATION_STATION_ID,CREATION_USER_NAME,CREATION_USER_ID,BATCH_CLASS,CREATE_DT,COMPLETE_DT,INSTANCE_STATUS,INSTANCE_STATUS_DT,BATCH_PAGE_COUNT,BATCH_DOC_COUNT,BATCH_ENVELOPE_COUNT,ASF_SCAN_BATCH,CLASSIFICATION_DT,RECOGNITION_DT,VALIDATION_DT,ASF_POPULATE_REPORTS,ASSD_POPULATE_REPORTS,ASED_POPULATE_REPORTS,ASF_RELEASE_DMS,ASSD_RELEASE_DMS,ASED_RELEASE_DMS,BATCH_PRIORITY,STG_DONE_DATE,STG_EXTRACT_DATE,STG_LAST_UPDATE_DATE,STG_PROCESSED_DATE,BATCH_COMPLETE_DT,CURRENT_STEP)
select CEMFBB_ID,BATCH_GUID,BATCH_ID,BATCH_NAME,CREATION_STATION_ID,CREATION_USER_NAME,CREATION_USER_ID,BATCH_CLASS,CREATE_DT,COMPLETE_DT,INSTANCE_STATUS,INSTANCE_STATUS_DT,BATCH_PAGE_COUNT,BATCH_DOC_COUNT,BATCH_ENVELOPE_COUNT,ASF_SCAN_BATCH,CLASSIFICATION_DT,RECOGNITION_DT,VALIDATION_DT,ASF_POPULATE_REPORTS,ASSD_POPULATE_REPORTS,ASED_POPULATE_REPORTS,ASF_RELEASE_DMS,ASSD_RELEASE_DMS,ASED_RELEASE_DMS,BATCH_PRIORITY,STG_DONE_DATE,STG_EXTRACT_DATE,STG_LAST_UPDATE_DATE,STG_PROCESSED_DATE,BATCH_COMPLETE_DT,CURRENT_STEP
from CORP_ETL_MFB_BATCH_STG
where STG_INSERT_JOB_ID = 5;

commit;

