-- Create table

create table TX_ETL_SELECTION_DUAL
(
extract_month		number(6) not null,
 selection_segment_id   NUMBER(18) not null,
  client_id              NUMBER(18),
  program_type_cd        VARCHAR2(32),
  plan_type_cd           VARCHAR2(32),
  start_date             DATE,
  end_date               DATE,
  status_cd              VARCHAR2(32),
  status_date            DATE,
  plan_id                NUMBER(18),
  plan_id_ext            VARCHAR2(30),
  network_id             NUMBER(18),
  provider_id_ext        VARCHAR2(32),
  provider_first_name    VARCHAR2(64),
  provider_middle_name   VARCHAR2(25),
  provider_last_name     VARCHAR2(64),
  choice_reason_cd       VARCHAR2(32),
  disenroll_reason_cd_1  VARCHAR2(32),
  disenroll_reason_cd_2  VARCHAR2(32),
  client_aid_category_cd VARCHAR2(32),
  county_cd              VARCHAR2(32),
  zipcode                VARCHAR2(32),
  created_by             VARCHAR2(80),
  create_ts              DATE,
  updated_by             VARCHAR2(80),
  update_ts              DATE,
  contract_id            NUMBER(18),
  start_nd               NUMBER(8) not null,
  end_nd                 NUMBER(8) not null,
  selection_source_cd    VARCHAR2(32),
  CES_client_elig_status_id NUMBER(18) not null,
  ces_plan_type_cd          VARCHAR2(32),
  ces_elig_status_cd        VARCHAR2(32),
  ces_start_date            DATE,
  ces_end_date              DATE,
  ces_create_ts             DATE,
  ces_created_by            VARCHAR2(80),
  ces_update_ts             DATE,
  ces_updated_by            VARCHAR2(80),
  ces_client_id             NUMBER(18),
  ces_program_cd            VARCHAR2(32) not null,
  ces_sub_status_codes      VARCHAR2(256),
  ces_reasons               VARCHAR2(256),
  ces_mvx_core_reason       VARCHAR2(256),
  ces_debug                 VARCHAR2(2000 CHAR),
  ces_start_ndt             NUMBER(18) not null,
  ces_end_ndt               NUMBER(18) not null,
  ces_disposition_cd        VARCHAR2(32),
  ces_subprogram_type       VARCHAR2(32),
  plan_name           VARCHAR2(64)  
  )
    tablespace MAXDAT_DATA
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 3M
      next 1M
      minextents 1
      maxextents unlimited
      freelists 3
    )
    nologging
    ;

grant select on TX_ETL_SELECTION_DUAL to MAXDAT_READ_ONLY;

create index TX_ETL_SELECTION_DUAL_IDX1 on TX_ETL_SELECTION_DUAL (CLIENT_ID)  tablespace MAXDAT_INDX nologging  ;

create index TX_ETL_SELECTION_DUAL_IDX2 on TX_ETL_SELECTION_DUAL (START_DATE, END_DATE, PLAN_ID_EXT, SELECTION_SOURCE_CD, CREATE_TS)
  tablespace MAXDAT_INDX nologging  ;

create index TX_ETL_SELECTION_DUAL_IDX3 on TX_ETL_SELECTION_DUAL (extract_month, CLIENT_ID)  tablespace MAXDAT_INDX nologging  ;

create index TX_ETL_SELECTION_DUAL_IDX4 on TX_ETL_SELECTION_DUAL (extract_month, START_DATE, END_DATE, PLAN_ID_EXT, SELECTION_SOURCE_CD, CREATE_TS)
  tablespace MAXDAT_INDX nologging  ;

create or replace view Selection_dual_sv as
select * from TX_ETL_SELECTION_DUAL
with read only;


grant select on Selection_dual_sv to MAXDAT_READ_ONLY;
