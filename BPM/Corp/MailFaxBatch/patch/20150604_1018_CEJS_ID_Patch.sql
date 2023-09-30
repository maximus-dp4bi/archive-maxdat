--add to CORP_ETL_MFB_BATCH
alter table CORP_ETL_MFB_BATCH add CEJS_JOB_ID number null;
comment on column CORP_ETL_MFB_BATCH.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';


--add to BPM_UPDATE_EVENT_QUEUE
alter table BPM_UPDATE_EVENT_QUEUE add CEJS_JOB_ID number null;
comment on column BPM_UPDATE_EVENT_QUEUE.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';


--add to BPM_UPDATE_EVENT_QUEUE_ARCHIVE
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add CEJS_JOB_ID number null;
comment on column BPM_UPDATE_EVENT_QUEUE_ARCHIVE.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';



