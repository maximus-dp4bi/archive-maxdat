-- 7/31/2013 Job statistic objects for ILEB
create table CORP_ETL_JOB_STATISTICS 
  (JOB_ID number not null, 
   JOB_NAME varchar2(80) not null, 
   JOB_STATUS_CD varchar2(20) not null, 
   FILE_NAME varchar2(512), 
   RECORD_COUNT number, 
   PROCESSED_COUNT number, 
   ERROR_COUNT number,
   WARNING_COUNT number, 
   RECORD_INSERTED_COUNT number, 
   RECORD_UPDATED_COUNT number, 
   JOB_START_DATE date, 
   JOB_END_DATE date)
tablespace MAXDAT_DATA;

alter table CORP_ETL_JOB_STATISTICS add constraint CORP_ETL_JOB_STATISTICS_PK primary key (JOB_ID)
using index tablespace MAXDAT_INDX;

create or replace public synonym CORP_ETL_JOB_STATISTICS for CORP_ETL_JOB_STATISTICS;

create sequence SEQ_JOB_ID;
create or replace public synonym SEQ_JOB_ID for SEQ_JOB_ID;