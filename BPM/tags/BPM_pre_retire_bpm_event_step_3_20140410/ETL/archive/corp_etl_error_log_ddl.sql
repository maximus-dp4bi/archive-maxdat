create table CORP_ETL_ERROR_LOG
(
  ceel_id      number not null,
  err_date     date default sysdate not null,
  err_level    varchar2(20) default 'CRITICAL' not null,
  process_name varchar2(120) not null,
  job_name     varchar2(120) not null,
  nr_of_error  number,
  error_desc   varchar2(4000),
  error_field  varchar2(400),
  error_codes  varchar2(400),
  create_ts    date not null,
  UPDATE_TS    date not null,
  DRIVER_TABLE_NAME VARCHAR2(100 BYTE), 
	DRIVER_KEY_NUMBER NUMBER
)
;

comment on column CORP_ETL_ERROR_LOG.ERR_DATE
  is 'Date of Error, Defaults to System date' ;
comment on column CORP_ETL_ERROR_LOG.err_level
  is 'Level or error - ABORT,CRITICAL,LOG Defaults to CRITICAL' ;
comment on column CORP_ETL_ERROR_LOG.PROCESS_NAME
  is 'Name of process, this should identify what workbook the error came from';  
comment on column CORP_ETL_ERROR_LOG.JOB_NAME
  is 'Name of Job or Transformation';  
comment on column CORP_ETL_ERROR_LOG.NR_OF_ERROR
  is 'Corresponds to the Kettle Error filed of the same name';
  comment on column CORP_ETL_ERROR_LOG.ERROR_DESC
  is 'Corresponds to the Kettle Error filed of the same name';
  comment on column CORP_ETL_ERROR_LOG.ERROR_CODES
  is 'Corresponds to the Kettle Error filed of the same name';
  comment on column CORP_ETL_ERROR_LOG.ERROR_FIELD
  is 'Corresponds to the Kettle Error filed of the same name';
  comment on column "CORP_ETL_ERROR_LOG"."DRIVER_TABLE_NAME" is 'Documents';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."DRIVER_KEY_NUMBER" IS 'DCN';
   
  
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_ERROR_LOG
  add constraint CORP_ETL_ERROR_LOG_PK primary key (CEEL_ID);
-- Create/Recreate check constraints 
alter table CORP_ETL_ERROR_LOG
  add constraint ERR_LEVEL_chk
  check (err_level in ('ABORT','CRITICAL', 'LOG'));
  
