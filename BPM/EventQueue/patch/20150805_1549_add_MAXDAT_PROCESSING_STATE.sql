create table MAXDAT_PROCESSING_STATE
  (BSL_ID number not null,
   ETL_CEJS_JOB_ID_STARTED number,
   ETL_CEJS_JOB_ID_COMPLETED number,
   QUEUE_CEJS_JOB_ID_STARTED number,
   QUEUE_CEJS_JOB_ID_COMPLETED number,
   QUEUE_CEJS_JOB_ID_GOAL number,
   CACHE_CEJS_JOB_ID_STARTED number,
   CACHE_CEJS_JOB_ID_COMPLETED number,
   CACHE_CEJS_JOB_ID_GOAL number,
   SYNC_ENABLED char(1) check (SYNC_ENABLED in('N','Y'))) 
tablespace MAXDAT_DATA;

alter table MAXDAT_PROCESSING_STATE add constraint MPS_PK primary key (BSL_ID);
alter index MPS_PK rebuild tablespace MAXDAT_INDX parallel;
