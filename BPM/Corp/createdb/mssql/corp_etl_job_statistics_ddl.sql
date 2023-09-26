create sequence MAXDAT.SEQ_JOB_ID
  minvalue 1
  start with 1
  increment by 1
  cache 20;
  
create table MAXDAT.CORP_ETL_JOB_STATISTICS
  (JOB_ID int not null, 
   PARENT_JOB_ID int,
   JOB_NAME varchar(80) not null, 
   JOB_STATUS_CD varchar(20) not null, 
   FILE_NAME varchar(512), 
   RECORD_COUNT int, 
   PROCESSED_COUNT int, 
   ERROR_COUNT int, 
   WARNING_COUNT int, 
   RECORD_INSERTED_COUNT int, 
   RECORD_UPDATED_COUNT int, 
   JOB_START_DATE datetime, 
   JOB_END_DATE datetime, 
   constraint CORP_ETL_JOB_STATISTICS_PK primary key (JOB_ID));
go

grant select on MAXDAT.CORP_ETL_JOB_STATISTICS to MAXDAT_READ_ONLY;
go

  