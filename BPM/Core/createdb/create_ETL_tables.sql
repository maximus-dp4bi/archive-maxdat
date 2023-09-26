-- Create ETL tables.

create table CORP_ETL_CLEAN_TABLE
  (CECT_ID number(5,0), 
   TABLE_NAME varchar2(100) not null, 
   COLUMN_NAME varchar2(100), 
   DELETE_WHERE_CLAUSE varchar2(4000), 
   DAYS_TILL_DELETE number, 
   START_DATE date not null, 
   END_DATE date not null, 
   CREATED_TS date not null, 
   LAST_UPDATE_TS date not null,
   ARC_FLAG	varchar2(1),
   ARC_TABLE	varchar2(100))
tablespace MAXDAT_DATA;

alter table CORP_ETL_CLEAN_TABLE add constraint CECT_PK primary key (CECT_ID)
using index tablespace MAXDAT_INDX;

grant select on CORP_ETL_CLEAN_TABLE to MAXDAT_READ_ONLY;


create table CORP_ETL_CLEAN_TABLE_HS 
  (CECT_HS_ID number(5,0), 
   CECT_ID number(5,0), 
   TABLE_NAME varchar2(100) not null, 
   COLUMN_NAME varchar2(100), 
   DELETE_WHERE_CLAUSE varchar2(4000), 
   DAYS_TILL_DELETE number, 
   START_DATE date not null, 
   END_DATE date not null, 
   CREATED_TS date not null, 
   LAST_UPDATE_TS date not null,
   ARC_FLAG varchar2(1), 
   ARC_TABLE varchar2(100), 
   HS_CREATED_TS date not null, 
   HS_LAST_UPDATE_TS date not null, 
   HS_ACTION varchar2(10))
tablespace MAXDAT_DATA ;
  
alter table CORP_ETL_CLEAN_TABLE_HS add constraint CECT_HS_PK primary key (CECT_HS_ID)
using index tablespace MAXDAT_INDX;

grant select on CORP_ETL_CLEAN_TABLE_HS to MAXDAT_READ_ONLY;


create table CORP_ETL_CONTROL
  (NAME        varchar2(50) not null,
   VALUE_TYPE  varchar2(1) not null,
   VALUE       varchar2(100) not null,
   DESCRIPTION varchar2(400),
   CREATED_TS  date not null,
   UPDATED_TS  date not null)
tablespace MAXDAT_DATA;
     
comment on column  CORP_ETL_CONTROL.NAME is 'Named Variable which will have a value stored';
comment on column  CORP_ETL_CONTROL.VALUE_TYPE is 'Type of the named variable';
comment on column  CORP_ETL_CONTROL.VALUE is 'Holds the value for the named variable identifier - secondary lookup value';
comment on column  CORP_ETL_CONTROL.DESCRIPTION is 'Description of named variable';
comment on column  CORP_ETL_CONTROL.CREATED_TS is 'Date variable created';
comment on column  CORP_ETL_CONTROL.UPDATED_TS is 'Date Variable updated';

alter table CORP_ETL_CONTROL add constraint CECTL_PK primary key (NAME)
using index tablespace MAXDAT_INDX;
      
grant select on CORP_ETL_CONTROL to MAXDAT_READ_ONLY;

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
   DRIVER_KEY_NUMBER varchar2(100))
tablespace MAXDAT_DATA;

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

grant select on CORP_ETL_ERROR_LOG to MAXDAT_READ_ONLY;


create table CORP_ETL_JOB_STATISTICS 
  (JOB_ID number not null, 
   PARENT_JOB_ID NUMBER,
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

grant select on CORP_ETL_JOB_STATISTICS to MAXDAT_READ_ONLY;


create table CORP_ETL_LIST_LKUP
  (CELL_ID    number not null,
   NAME       varchar2(30) not null,
   LIST_TYPE  varchar2(30) not null,
   VALUE      varchar2(100) not null,
   OUT_VAR    varchar2(500),
   REF_TYPE   varchar2(100),
   REF_ID     number(38),
   START_DATE date,
   END_DATE   date,
   COMMENTS   varchar2(4000),
   CREATED_TS date not null,
   UPDATED_TS date not null)
tablespace MAXDAT_DATA;

comment on table CORP_ETL_LIST_LKUP is 'Used to create list of values to used when pulling data for savvion';

comment on column CORP_ETL_LIST_LKUP.NAME is 'LIST(lookup rule name for list of values)/IFTHEN(IF VALUE THEN OUT_VAR)/ID(REFERENCE AND ID)';
comment on column CORP_ETL_LIST_LKUP.VALUE is 'Either a list or reference value - Secondary lookup value';
comment on column CORP_ETL_LIST_LKUP.OUT_VAR is 'Value to be extracted from table';
comment on column CORP_ETL_LIST_LKUP.REF_TYPE is 'Table name if ref id is prim key';
comment on column CORP_ETL_LIST_LKUP.REF_ID is 'Prim key when ref_type has table name';
comment on column CORP_ETL_LIST_LKUP.START_DATE is 'used to turn on value';
comment on column CORP_ETL_LIST_LKUP.END_DATE is 'Used to turn off value';

alter table CORP_ETL_LIST_LKUP add constraint CORP_ETL_LIST_LKUP_PK primary key (CELL_ID)
using index tablespace MAXDAT_INDX;

alter table CORP_ETL_LIST_LKUP add constraint CORP_ETL_LIST_LKUP_UK unique (NAME,LIST_TYPE,VALUE)
using index tablespace MAXDAT_INDX;

grant select on CORP_ETL_LIST_LKUP to MAXDAT_READ_ONLY; 


create table CORP_ETL_LIST_LKUP_HIST
  (CELL_HISTORY_ID number not null,
   HIST_TYPE       varchar2(100),
   CELL_ID         number not null,
   NAME            varchar2(30) not null,
   LIST_TYPE       varchar2(30) not null,
   VALUE           varchar2(100) not null,
   OUT_VAR         varchar2(500),
   REF_TYPE        varchar2(100),
   REF_ID          number(38),
   START_DATE      date,
   END_DATE        date,
   COMMENTS        varchar2(4000),
   CREATED_TS      date not null,
   UPDATED_TS      date not null,
   HIST_CREATED_TS date not null,
   HIST_USER       varchar2(4000),
   HIST_UPDATED_TS date not null)
tablespace MAXDAT_DATA;

alter table CORP_ETL_LIST_LKUP_HIST add constraint CORP_ETL_LIST_LKUP_HIST_PK primary key (CELL_HISTORY_ID)
using index tablespace MAXDAT_INDX;

grant select on CORP_ETL_LIST_LKUP_HIST to MAXDAT_READ_ONLY;


create table CORP_INSTANCE_CLEANUP_TABLE  
  (CICT_ID number(5,0) not null, 
   SYSTEM_NAME varchar2(32), 
   CLEANUP_NAME varchar2(100), 
   RUN varchar2(1), 
   START_DATE date, 
   START_TIME varchar2(10), 
   END_DATE date, 
   END_TIME varchar2(10), 
   STATEMENT varchar2(4000), 
   CREATED_TS date not null, 
   LAST_UPDATE_TS date not null)
tablespace MAXDAT_DATA ;

create unique index CORP_INSTANCE_CLEANUP_IX1 on CORP_INSTANCE_CLEANUP_TABLE (CICT_ID) 
tablespace MAXDAT_INDX ;

grant select on CORP_INSTANCE_CLEANUP_TABLE to MAXDAT_READ_ONLY;


create table HOLIDAYS
  (HOLIDAY_ID   number(18) not null,
   HOLIDAY_YEAR number(4),
   HOLIDAY_DATE date,
   DESCRIPTION  varchar2(128),
   CREATED_BY   varchar2(80),
   CREATE_TS    date,
   UPDATED_BY   varchar2(80),
   UPDATE_TS    date)
tablespace MAXDAT_DATA;

alter table HOLIDAYS add constraint HOLIDAYS_PK primary key (HOLIDAY_ID)
using index tablespace MAXDAT_INDX;

alter table HOLIDAYS add constraint HOLIDAYS_UK1 unique (HOLIDAY_DATE) 
using index tablespace MAXDAT_INDX;

alter index HOLIDAYS_UK1 invisible;

grant select on HOLIDAYS to MAXDAT_READ_ONLY; 