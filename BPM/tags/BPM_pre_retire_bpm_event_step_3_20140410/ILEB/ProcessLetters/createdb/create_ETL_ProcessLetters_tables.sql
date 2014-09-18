
-- CORP_ETL_PROC_LETTERS
create table CORP_ETL_PROC_LETTERS
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
  language                  VARCHAR2(32),
  reprint                   VARCHAR2(1),
  request_driver_type       VARCHAR2(10),
  request_driver_table      VARCHAR2(32),
  status                    VARCHAR2(32) not null,
  status_dt                 DATE not null,
  sent_dt                   DATE,
  print_dt                  DATE,
  mailed_dt                 DATE,
  return_dt                 DATE,
  return_reason             VARCHAR2(100),
  reject_reason             VARCHAR2(100),
  error_reason              VARCHAR2(100),
  transmit_file_name        VARCHAR2(100),
  transmit_file_dt          DATE,
  letter_resp_file_name     VARCHAR2(100),
  letter_resp_file_dt       DATE,
  last_update_dt            DATE,
  last_update_by_name       VARCHAR2(50),
  newborn_flag              VARCHAR2(1),
  task_id                   NUMBER,
  cancel_dt                 DATE,
  cancel_by                 VARCHAR2(50),
  complete_dt               DATE,
  instance_status           VARCHAR2(10) not null,
  assd_process_letter_req   DATE,
  ased_process_letter_req   DATE,
  assd_transmit             DATE,
  ased_transmit             DATE,
  assd_receive_confirmation DATE,
  ased_receive_confirmation DATE,
  assd_create_route_work    DATE,
  ased_create_route_work    DATE,
  asf_process_letter_req    VARCHAR2(1) not null,
  asf_transmit              VARCHAR2(1) not null,
  asf_receive_confirmation  VARCHAR2(1) not null,
  asf_create_route_work     VARCHAR2(1) not null,
  gwf_valid                 VARCHAR2(1),
  gwf_outcome               VARCHAR2(1),
  gwf_work_required         VARCHAR2(1),
  stg_extract_date          DATE not null,
  stg_last_update_date      DATE not null,
  stage_done_date           DATE
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create index CORP_ETL_PROC_LETTERS_CANC_DT on CORP_ETL_PROC_LETTERS (CANCEL_DT)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_COMP_DT on CORP_ETL_PROC_LETTERS (COMPLETE_DT, 0)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LETTERS_STAT on CORP_ETL_PROC_LETTERS (INSTANCE_STATUS)
  tablespace MAXDAT_INDX;

-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_PROC_LETTERS
  add constraint CORP_ETL_PROC_LETTERS_PK primary key (CEPN_ID)
  using index 
  tablespace MAXDAT_INDX;

alter table CORP_ETL_PROC_LETTERS
  add constraint CORP_ETL_PROC_LETTERS_ID unique (LETTER_REQUEST_ID)
  using index 
  tablespace MAXDAT_INDX;

-- Grant/Revoke object privileges 
grant select on CORP_ETL_PROC_LETTERS to MAXDAT_READ_ONLY;


-- CORP_ETL_PROC_LETTERS_CHD
create table CORP_ETL_PROC_LETTERS_CHD
(
  letter_request_id NUMBER,
  create_dt         DATE,
  client_id         NUMBER,
  sub_program       VARCHAR2(50)
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create index CORP_ETL_PROC_LETTERS_CHD_IDX1 on CORP_ETL_PROC_LETTERS_CHD (LETTER_REQUEST_ID)
  tablespace MAXDAT_INDX;

-- Grant/Revoke object privileges 
grant select on CORP_ETL_PROC_LETTERS_CHD to MAXDAT_READ_ONLY;


-- CORP_ETL_PROC_LETTERS_OLTP
create table CORP_ETL_PROC_LETTERS_OLTP
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
  language                  VARCHAR2(32),
  reprint                   VARCHAR2(1),
  request_driver_type       VARCHAR2(10),
  request_driver_table      VARCHAR2(32),
  status                    VARCHAR2(32) not null,
  status_dt                 DATE not null,
  sent_dt                   DATE,
  print_dt                  DATE,
  mailed_dt                 DATE,
  return_dt                 DATE,
  return_reason             VARCHAR2(100),
  reject_reason             VARCHAR2(100),
  error_reason              VARCHAR2(100),
  transmit_file_name        VARCHAR2(100),
  transmit_file_dt          DATE,
  letter_resp_file_name     VARCHAR2(100),
  letter_resp_file_dt       DATE,
  last_update_dt            DATE,
  last_update_by_name       VARCHAR2(50),
  newborn_flag              VARCHAR2(1),
  task_id                   NUMBER,
  cancel_dt                 DATE,
  cancel_by                 VARCHAR2(50),
  complete_dt               DATE,
  instance_status           VARCHAR2(10) not null,
  assd_process_letter_req   DATE,
  ased_process_letter_req   DATE,
  assd_transmit             DATE,
  ased_transmit             DATE,
  assd_receive_confirmation DATE,
  ased_receive_confirmation DATE,
  assd_create_route_work    DATE,
  ased_create_route_work    DATE,
  asf_process_letter_req    VARCHAR2(1) not null,
  asf_transmit              VARCHAR2(1) not null,
  asf_receive_confirmation  VARCHAR2(1) not null,
  asf_create_route_work     VARCHAR2(1) not null,
  gwf_valid                 VARCHAR2(1),
  gwf_outcome               VARCHAR2(1),
  gwf_work_required         VARCHAR2(1),
  stg_extract_date          DATE not null,
  stg_last_update_date      DATE not null,
  stage_done_date           DATE,
  error_date                DATE,
  step_definition_id        NUMBER,
  task_create_dt            DATE,
  STG_INSERT_UPDATE         VARCHAR2(1),
  STG_INSERT_JOB_ID         NUMBER
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create index CORP_ETL_PROC_LETTER_OLTP_STAT on CORP_ETL_PROC_LETTERS_OLTP (INSTANCE_STATUS)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_OLTP_CANC_DT on CORP_ETL_PROC_LETTERS_OLTP (CANCEL_DT)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_OLTP_COMP_DT on CORP_ETL_PROC_LETTERS_OLTP (COMPLETE_DT)
  tablespace MAXDAT_INDX;

-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_PROC_LETTERS_OLTP
  add constraint CORP_ETL_PROC_LETTERS_OLT_PK primary key (CEPN_ID)
  using index 
  tablespace MAXDAT_INDX;

alter table CORP_ETL_PROC_LETTERS_OLTP
  add constraint CORP_ETL_PROC_LETTERS_OLTP_ID unique (LETTER_REQUEST_ID)
  using index 
  tablespace MAXDAT_INDX;

-- Grant/Revoke object privileges 
grant select on CORP_ETL_PROC_LETTERS_OLTP to MAXDAT_READ_ONLY;


-- CORP_ETL_PROC_LETTERS_WIP_BPM
create table CORP_ETL_PROC_LETTERS_WIP_BPM
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
  language                  VARCHAR2(32),
  reprint                   VARCHAR2(1),
  request_driver_type       VARCHAR2(10),
  request_driver_table      VARCHAR2(32),
  status                    VARCHAR2(32) not null,
  status_dt                 DATE not null,
  sent_dt                   DATE,
  print_dt                  DATE,
  mailed_dt                 DATE,
  return_dt                 DATE,
  return_reason             VARCHAR2(100),
  reject_reason             VARCHAR2(100),
  error_reason              VARCHAR2(100),
  transmit_file_name        VARCHAR2(100),
  transmit_file_dt          DATE,
  letter_resp_file_name     VARCHAR2(100),
  letter_resp_file_dt       DATE,
  last_update_dt            DATE,
  last_update_by_name       VARCHAR2(50),
  newborn_flag              VARCHAR2(1),
  task_id                   NUMBER,
  cancel_dt                 DATE,
  cancel_by                 VARCHAR2(50),
  complete_dt               DATE,
  instance_status           VARCHAR2(10) not null,
  assd_process_letter_req   DATE,
  ased_process_letter_req   DATE,
  assd_transmit             DATE,
  ased_transmit             DATE,
  assd_receive_confirmation DATE,
  ased_receive_confirmation DATE,
  assd_create_route_work    DATE,
  ased_create_route_work    DATE,
  asf_process_letter_req    VARCHAR2(1) not null,
  asf_transmit              VARCHAR2(1) not null,
  asf_receive_confirmation  VARCHAR2(1) not null,
  asf_create_route_work     VARCHAR2(1) not null,
  gwf_valid                 VARCHAR2(1),
  gwf_outcome               VARCHAR2(1),
  gwf_work_required         VARCHAR2(1),
  stg_extract_date          DATE not null,
  stg_last_update_date      DATE not null,
  stage_done_date           DATE,
  updated                   VARCHAR2(1)
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create index CORP_ETL_PROC_LTR_BPM_CANC_DT on CORP_ETL_PROC_LETTERS_WIP_BPM (CANCEL_DT)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_BPM_COMP_DT on CORP_ETL_PROC_LETTERS_WIP_BPM (COMPLETE_DT)
  tablespace MAXDAT_INDX;

create index CORP_ETL_PROC_LTR_BPM_STAT on CORP_ETL_PROC_LETTERS_WIP_BPM (INSTANCE_STATUS)
  tablespace MAXDAT_INDX;

-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_PROC_LETTERS_WIP_BPM
  add constraint CORP_ETL_PROC_LETTERS_WIP_PK primary key (CEPN_ID)
  using index 
  tablespace MAXDAT_INDX;

alter table CORP_ETL_PROC_LETTERS_WIP_BPM
  add constraint CORP_ETL_PROC_LTR_BPM_ID unique (LETTER_REQUEST_ID)
  using index 
  tablespace MAXDAT_INDX;

-- Grant/Revoke object privileges 
grant select on CORP_ETL_PROC_LETTERS_WIP_BPM to MAXDAT_READ_ONLY;


-- LETTERS_STG
create table LETTERS_STG
(
  letter_id               NUMBER(18) not null,
  letter_requested_on     DATE,
  letter_status_cd        VARCHAR2(32),
  letter_status           VARCHAR2(32),
  letter_create_ts        DATE,
  letter_update_ts        DATE,
  letter_sent_on          DATE,
  program_code            VARCHAR2(32),
  program                 VARCHAR2(50),
  driver_table_name       VARCHAR2(60),
  letter_mailed_date      DATE,
  letter_reject_reason_cd VARCHAR2(32),
  letter_reject_reason    VARCHAR2(100),
  letter_printed_on       DATE,
  letter_error_codes      VARCHAR2(4000),
  residence_county        VARCHAR2(64),
  residence_zip_code      VARCHAR2(32),
  letter_case_id          NUMBER(18),
  letter_parent_lmreq_id  NUMBER(18),
  letter_ref_type         VARCHAR2(40),
  letter_type_cd          VARCHAR2(40),
  letter_type             VARCHAR2(100),
  letter_request_type     VARCHAR2(2),
  letter_lang_cd          VARCHAR2(32),
  language                VARCHAR2(20),
  letter_driver_type      VARCHAR2(4),
  let_material_request_id NUMBER(18),
  letter_created_by       VARCHAR2(80),
  letter_return_reason_cd VARCHAR2(32),
  return_reason           VARCHAR2(100),
  letter_updated_by       VARCHAR2(80),
  letter_return_date      DATE
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create index LETTERS_ID_STG_IDX on LETTERS_STG (LETTER_ID)
  tablespace MAXDAT_INDX;

create index LETTERS_REQUEST_TYPE_STG_IDX on LETTERS_STG (LETTER_REQUEST_TYPE)
  tablespace MAXDAT_INDX;

create index LETTERS_SENT_ON_STG_IDX on LETTERS_STG (LETTER_SENT_ON)
  tablespace MAXDAT_INDX;

create index LETTERS_STG_IDX on LETTERS_STG (LETTER_TYPE_CD, LETTER_ID)
  tablespace MAXDAT_INDX;

create index LETTERS_TYPE_CD_STG_IDX on LETTERS_STG (LETTER_TYPE_CD)
  tablespace MAXDAT_INDX;

create index LETTER_CASE_ID_IDX on LETTERS_STG (LETTER_CASE_ID)
  tablespace MAXDAT_DATA;

create index LETTER_REQ_ON_IDX on LETTERS_STG (LETTER_REQUESTED_ON)
  tablespace MAXDAT_DATA;

-- Grant/Revoke object privileges 
grant select on LETTERS_STG to MAXDAT_READ_ONLY;


