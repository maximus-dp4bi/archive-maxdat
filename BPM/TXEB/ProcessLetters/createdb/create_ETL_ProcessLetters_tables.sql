--Process Letters tables

-- Letters Stage
  CREATE TABLE LETTERS_STG 
   (	LETTER_ID NUMBER(18,0) NOT NULL ENABLE, 
	LETTER_REQUESTED_ON DATE, 
	LETTER_STATUS_CD VARCHAR2(32 BYTE), 
	LETTER_STATUS VARCHAR2(256 BYTE), 
	LETTER_CREATE_TS DATE, 
	LETTER_UPDATE_TS DATE, 
	LETTER_SENT_ON DATE, 
	PROGRAM_CODE VARCHAR2(32 BYTE), 
	PROGRAM VARCHAR2(50 BYTE), 
	DRIVER_TABLE_NAME VARCHAR2(60 BYTE), 
	LETTER_MAILED_DATE DATE, 
	LETTER_REJECT_REASON_CD VARCHAR2(32 BYTE), 
	LETTER_REJECT_REASON VARCHAR2(100 BYTE), 
	LETTER_PRINTED_ON DATE, 
	LETTER_ERROR_CODES VARCHAR2(4000 BYTE), 
	RESIDENCE_COUNTY VARCHAR2(64 BYTE), 
	RESIDENCE_ZIP_CODE VARCHAR2(32 BYTE), 
	LETTER_CASE_ID NUMBER(18,0), 
	LETTER_PARENT_LMREQ_ID NUMBER(18,0), 
	LETTER_REF_TYPE VARCHAR2(40 BYTE), 
	LETTER_TYPE_CD VARCHAR2(40 BYTE), 
	LETTER_TYPE VARCHAR2(100 BYTE), 
	LETTER_REQUEST_TYPE VARCHAR2(2 BYTE), 
	LETTER_LANG_CD VARCHAR2(32 BYTE), 
	LANGUAGE VARCHAR2(20 BYTE), 
	LETTER_DRIVER_TYPE VARCHAR2(4 BYTE), 
	LET_MATERIAL_REQUEST_ID NUMBER(18,0), 
	LETTER_CREATED_BY VARCHAR2(80 BYTE), 
	LETTER_RETURN_REASON_CD VARCHAR2(32 BYTE), 
	RETURN_REASON VARCHAR2(100 BYTE), 
	LETTER_UPDATED_BY VARCHAR2(80 BYTE), 
	LETTER_RETURN_DATE DATE,
        LETTER_DEFINITION_ID NUMBER(18,0)
   ) tablespace MAXDAT_DATA;

 CREATE INDEX LETTERS_ID_STG_IDX ON LETTERS_STG (LETTER_ID) tablespace MAXDAT_INDX;
  CREATE INDEX LETTERS_REQUEST_TYPE_STG_IDX ON LETTERS_STG (LETTER_REQUEST_TYPE) tablespace MAXDAT_INDX;
  CREATE INDEX LETTERS_SENT_ON_STG_IDX ON LETTERS_STG (LETTER_SENT_ON) tablespace MAXDAT_INDX;
  CREATE INDEX LETTERS_STG_IDX ON LETTERS_STG (LETTER_TYPE_CD, LETTER_ID) tablespace MAXDAT_INDX;
  CREATE INDEX LETTERS_TYPE_CD_STG_IDX ON LETTERS_STG (LETTER_TYPE_CD) tablespace MAXDAT_INDX;

-- Initially indexes for MEA
create index LETTER_req_on_IDX on LETTERS_STG (LETTER_REQUESTED_ON) tablespace MAXDAT_INDX;
create index LETTER_CASE_ID_IDX on LETTERS_STG (LETTER_CASE_ID) tablespace MAXDAT_INDX;




grant select on LETTERS_STG to MAXDAT_READ_ONLY;


create table CORP_ETL_PROC_LETTERS 
   (	CEPN_ID number not null enable, 
	LETTER_REQUEST_ID number not null enable, 
	CREATE_DT date not null enable, 
	CREATE_BY varchar2(50 byte), 
	REQUEST_DT date, 
	LETTER_TYPE varchar2(100 byte), 
	program varchar2(256 byte), 
	CASE_ID number, 
	COUNTY_CODE varchar2(10 byte), 
	ZIP_CODE number, 
	LANGUAGE varchar2(256 byte), 
	REPRINT varchar2(1 byte), 
	REQUEST_DRIVER_TYPE varchar2(10 byte), 
	REQUEST_DRIVER_TABLE varchar2(32 byte), 
	STATUS varchar2(256 byte) not null enable, 
	STATUS_DT date not null enable, 
	SENT_DT date, 
	PRINT_DT date, 
	MAILED_DT date, 
	RETURN_DT date, 
	RETURN_REASON varchar2(256 byte), 
	REJECT_REASON varchar2(256 byte), 
	ERROR_REASON varchar2(4000 byte), 
	TRANSMIT_FILE_NAME varchar2(1000 byte), 
	TRANSMIT_FILE_DT date, 
	LETTER_RESP_FILE_NAME varchar2(1000 byte), 
	LETTER_RESP_FILE_DT date, 
	LAST_UPDATE_DT date, 
	LAST_UPDATE_BY_NAME varchar2(50 byte), 
    NEWBORN_FLAG varchar2(1 byte), 
	TASK_ID number, 
	CANCEL_DT date, 
	CANCEL_BY varchar2(50 byte), 
    CANCEL_REASON varchar2(100 byte), 
    CANCEL_METHOD varchar2(50 byte), 
	COMPLETE_DT date, 
	INSTANCE_STATUS varchar2(10 byte) not null enable, 
	ASSD_PROCESS_LETTER_REQ date, 
	ASED_PROCESS_LETTER_REQ date, 
	ASSD_TRANSMIT date, 
	ASED_TRANSMIT date, 
	ASSD_RECEIVE_CONFIRMATION date, 
	ASED_RECEIVE_CONFIRMATION date, 	
	ASF_PROCESS_LETTER_REQ varchar2(1 byte) not null enable, 
	ASF_TRANSMIT varchar2(1 byte) not null enable, 
	ASF_RECEIVE_CONFIRMATION varchar2(1 byte) not null enable, 
	GWF_VALID varchar2(1 byte), 
	GWF_OUTCOME varchar2(1 byte), 
	GWF_WORK_REQUIRED varchar2(1 byte), 
	STG_EXTRACT_DATE date not null enable, 
	STG_LAST_UPDATE_DATE date not null enable, 
	STAGE_DONE_DATE date,
	NEW_LETTER_REQUEST_ID NUMBER, 
    ASSD_RESOLVE_RESP     DATE,
    ASED_RESOLVE_RESP     DATE,
    ASF_RESOLVE_RESP      VARCHAR2(1),
	ERROR_COUNT           NUMBER,
    LAST_ERRORED_DATE     DATE,
	LAST_ERROR_FIXED_BY   VARCHAR2(80),
    REJECT_FLAG           VARCHAR2(1),
	CREATED_BY_ID         VARCHAR2(80),
    LAST_UPDATED_BY_ID    VARCHAR2(80),
    CANCEL_BY_ID          VARCHAR2(80),
    EPM_MAIL_DT_FOR_CASE DATE,
    LETTER_DEFINITION_ID NUMBER(18,0)
) 
tablespace MAXDAT_DATA;
   
alter table CORP_ETL_PROC_LETTERS add constraint CORP_ETL_PROC_LETTERS_PK primary key (CEPN_ID) using index tablespace MAXDAT_INDX;
alter table CORP_ETL_PROC_LETTERS add constraint CORP_ETL_PROC_LETTERS_ID unique (LETTER_REQUEST_ID) using index tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_CANC_DT on CORP_ETL_PROC_LETTERS (CANCEL_DT) tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_COMP_DT on CORP_ETL_PROC_LETTERS (COMPLETE_DT, 0) tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_STAT on CORP_ETL_PROC_LETTERS (INSTANCE_STATUS) tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_SLUD on CORP_ETL_PROC_LETTERS (STG_LAST_UPDATE_DATE)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_REQ_DT on CORP_ETL_PROC_LETTERS (REQUEST_DT)
  tablespace MAXDAT_INDX;

create index CEPL_LETTER_TYPE on corp_etl_proc_letters(letter_type) tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_LDEF_ID on CORP_ETL_PROC_LETTERS (LETTER_DEFINITION_ID)  tablespace MAXDAT_INDX;
  


grant select on CORP_ETL_PROC_LETTERS to MAXDAT_READ_ONLY;


--Process Letter child table 

 create table CORP_ETL_PROC_LETTERS_CHD 
   (	LETTER_REQUEST_ID number, 
	CREATE_DT date, 
	CLIENT_ID number, 
	SUB_PROGRAM varchar2(50 byte)
   ) tablespace MAXDAT_DATA;

create index CORP_ETL_PROC_LETTERS_CHD_IDX1 on CORP_ETL_PROC_LETTERS_CHD (LETTER_REQUEST_ID) tablespace MAXDAT_INDX;



grant select on CORP_ETL_PROC_LETTERS_CHD to MAXDAT_READ_ONLY;


--Process Letters child tmp table
 create table CORP_ETL_PROC_LETTERS_CHD_TMP 
   (	LETTER_REQUEST_ID number, 
	CREATE_DT date, 
	CLIENT_ID number, 
	SUB_PROGRAM varchar2(50 byte), 
	REF_ID number
   ) 
  tablespace MAXDAT_DATA ;

  create index CORP_ETL_PROC_LTR_CHD_TMP_IDX1 on CORP_ETL_PROC_LETTERS_CHD_TMP (LETTER_REQUEST_ID) tablespace MAXDAT_INDX ;
  create index CORP_ETL_PROC_LETTERS_CHD_IDX2 ON CORP_ETL_PROC_LETTERS_CHD(CREATE_DT) TABLESPACE MAXDAT_INDX;
  create index CORP_ETL_PROC_LETTERS_CHD_IDX3 ON CORP_ETL_PROC_LETTERS_CHD(CLIENT_ID) TABLESPACE MAXDAT_INDX;



grant select on CORP_ETL_PROC_LETTERS_CHD_TMP to MAXDAT_READ_ONLY;


--Process Letters OLTP 


  create table CORP_ETL_PROC_LETTERS_OLTP 
   (	CEPN_ID number not null enable, 
	LETTER_REQUEST_ID number not null enable, 
	CREATE_DT date not null enable, 
	CREATE_BY varchar2(50 byte), 
	REQUEST_DT date, 
	LETTER_TYPE varchar2(100 byte), 
	program varchar2(50 byte), 
	CASE_ID number, 
	COUNTY_CODE varchar2(10 byte), 
	ZIP_CODE number, 
	LANGUAGE varchar2(256 byte), 
	REPRINT varchar2(1 byte), 
	REQUEST_DRIVER_TYPE varchar2(10 byte), 
	REQUEST_DRIVER_TABLE varchar2(32 byte), 
	STATUS varchar2(256 byte) not null enable, 
	STATUS_DT date not null enable, 
	SENT_DT date, 
	PRINT_DT date, 
	MAILED_DT date, 
	RETURN_DT date, 
	RETURN_REASON varchar2(256 byte), 
	REJECT_REASON varchar2(256 byte), 
	ERROR_REASON varchar2(4000 byte), 
	TRANSMIT_FILE_NAME varchar2(1000 byte), 
	TRANSMIT_FILE_DT date, 
	LETTER_RESP_FILE_NAME varchar2(1000 byte), 
	LETTER_RESP_FILE_DT date, 
	LAST_UPDATE_DT date, 
	LAST_UPDATE_BY_NAME varchar2(50 byte), 
	NEWBORN_FLAG varchar2(1 byte), 
	TASK_ID number, 
	CANCEL_DT date, 
	CANCEL_BY varchar2(50 byte), 
        CANCEL_REASON varchar2(100 byte), 
        CANCEL_METHOD varchar2(50 byte), 
	COMPLETE_DT date, 
	INSTANCE_STATUS varchar2(10 byte) not null enable, 
	ASSD_PROCESS_LETTER_REQ date, 
	ASED_PROCESS_LETTER_REQ date, 
	ASSD_TRANSMIT date, 
	ASED_TRANSMIT date, 
	ASSD_RECEIVE_CONFIRMATION date, 
	ASED_RECEIVE_CONFIRMATION date, 
	ASF_PROCESS_LETTER_REQ varchar2(1 byte) not null enable, 
	ASF_TRANSMIT varchar2(1 byte) not null enable, 
	ASF_RECEIVE_CONFIRMATION varchar2(1 byte) not null enable, 
	GWF_VALID varchar2(1 byte), 
	GWF_OUTCOME varchar2(1 byte), 
	GWF_WORK_REQUIRED varchar2(1 byte), 
	STG_EXTRACT_DATE date not null enable, 
	STG_LAST_UPDATE_DATE date not null enable, 
	STAGE_DONE_DATE date, 
	ERROR_DATE date, 
	STEP_DEFINITION_ID number, 
	TASK_CREATE_DT date,
    NEW_LETTER_REQUEST_ID NUMBER, 
    ASSD_RESOLVE_RESP     DATE,
    ASED_RESOLVE_RESP     DATE,
    ASF_RESOLVE_RESP      VARCHAR2(1),
	ERROR_COUNT           NUMBER,
    LAST_ERRORED_DATE     DATE,
	LAST_ERROR_FIXED_BY   VARCHAR2(80),
    REJECT_FLAG           VARCHAR2(1),
	CREATED_BY_ID         VARCHAR2(80),
    LAST_UPDATED_BY_ID    VARCHAR2(80),
    CANCEL_BY_ID          VARCHAR2(80),
	OBE_status_date       DATE,
    EPM_MAIL_DT_FOR_CASE DATE,
    LETTER_DEFINITION_ID NUMBER(18,0)
	)
tablespace MAXDAT_DATA ;

alter table CORP_ETL_PROC_LETTERS_OLTP add constraint CORP_ETL_PROC_LETTERS_OLT_PK primary key (CEPN_ID) using index tablespace MAXDAT_INDX; 
alter table CORP_ETL_PROC_LETTERS_OLTP add constraint CORP_ETL_PROC_LETTERS_OLTP_ID unique (LETTER_REQUEST_ID) using index tablespace MAXDAT_INDX;



grant select on CORP_ETL_PROC_LETTERS_OLTP to MAXDAT_READ_ONLY;


-- Process Letters OLTP Temp
create table CORP_ETL_PROC_LETTERS_OLTP_T
(
  cepn_id                   NUMBER not null,
  letter_request_id         NUMBER not null,
  create_dt                 DATE not null,
  create_by                 VARCHAR2(50),
  request_dt                DATE,
  letter_type               VARCHAR2(100),
  program                   VARCHAR2(64),
  case_id                   NUMBER,
  county_code               VARCHAR2(10),
  zip_code                  NUMBER,
  language                  VARCHAR2(64),
  reprint                   VARCHAR2(1),
  request_driver_type       VARCHAR2(10),
  request_driver_table      VARCHAR2(32),
  status                    VARCHAR2(64) not null,
  status_dt                 DATE not null,
  sent_dt                   DATE,
  print_dt                  DATE,
  mailed_dt                 DATE,
  return_dt                 DATE,
  return_reason             VARCHAR2(64),
  reject_reason             VARCHAR2(64),
  error_reason              VARCHAR2(4000),
  transmit_file_name        VARCHAR2(1000),
  transmit_file_dt          DATE,
  letter_resp_file_name     VARCHAR2(1000),
  letter_resp_file_dt       DATE,
  last_update_dt            DATE,
  last_update_by_name       VARCHAR2(50),
  newborn_flag              VARCHAR2(1),
  task_id                   NUMBER,
  cancel_dt                 DATE,
  cancel_by                 VARCHAR2(50),
  cancel_reason             VARCHAR2(100),
  cancel_method             VARCHAR2(50),
  complete_dt               DATE,
  instance_status           VARCHAR2(10) not null,
  assd_process_letter_req   DATE,
  ased_process_letter_req   DATE,
  assd_transmit             DATE,
  ased_transmit             DATE,
  assd_receive_confirmation DATE,
  ased_receive_confirmation DATE,
  asf_process_letter_req    VARCHAR2(1) not null,
  asf_transmit              VARCHAR2(1) not null,
  asf_receive_confirmation  VARCHAR2(1) not null,  
  gwf_valid                 VARCHAR2(1),
  gwf_outcome               VARCHAR2(1),
  gwf_work_required         VARCHAR2(1),
  stg_extract_date          DATE not null,
  stg_last_update_date      DATE not null,
  stage_done_date           DATE,
  error_date                DATE,
  step_definition_id        NUMBER,
  task_create_dt            DATE,
  NEW_LETTER_REQUEST_ID     NUMBER, 
  ASSD_RESOLVE_RESP         DATE,
  ASED_RESOLVE_RESP         DATE,
  ASF_RESOLVE_RESP          VARCHAR2(1),
  ERROR_COUNT               NUMBER,
  LAST_ERRORED_DATE         DATE,
  LAST_ERROR_FIXED_BY       VARCHAR2(80),
  REJECT_FLAG               VARCHAR2(1),
  CREATED_BY_ID             VARCHAR2(80),
  LAST_UPDATED_BY_ID        VARCHAR2(80),
  CANCEL_BY_ID              VARCHAR2(80),
  EPM_MAIL_DT_FOR_CASE      DATE,
  LETTER_DEFINITION_ID NUMBER(18,0)
)
tablespace MAXDAT_DATA;

alter table CORP_ETL_PROC_LETTERS_OLTP_T
  add constraint CORP_ETL_PROC_LTRS_OLTP_T_PK primary key (CEPN_ID)
  using index 
  tablespace MAXDAT_DATA;
alter table CORP_ETL_PROC_LETTERS_OLTP_T
  add constraint CORP_ETL_PROC_LTRS_OLTP_T_ID unique (LETTER_REQUEST_ID)
  using index 
  tablespace MAXDAT_DATA;

grant select on CORP_ETL_PROC_LETTERS_OLTP_T to MAXDAT_READ_ONLY;


--Process Letters WIP BPM

create table CORP_ETL_PROC_LETTERS_WIP_BPM 
   (	
    CEPN_ID number not null enable, 
	LETTER_REQUEST_ID number not null enable, 
	CREATE_DT date not null enable, 
	CREATE_BY varchar2(50 byte), 
	REQUEST_DT date, 
	LETTER_TYPE varchar2(100 byte), 
	program varchar2(50 byte), 
	CASE_ID number, 
	COUNTY_CODE varchar2(10 byte), 
	ZIP_CODE number, 
	LANGUAGE varchar2(256 byte), 
	REPRINT varchar2(1 byte), 
	REQUEST_DRIVER_TYPE varchar2(10 byte), 
	REQUEST_DRIVER_TABLE varchar2(32 byte), 
	STATUS varchar2(256 byte) not null enable, 
	STATUS_DT date not null enable, 
	SENT_DT date, 
	PRINT_DT date, 
	MAILED_DT date, 
	RETURN_DT date, 
	RETURN_REASON varchar2(256 byte), 
	REJECT_REASON varchar2(256 byte), 
	ERROR_REASON varchar2(4000 byte), 
	TRANSMIT_FILE_NAME varchar2(1000 byte), 
	TRANSMIT_FILE_DT date, 
	LETTER_RESP_FILE_NAME varchar2(1000 byte), 
	LETTER_RESP_FILE_DT date, 
	LAST_UPDATE_DT date, 
	LAST_UPDATE_BY_NAME varchar2(50 byte), 
	NEWBORN_FLAG varchar2(1 byte), 
	TASK_ID number, 
	CANCEL_DT date, 
	CANCEL_BY varchar2(50 byte), 
        CANCEL_REASON varchar2(100 byte), 
        CANCEL_METHOD varchar2(50 byte), 
	COMPLETE_DT date, 
	INSTANCE_STATUS varchar2(10 byte) not null enable, 
	ASSD_PROCESS_LETTER_REQ date, 
	ASED_PROCESS_LETTER_REQ date, 
	ASSD_TRANSMIT date, 
	ASED_TRANSMIT date, 
	ASSD_RECEIVE_CONFIRMATION date, 
	ASED_RECEIVE_CONFIRMATION date, 
	ASF_PROCESS_LETTER_REQ varchar2(1 byte) not null enable, 
	ASF_TRANSMIT varchar2(1 byte) not null enable, 
	ASF_RECEIVE_CONFIRMATION varchar2(1 byte) not null enable, 
	GWF_VALID varchar2(1 byte), 
	GWF_OUTCOME varchar2(1 byte), 
	GWF_WORK_REQUIRED varchar2(1 byte), 
	STG_EXTRACT_DATE date not null enable, 
	STG_LAST_UPDATE_DATE date not null enable, 
	STAGE_DONE_DATE date, 
	updated varchar2(1 byte),
	NEW_LETTER_REQUEST_ID     NUMBER, 
    ASSD_RESOLVE_RESP         DATE,
    ASED_RESOLVE_RESP         DATE,
    ASF_RESOLVE_RESP          VARCHAR2(1),
    ERROR_COUNT               NUMBER,
    LAST_ERRORED_DATE         DATE,
    LAST_ERROR_FIXED_BY       VARCHAR2(80),
    REJECT_FLAG               VARCHAR2(1),
    CREATED_BY_ID             VARCHAR2(80),
    LAST_UPDATED_BY_ID        VARCHAR2(80),
    CANCEL_BY_ID              VARCHAR2(80),
    EPM_MAIL_DT_FOR_CASE      DATE,
    LETTER_DEFINITION_ID NUMBER(18,0)
)
tablespace MAXDAT_DATA  ;

alter table CORP_ETL_PROC_LETTERS_WIP_BPM add	constraint CORP_ETL_PROC_LETTERS_WIP_PK primary key (CEPN_ID) using index tablespace MAXDAT_INDX; 
alter table CORP_ETL_PROC_LETTERS_WIP_BPM add constraint CORP_ETL_PROC_LTR_BPM_ID unique (LETTER_REQUEST_ID) using index tablespace MAXDAT_INDX;



grant select on CORP_ETL_PROC_LETTERS_WIP_BPM to MAXDAT_READ_ONLY;


create table LETTER_OUT_DATA_CONTENT_STG
(
  letter_out_data_id NUMBER not null,
  letter_req_id      NUMBER,
  job_id             NUMBER,
  create_ts          DATE,
  created_by         VARCHAR2(80),
  update_ts          DATE,
  updated_by         VARCHAR2(80)
)
tablespace MAXDAT_DATA;

create index LETTER_OUT_DATA_CONT_STG_IDX on LETTER_OUT_DATA_CONTENT_STG (LETTER_REQ_ID)
  tablespace MAXDAT_INDX;

create index LETTER_OUT_DATA_CONT_STG_IDX2 on LETTER_OUT_DATA_CONTENT_STG (LETTER_OUT_DATA_ID)
tablespace MAXDAT_INDX;

create index LETTER_OUT_DATA_CONT_STG_IDX3 on LETTER_OUT_DATA_CONTENT_STG (JOB_ID)
tablespace MAXDAT_INDX;



grant select on LETTER_OUT_DATA_CONTENT_STG to MAXDAT_READ_ONLY;


-- Create table
create table CORP_ETL_PROC_LETTERS_WIP_T
(
  cepn_id                   NUMBER not null,
  letter_request_id         NUMBER not null,
  create_dt                 DATE not null,
  create_by                 VARCHAR2(50),
  request_dt                DATE,
  letter_type               VARCHAR2(100),
  program                   VARCHAR2(50),
  case_id                   NUMBER,
  county_code               VARCHAR2(10),
  zip_code                  NUMBER,
  language                  VARCHAR2(256),
  reprint                   VARCHAR2(1),
  request_driver_type       VARCHAR2(10),
  request_driver_table      VARCHAR2(32),
  status                    VARCHAR2(256) not null,
  status_dt                 DATE not null,
  sent_dt                   DATE,
  print_dt                  DATE,
  mailed_dt                 DATE,
  return_dt                 DATE,
  return_reason             VARCHAR2(256),
  reject_reason             VARCHAR2(256),
  error_reason              VARCHAR2(4000),
  transmit_file_name        VARCHAR2(1000),
  transmit_file_dt          DATE,
  letter_resp_file_name     VARCHAR2(1000),
  letter_resp_file_dt       DATE,
  last_update_dt            DATE,
  last_update_by_name       VARCHAR2(50),
  newborn_flag              VARCHAR2(1),
  task_id                   NUMBER,
  cancel_dt                 DATE,
  cancel_by                 VARCHAR2(50),
  cancel_reason             VARCHAR2(100),
  cancel_method             VARCHAR2(50),
  complete_dt               DATE,
  instance_status           VARCHAR2(10) not null,
  assd_process_letter_req   DATE,
  ased_process_letter_req   DATE,
  assd_transmit             DATE,
  ased_transmit             DATE,
  assd_receive_confirmation DATE,
  ased_receive_confirmation DATE,
  asf_process_letter_req    VARCHAR2(1) not null,
  asf_transmit              VARCHAR2(1) not null,
  asf_receive_confirmation  VARCHAR2(1) not null,
  gwf_valid                 VARCHAR2(1),
  gwf_outcome               VARCHAR2(1),
  gwf_work_required         VARCHAR2(1),
  stg_extract_date          DATE not null,
  stg_last_update_date      DATE not null,
  stage_done_date           DATE,
  updated                   VARCHAR2(1),
  NEW_LETTER_REQUEST_ID     NUMBER, 
  ASSD_RESOLVE_RESP         DATE,
  ASED_RESOLVE_RESP         DATE,
  ASF_RESOLVE_RESP          VARCHAR2(1),
  ERROR_COUNT               NUMBER,
  LAST_ERRORED_DATE         DATE,
  LAST_ERROR_FIXED_BY       VARCHAR2(80),
  REJECT_FLAG               VARCHAR2(1),
  CREATED_BY_ID             VARCHAR2(80),
  LAST_UPDATED_BY_ID        VARCHAR2(80),
  CANCEL_BY_ID              VARCHAR2(80),
  EPM_MAIL_DT_FOR_CASE      DATE,
  LETTER_DEFINITION_ID NUMBER(18,0)
)
tablespace MAXDAT_DATA;

-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_PROC_LETTERS_WIP_T
  add constraint CORP_ETL_PROC_LTR_WIP_T_PK primary key (CEPN_ID)
  using index 
  tablespace MAXDAT_DATA;
alter table CORP_ETL_PROC_LETTERS_WIP_T
  add constraint CORP_ETL_PROC_LTR_BPM_T_ID unique (LETTER_REQUEST_ID)
  using index 
  tablespace MAXDAT_DATA;

create index CORP_ETL_PROC_LTR_BPM_T_IDX1 on CORP_ETL_PROC_LETTERS_WIP_T (ASED_PROCESS_LETTER_REQ, 0)
tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_BPM_T_IDX2 on CORP_ETL_PROC_LETTERS_WIP_T (GWF_VALID, 0)
tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_BPM_T_IDX3 on CORP_ETL_PROC_LETTERS_WIP_T (ASED_TRANSMIT, 0)
tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_BPM_T_IDX4 on CORP_ETL_PROC_LETTERS_WIP_T (ASSD_RECEIVE_CONFIRMATION, 0)
tablespace MAXDAT_INDX;

-- Grant/Revoke object privileges 
grant select on CORP_ETL_PROC_LETTERS_WIP_T to MAXDAT_READ_ONLY;



-- ETL Mailhouse Stage
create table ETL_MAILHOUSE_STG
(
  job_id     NUMBER(18) not null,
  lmreq_id   NUMBER(18),
  create_ts  DATE,
  created_by VARCHAR2(80)
)
tablespace MAXDAT_DATA;

create index ETL_MAILHOUSE_STG_IDX on ETL_MAILHOUSE_STG (LMREQ_ID)
  tablespace MAXDAT_INDX;

grant select on ETL_MAILHOUSE_STG to MAXDAT_READ_ONLY;


-- Job Run Data Stage
create table JOB_RUN_DATA_STG
(
  job_run_data_id NUMBER(18) not null,
  filename        VARCHAR2(1000),
  status_cd       VARCHAR2(32),
  create_ts       DATE,
  created_by      VARCHAR2(80),
  update_ts       DATE,
  updated_by      VARCHAR2(80)
)
tablespace MAXDAT_DATA;

create index JOB_RUN_DATA_STG_IDX on JOB_RUN_DATA_STG (JOB_RUN_DATA_ID)
  tablespace MAXDAT_INDX;

grant select on JOB_RUN_DATA_STG to MAXDAT_READ_ONLY;





