create table CORP_ETL_ERROR_LOG
  (CEEL_ID      number not null,
   ERR_DATE     date default sysdate not null,
   ERR_LEVEL    varchar2(20) default 'CRITICAL' not null,
   PROCESS_NAME varchar2(120) not null,
   JOB_NAME     varchar2(120) not null,
   NR_OF_ERROR  number,
   ERROR_DESC   varchar2(4000),
   ERROR_FIELD  varchar2(400),
   ERROR_CODES  varchar2(400),
   CREATE_TS    date not null,
   UPDATE_TS    date not null,
   DRIVER_TABLE_NAME varchar2(100), 
   DRIVER_KEY_NUMBER varchar2(100));

comment on column CORP_ETL_ERROR_LOG.ERR_DATE is 'Date of Error, Defaults to System date' ;
comment on column CORP_ETL_ERROR_LOG.ERR_LEVEL is 'Level or error - ABORT,CRITICAL,LOG Defaults to CRITICAL' ;
comment on column CORP_ETL_ERROR_LOG.PROCESS_NAME is 'Name of process, this should identify what workbook the error came from';  
comment on column CORP_ETL_ERROR_LOG.JOB_NAME is 'Name of Job or Transformation';  
comment on column CORP_ETL_ERROR_LOG.NR_OF_ERROR is 'Corresponds to the Kettle Error filed of the same name';
comment on column CORP_ETL_ERROR_LOG.ERROR_DESC is 'Corresponds to the Kettle Error filed of the same name';
comment on column CORP_ETL_ERROR_LOG.ERROR_CODES is 'Corresponds to the Kettle Error field of the same name';
comment on column CORP_ETL_ERROR_LOG.ERROR_FIELD is 'Corresponds to the Kettle Error field of the same name';
comment on column CORP_ETL_ERROR_LOG.DRIVER_TABLE_NAME is 'Corresponds to the source table that the record is from';
comment on column CORP_ETL_ERROR_LOG.DRIVER_KEY_NUMBER is 'Corresponds to the Record ID causing the error';
   
alter table CORP_ETL_ERROR_LOG add constraint CORP_ETL_ERROR_LOG_PK primary key (CEEL_ID)
using index tablespace MAXDAT_INDX;

alter table CORP_ETL_ERROR_LOG add constraint ERR_LEVEL_CHK check (ERR_LEVEL in ('ABORT','CRITICAL','LOG'));

create or replace public synonym CORP_ETL_ERROR_LOG for CORP_ETL_ERROR_LOG;
grant select on CORP_ETL_ERROR_LOG to MAXDAT_READ_ONLY;


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
grant select on CORP_ETL_JOB_STATISTICS to MAXDAT_READ_ONLY;