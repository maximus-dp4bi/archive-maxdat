create table CORP_ETL_MANAGE_JOBS
  (CEMFR_ID number not null,
   JOB_ID number,
   CREATE_DT date,
   CREATED_BY varchar2(102),
   JOB_NAME varchar2(500),
   JOB_DETAIL varchar2(500),
   JOB_GROUP varchar2(80),
   JOB_TYPE varchar2(32),
   JOB_START_DT date,
   JOB_END_DT date,
   JOB_STATUS varchar2(100),
   FILE_NAME varchar2(50),
   RECEIPT_DT date,
   TRANSMIT_DT date,
   FILE_TYPE varchar2(50),
   FILE_SOURCE varchar2(50),
   FILE_DESTINATION varchar2(50),
   PLAN_NAME varchar2(64),
   RESPONSE_FILE_REQ varchar2(50),
   RECORD_COUNT number,
   RECORD_ERROR_COUNT number,
   RESPONSE_FILE_NAME varchar2(50),
   LAST_UPDATE_BY_NAME varchar2(102),
   LAST_UPDATE_BY_DT date,
   ASSD_IDENTIFY_JOB date,
   ASED_IDENTIFY_JOB date,
   ASSD_PROCESS_JOB date,
   ASED_PROCESS_JOB date,
   ASSD_CREATE_RESPONSE_FILE date,
   ASED_CREATE_RESPONSE_FILE date,
   ASSD_CREATE_OUTBOUND_FILE date,
   ASED_CREATE_OUTBOUND_FILE date,
   ASF_IDENTIFY_JOB varchar2(1) default 'N' not null,
   ASF_PROCESS_JOB varchar2(1) default 'N' not null,
   ASF_CREATE_RESPONSE_FILE varchar2(1) default 'N' not null,
   ASF_CREATE_OUTBOUND_FILE varchar2(1) default 'N' not null,
   GWF_PROCESSED_OK varchar2(1),
   GWF_JOB_TYPE varchar2(1),
   GWF_RESPONSE_FILE varchar2(1),
   COMPLETE_DT date,
   INSTANCE_STATUS varchar2(10) not null,
   CANCEL_DT date,
   CANCEL_BY varchar2(80),
   CANCEL_REASON varchar2(40),
   CANCEL_METHOD varchar2(40),
   STG_EXTRACT_DATE date not null,
   STG_LAST_UPDATE_DATE date not null,
   STAGE_DONE_DATE date)
tablespace MAXDAT_DATA;

alter table CORP_ETL_MANAGE_JOBS_PK add constraint CORP_ETL_MANAGE_JOBS_PK primary key (JOB_ID) using index tablespace MAXDAT_INDX;

create unique index CORP_ETL_MANAGE_JOBS_UIX1 on CORP_ETL_MANAGE_JOBS(CEMFR_ID,JOB_ID) tablespace MAXDAT_INDX;

grant select on CORP_ETL_MANAGE_JOBS to MAXDAT_READ_ONLY;


create table CORP_ETL_MANAGE_JOBS_OLTP 
  (CEMFR_ID number not null,
   JOB_ID number not null,
   CREATE_DT date,
   CREATED_BY varchar2(102),
   JOB_NAME varchar2(500),
   JOB_DETAIL varchar2(500),
   JOB_GROUP varchar2(80),
   JOB_TYPE varchar2(32),
   JOB_START_DT date,
   JOB_END_DT date,
   JOB_STATUS varchar2(100),
   FILE_NAME varchar2(50),
   RECEIPT_DT date,
   TRANSMIT_DT date,
   FILE_TYPE varchar2(50),
   FILE_SOURCE varchar2(50),
   FILE_DESTINATION varchar2(50),
   PLAN_NAME varchar2(64),
   RESPONSE_FILE_REQ varchar2(50),
   RECORD_COUNT number,
   RECORD_ERROR_COUNT number,
   RESPONSE_FILE_NAME varchar2(50),
   LAST_UPDATE_BY_NAME varchar2(102),
   LAST_UPDATE_BY_DT date,
   ASSD_IDENTIFY_JOB date,
   ASED_IDENTIFY_JOB date,
   ASSD_PROCESS_JOB date,
   ASED_PROCESS_JOB date,
   ASSD_CREATE_RESPONSE_FILE date,
   ASED_CREATE_RESPONSE_FILE date,
   ASSD_CREATE_OUTBOUND_FILE date,
   ASED_CREATE_OUTBOUND_FILE date,
   ASF_IDENTIFY_JOB varchar2(1) default 'N' not null,
   ASF_PROCESS_JOB varchar2(1) default 'N' not null,
   ASF_CREATE_RESPONSE_FILE varchar2(1) default 'N' not null,
   ASF_CREATE_OUTBOUND_FILE varchar2(1) default 'N' not null,
   GWF_PROCESSED_OK varchar2(1),
   GWF_JOB_TYPE varchar2(1),
   GWF_RESPONSE_FILE varchar2(1),
   COMPLETE_DT date,
   INSTANCE_STATUS varchar2(10) not null,
   CANCEL_DT date,
   STG_EXTRACT_DATE date not null,
   STG_LAST_UPDATE_DATE date not null,
   STAGE_DONE_DATE date,
   RESPONSE_DT date,
   JOB_STATUS_LABEL varchar2(100),
   CANCEL_BY varchar2(40),
   CANCEL_REASON varchar2(40),
   CANCEL_METHOD varchar2(40))
tablespace MAXDAT_DATA;
   
alter table CORP_ETL_MANAGE_JOBS_OLTP add constraint CORP_ETL_MANAGE_JOBS_OLTP_PK primary key (CEMFR_ID) using index tablespace MAXDAT_INDX;

create unique index CORP_ETL_MANAGE_JOBS_OLTP_UIX1 on CORP_ETL_MANAGE_JOBS_OLTP (CEMFR_ID,JOB_ID) tablespace MAXDAT_INDX; 

grant select on CORP_ETL_MANAGE_JOBS_OLTP to MAXDAT_READ_ONLY;


create table CORP_ETL_MANAGE_JOBS_WIP_BPM 
  (CEMFR_ID number not null,
   JOB_ID number not null,
   CREATE_DT date,
   CREATED_BY varchar2(102),
   JOB_NAME varchar2(500),
   JOB_DETAIL varchar2(500),
   JOB_GROUP varchar2(80),
   JOB_TYPE varchar2(32),
   JOB_START_DT date,
   JOB_END_DT date,
   JOB_STATUS varchar2(100),
   FILE_NAME varchar2(50),
   RECEIPT_DT date,
   TRANSMIT_DT date,
   FILE_TYPE varchar2(50),
   FILE_SOURCE varchar2(50),
   FILE_DESTINATION varchar2(50),
   PLAN_NAME varchar2(64),
   RESPONSE_FILE_REQ varchar2(50),
   RECORD_COUNT number,
   RECORD_ERROR_COUNT number,
   RESPONSE_FILE_NAME varchar2(50),
   LAST_UPDATE_BY_NAME varchar2(102),
   LAST_UPDATE_BY_DT date,
   ASSD_IDENTIFY_JOB date,
   ASED_IDENTIFY_JOB date,
   ASSD_PROCESS_JOB date,
   ASED_PROCESS_JOB date,
   ASSD_CREATE_RESPONSE_FILE date,
   ASED_CREATE_RESPONSE_FILE date,
   ASSD_CREATE_OUTBOUND_FILE date,
   ASED_CREATE_OUTBOUND_FILE date,
   ASF_IDENTIFY_JOB varchar2(1) default 'N' not null,
   ASF_PROCESS_JOB varchar2(1) default 'N' not null,
   ASF_CREATE_RESPONSE_FILE varchar2(1) default 'N' not null,
   ASF_CREATE_OUTBOUND_FILE varchar2(1) default 'N' not null,
   GWF_PROCESSED_OK varchar2(1),
   GWF_JOB_TYPE varchar2(1),
   GWF_RESPONSE_FILE varchar2(1),
   COMPLETE_DT date,
   INSTANCE_STATUS varchar2(10) not null,
   CANCEL_DT date,
   STG_EXTRACT_DATE date not null,
   STG_LAST_UPDATE_DATE date not null,
   STAGE_DONE_DATE date,
   UPDATED varchar2(1),
   CANCEL_BY varchar2(40),
   CANCEL_REASON varchar2(40),
   CANCEL_METHOD varchar2(40))
tablespace MAXDAT_DATA;
   
alter table CORP_ETL_MANAGE_JOBS_WIP add constraint CORP_ETL_MANAGE_JOBS_WIP_PK primary key (CEMFR_ID) using index tablespace MAXDAT_INDX;
   
grant select on CORP_ETL_MANAGE_JOBS_WIP_BPM to MAXDAT_READ_ONLY;


create table CORP_MJ_ETL_FILE_LKUP
  (FILE_NAME varchar2(50),
   FILE_TYPE varchar2(50),
   FILE_SOURCE varchar2(50),
   PLAN_ID varchar2(32),
   FILE_DESTINATION varchar2(50),
   RESPONSE_FILE_REQ varchar2(50),
   RESPONSE_FILE_NAME varchar2(50),
   FILENAME_BEG varchar2(50),
   FILENAME_CONT varchar2(50))
tablespace MAXDAT_DATA;

create unique index CORP_MJ_ETL_FILE_LKUP_UX1 on CORP_MJ_ETL_FILE_LKUP (FILE_NAME) tablespace MAXDAT_DATA;

grant select on CORP_MJ_ETL_FILE_LKUP to MAXDAT_READ_ONLY;


create table CORP_MJ_FILE_CAL_LKUP
  (FILE_NAME varchar2(50),
   SLA_RECEIPT_INTERVAL varchar2(50),
   SLA_TIME date,
   LATE_FILE_ALERT_TIME date,
   TIMELY_PROCESSING_ALERT_TIME date,
   MINIMUM_RECORDS_EXPECTED number,
   MAXIMUM_RECORDS_EXPECTED number,
   PERCENTAGE_OF_ERRORS_TO_ALERT number)
tablespace MAXDAT_DATA;

create unique index CORP_MJ_FILE_CAL_LKUP_UX1 on CORP_MJ_FILE_CAL_LKUP (FILE_NAME) tablespace MAXDAT_INDX;

grant select on CORP_MJ_FILE_CAL_LKUP to MAXDAT_READ_ONLY;


   