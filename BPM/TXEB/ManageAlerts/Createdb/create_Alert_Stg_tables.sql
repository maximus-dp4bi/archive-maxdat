create table ALERTLOG_STG (
log_batch_id number(38)
, Logtime timestamp
, loghost varchar2(30)
, logpid number(15)
, logthread number(15)
, logservice varchar2(100)
, logtype varchar2(100)
, logjob_id number(15)
, logjob_name varchar2(200)
, report_name varchar2(100)
, redef_id number(18)
, logID varchar2(100)
, log_schd_exec_id varchar2(100)
, create_dt date
, created_by varchar2(50)
, logline varchar2(3000)
, log_entries clob
, log_result varchar2(50)
) TABLESPACE MAXDAT_DATA;

 CREATE INDEX ALERTLOG_ID_STG_IDX ON ALERTLOG_STG (LOG_BATCH_ID) tablespace MAXDAT_INDX;
 CREATE INDEX ALERTLOG_ID_NAME_IDX ON ALERTLOG_STG (LOGJOB_NAME) tablespace MAXDAT_INDX;
 CREATE INDEX ALERTLOG_ID_RNAME_IDX ON ALERTLOG_STG (REPORT_NAME) tablespace MAXDAT_INDX;
 
create table ALERTLOG_TEMP_STG (
log_batch_id number(38)
, logtime timestamp
, logline varchar2(3000)
) TABLESPACE MAXDAT_DATA;

 CREATE INDEX ALERTLOG_ID_TEMP_STG_IDX ON ALERTLOG_TEMP_STG (LOG_BATCH_ID) tablespace MAXDAT_INDX;

create table ALERTEMAIL_STG (
email_batch_id number(38)
,email_number number(10)
, email_time timestamp
, email_subject varchar2(1000)
, email_sent_time timestamp
, email_attached_files number(10)
, email_body varchar2(3000)
, report_name varchar2(100)
, redef_id number(18)
, create_dt date
, created_by varchar2(50)
, email_result varchar2(50)
) TABLESPACE MAXDAT_DATA;

 CREATE INDEX ALERTemail_ID_STG_IDX ON ALERTemail_STG (email_BATCH_ID) tablespace MAXDAT_INDX;
 CREATE INDEX ALERTEMAIL_ID_RNAME_IDX ON ALERTEMAIL_STG (REPORT_NAME) tablespace MAXDAT_INDX;
 
create table ALERTEMAIL_TEMP_STG (
EMAIL_batch_id number(38)
, EMAIL_number number(10)
, EMAIL_sent_time timestamp
, EMAIL_SUBJECT varchar2(1000)
, EMAIL_BODY varchar2(3000)
, EMAIL_FILES_COUNT VARCHAR2(10)
) TABLESPACE MAXDAT_DATA;

 CREATE INDEX ALERTEMAIL_ID_TEMP_STG_IDX ON ALERTEMAIL_TEMP_STG (EMAIL_BATCH_ID) tablespace MAXDAT_INDX;

Grant select on alertlog_temp_stg to MAXDAT_READ_ONLY;
grant select on alertlog_stg to MAXDAT_READ_ONLY;
grant select on alertmail_temp_stg to MAXDAT_READ_ONLY;
grant select on alertmail_stg to MAXDAT_READ_ONLY;
