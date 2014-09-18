-- Create  Common tables for run initialization 
create table GROUPS_STG
(
  group_id            NUMBER(18) not null,
  group_name          VARCHAR2(80),
  description         VARCHAR2(1000),
  parent_group_id     NUMBER(18),
  deployment_name     VARCHAR2(32),
  start_date          DATE,
  end_date            DATE,
  type_cd             VARCHAR2(20),
  supervisor_staff_id NUMBER(18),
  created_by          VARCHAR2(80),
  create_ts           DATE,
  updated_by          VARCHAR2(80),
  update_ts           DATE
)
tablespace MAXDAT_DATA;

alter table GROUPS_STG add constraint GROUP_PK primary key (GROUP_ID)
using index tablespace MAXDAT_INDX;

Grant select on groups_stg to MAXDAT_READ_ONLY;

create table D_STAFF
(
  staff_id               NUMBER(18) not null,
  ext_staff_number       VARCHAR2(80),
  dob                    DATE,
  ssn                    VARCHAR2(30),
  first_name             VARCHAR2(50),
  first_name_canon       VARCHAR2(50),
  first_name_sound_like  VARCHAR2(64),
  gender_cd              VARCHAR2(32),
  start_date             DATE,
  end_date               DATE,
  phone_number           VARCHAR2(20),
  last_name              VARCHAR2(50),
  last_name_canon        VARCHAR2(50),
  last_name_sound_like   VARCHAR2(64),
  created_by             VARCHAR2(80),
  create_ts              DATE,
  updated_by             VARCHAR2(80),
  update_ts              DATE,
  middle_name            VARCHAR2(25),
  middle_name_canon      VARCHAR2(20),
  middle_name_sound_like VARCHAR2(64),
  email                  VARCHAR2(80),
  fax_number             VARCHAR2(32),
  note_refid             NUMBER(18),
  deployment_staff_num   VARCHAR2(80),
  default_group_id       NUMBER(18),
  staff_type_cd          VARCHAR2(20),
  unique_staff_id        VARCHAR2(80),
  void_ind               NUMBER(1) default 0
)
tablespace MAXDAT_DATA;
  
  alter table D_STAFF add constraint D_STAFF_PK primary key (STAFF_ID)
  using index tablespace MAXDAT_INDX;
  
Grant select on D_STAFF to MAXDAT_READ_ONLY;

create table STEP_DEFINITION_STG
(
  step_definition_id  NUMBER(18) not null,
  name                VARCHAR2(100),
  description         VARCHAR2(4000),
  time_to_complete    NUMBER(9),
  time_unit_cd        VARCHAR2(32),
  forwarding_rule_cd  VARCHAR2(32),
  escalation_rule_cd  VARCHAR2(32),
  priority_cd         VARCHAR2(32),
  perform_timeout_ind NUMBER(1),
  step_type_cd        VARCHAR2(32),
  created_by          VARCHAR2(80),
  create_ts           DATE,
  updated_by          VARCHAR2(80),
  update_ts           DATE,
  manual_task_ind     NUMBER(1),
  spring_bean         VARCHAR2(256),
  correlation_parts   VARCHAR2(4000)
)
tablespace MAXDAT_DATA;

alter table STEP_DEFINITION_STG
  add constraint XPKSTEP_DEFINITION_STG primary key (STEP_DEFINITION_ID)
  using index tablespace MAXDAT_INDX;
  
Grant select on step_definition_stg to MAXDAT_READ_ONLY;

create table  STEP_INSTANCE_STG
(
  step_instance_id         NUMBER not null,
  step_instance_history_id NUMBER not null,
  status                   VARCHAR2(32),
  hist_status              VARCHAR2(32),
  create_ts                DATE,
  completed_ts             DATE,
  escalated_ind            NUMBER,
  hist_escalated_ind       NUMBER,
  step_due_ts              DATE,
  forwarded_ind            NUMBER,
  hist_forwarded_ind       NUMBER,
  group_id                 NUMBER,
  hist_group_id            NUMBER,
  team_id                  NUMBER,
  hist_team_id             NUMBER,
  ref_id                   NUMBER,
  ref_type                 VARCHAR2(64),
  step_definition_id       NUMBER,
  created_by               VARCHAR2(80),
  hist_create_by           VARCHAR2(80),
  escalate_to              VARCHAR2(80),
  hist_escalate_to         VARCHAR2(80),
  forwarded_by             VARCHAR2(80),
  hist_forwarded_by        VARCHAR2(80),
  owner                    VARCHAR2(80),
  hist_owner               VARCHAR2(80),
  suspended_ts             DATE,
  hist_create_ts           DATE,
  mw_processed             VARCHAR2(1) default 'N',
  ap_processed             VARCHAR2(1) default 'N',
  mib_processed            VARCHAR2(1) default 'N',
  all_proc_done_date       DATE,
  stage_create_ts          DATE,
  mi_processed             VARCHAR2(1) default 'N',
  sr_processed             VARCHAR2(1) default 'N',
  tp_processed             VARCHAR2(1) default 'N',
  ir_processed             VARCHAR2(1) default 'N',
  case_id                  NUMBER(18),
  client_id                NUMBER(18),
  priority                 VARCHAR2(50),
  process_instance_id	NUMBER,
  process_id		NUMBER,
  stage_update_ts          DATE,
  status_order             INTEGER  -- NYHIX-4273
)
tablespace MAXDAT_DATA;

create index  STEP_INS_INDX1             on STEP_INSTANCE_STG (REF_ID, REF_TYPE, STATUS) TABLESPACE MAXDAT_INDX;
create index  STEP_INS_INDX2             on STEP_INSTANCE_STG (STEP_INSTANCE_ID)         TABLESPACE MAXDAT_INDX;
create index  STEP_INS_INDX3             on STEP_INSTANCE_STG (STEP_INSTANCE_HISTORY_ID) TABLESPACE MAXDAT_INDX;
create index IDX_STEP_INST_STG_case_id   on STEP_INSTANCE_STG (case_id)                  TABLESPACE MAXDAT_INDX;
create index IDX_STEP_INST_STG_client_id on STEP_INSTANCE_STG (client_id)                TABLESPACE MAXDAT_INDX;

alter table  STEP_INSTANCE_STG
  add constraint STEP_INSTANCE_STG_PK primary key (STEP_INSTANCE_ID, STEP_INSTANCE_HISTORY_ID)
  using index tablespace MAXDAT_INDX;

Grant select on step_instance_stg to MAXDAT_READ_ONLY; 

CREATE TABLE GROUP_STEP_DEFINITION_STG
(
  GROUP_STEP_DEFINITION_ID NUMBER(18, 0) NOT NULL 
, EFFECTIVE_START_TS DATE 
, EFFECTIVE_END_TS DATE 
, FORWARDING_RULE_CD VARCHAR2(32 BYTE) 
, ESCALATION_RULE_CD VARCHAR2(32 BYTE) 
, GROUP_ID NUMBER(18, 0) 
, STEP_DEFINITION_ID NUMBER(18, 0) 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
)
tablespace MAXDAT_DATA;

alter table  GROUP_STEP_DEFINITION_STG
  add constraint XPKGROUP_STEP_DEFINITION primary key (GROUP_STEP_DEFINITION_ID)
  using index tablespace MAXDAT_INDX;

Grant select on GROUP_STEP_DEFINITION_STG to MAXDAT_READ_ONLY; 

CREATE TABLE GROUP_STEP_DEFN_DEFAULT_STG
(
  GROUP_STEP_DEFN_DEFAULT_ID NUMBER(18, 0) NOT NULL
, EFFECTIVE_START_TS DATE
, EFFECTIVE_END_TS DATE
, STEP_DEFINITION_ID NUMBER(18, 0)
, GROUP_STEP_DEFINITION_ID NUMBER(18, 0)
)
tablespace MAXDAT_DATA;

alter table  GROUP_STEP_DEFN_DEFAULT_STG
  add constraint XPKGROUP_STEP_DEFN_DEFAULT primary key (GROUP_STEP_DEFN_DEFAULT_ID)
  using index tablespace MAXDAT_INDX;

Grant select on GROUP_STEP_DEFN_DEFAULT_STG to MAXDAT_READ_ONLY; 

Grant select on groups_stg to MAXDAT_READ_ONLY;


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
	LETTER_RETURN_DATE DATE
   )
tablespace MAXDAT_DATA;


CREATE INDEX LETTERS_ID_STG_IDX            ON LETTERS_STG (LETTER_ID)                 TABLESPACE MAXDAT_INDX;
CREATE INDEX LETTERS_REQUEST_TYPE_STG_IDX  ON LETTERS_STG (LETTER_REQUEST_TYPE)       TABLESPACE MAXDAT_INDX;
CREATE INDEX LETTERS_SENT_ON_STG_IDX       ON LETTERS_STG (LETTER_SENT_ON)            TABLESPACE MAXDAT_INDX;
CREATE INDEX LETTERS_STG_IDX               ON LETTERS_STG (LETTER_TYPE_CD, LETTER_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX LETTERS_TYPE_CD_STG_IDX       ON LETTERS_STG (LETTER_TYPE_CD)            TABLESPACE MAXDAT_INDX;


Grant select on LETTERS_STG to MAXDAT_READ_ONLY;

CREATE TABLE client_supplementary_info_stg
(CLIENT_ID	NUMBER(18)
,CASE_CLIENT_ID	NUMBER(18)
,CASE_ID	NUMBER(18)
,CASE_CIN	VARCHAR2(30)
,HOH_ID	NUMBER(18)
,CASE_STATUS	VARCHAR2(2)
,CASE_CLIENT_STATUS	VARCHAR2(2)
,LAST_NAME	VARCHAR2(40)
,LAST_NAME_CANON	VARCHAR2(40)
,LAST_NAME_SOUNDLIKE	VARCHAR2(64)
,FIRST_NAME	VARCHAR2(25)
,FIRST_NAME_CANON	VARCHAR2(25)
,FIRST_NAME_SOUNDLIKE	VARCHAR2(64)
,MIDDLE_INITIAL	VARCHAR2(25)
,CLIENT_CIN	VARCHAR2(30)
,SSN	VARCHAR2(30)
,GENDER_CD	VARCHAR2(32)
,DOB	DATE
,DOB_NUM	NUMBER(8)
,CLIENT_TYPE_CD	VARCHAR2(10)
,ADDR_ID	NUMBER(18)
,ADDR_TYPE_CD	VARCHAR2(32)
,ADDR_COUNTY	VARCHAR2(32)
,ADDR_ZIP	VARCHAR2(32)
,ADDR_ZIP_FOUR	VARCHAR2(4)
,ADDR_ATTN	VARCHAR2(55)
,ADDR_STREET_1	VARCHAR2(55)
,ADDR_STREET_2	VARCHAR2(55)
,ADDR_CITY	VARCHAR2(30)
,ADDR_BAD_DATE	DATE
,ADDR_BAD_DATE_SATISFIED	DATE
,CREATED_BY	VARCHAR2(80)
,CREATE_TS	DATE
,UPDATED_BY	VARCHAR2(80)
,UPDATE_TS	DATE
,CASE_CREATED_BY	VARCHAR2(80)
,CASE_CREATE_TS	DATE
,CASE_UPDATED_BY	VARCHAR2(80)
,CASE_UPDATE_TS	DATE
,PROGRAM_CD	VARCHAR2(32)
,ADDR_STATE_CD	VARCHAR2(20)
,ADDR_COUNTRY	VARCHAR2(20)
,CLNT_GENERIC_FIELD1_DATE	DATE
,CLNT_GENERIC_FIELD2_DATE	DATE
,CLNT_GENERIC_FIELD3_NUM	NUMBER(18)
,CLNT_GENERIC_FIELD4_NUM	NUMBER(18)
,CLNT_GENERIC_FIELD5_TXT	VARCHAR2(256)
,CLNT_GENERIC_FIELD6_TXT	VARCHAR2(256)
,CLNT_GENERIC_FIELD7_TXT	VARCHAR2(256)
,CLNT_GENERIC_FIELD8_TXT	VARCHAR2(256)
,CLNT_GENERIC_FIELD9_TXT	VARCHAR2(256)
,CLNT_GENERIC_FIELD10_TXT	VARCHAR2(256)
,CLNT_GENERIC_REF11_ID	NUMBER(18)
,CLNT_GENERIC_REF12_ID	NUMBER(18)
,SERVICE_AREA VARCHAR2(64)
,ADDR_COUNTY_LABEL VARCHAR2(64)) tablespace MAXDAT_DATA;

alter table CLIENT_SUPPLEMENTARY_INFO_STG add constraint CLIENT_SUPPLEMENTARY_INFO_PK primary key (CLIENT_ID,PROGRAM_CD)
using index tablespace MAXDAT_INDX;
create index  CLNT_SUPPL_INFO_INDX1 on CLIENT_SUPPLEMENTARY_INFO_STG (CASE_ID) tablespace MAXDAT_INDX;
create index  CLNT_SUPPL_INFO_INDX2 on CLIENT_SUPPLEMENTARY_INFO_STG (CLIENT_CIN) tablespace MAXDAT_INDX;

Grant select on CLIENT_SUPPLEMENTARY_INFO_STG to MAXDAT_READ_ONLY;

CREATE TABLE CLIENT_ELIG_STATUS_STG
(CLIENT_ELIG_STATUS_ID  NUMBER(18,0)
,PLAN_TYPE_CD           VARCHAR2(32 BYTE)
,ELIG_STATUS_CD         VARCHAR2(32 BYTE)
,START_DATE             DATE
,END_DATE               DATE
,CREATE_TS              DATE
,CREATED_BY             VARCHAR2(80 BYTE)
,UPDATE_TS              DATE
,UPDATED_BY             VARCHAR2(80 BYTE)
,CLIENT_ID              NUMBER(18,0)
,PROGRAM_CD             VARCHAR2(32 BYTE)
,SUB_STATUS_CODES       VARCHAR2(256 BYTE)
,REASONS                VARCHAR2(256 BYTE)
,MVX_CORE_REASON        VARCHAR2(256 BYTE)
,DEBUG                  VARCHAR2(2000 BYTE)
,START_NDT              NUMBER(18,0)
,END_NDT                NUMBER(18,0)
,DISPOSITION_CD         VARCHAR2(32 BYTE)
,SUBPROGRAM_TYPE        VARCHAR2(32 BYTE)) TABLESPACE MAXDAT_DATA;

alter table CLIENT_ELIG_STATUS_STG add constraint PK_CLNT_ELIG_STAT_ID primary key (CLIENT_ELIG_STATUS_ID)
using index tablespace MAXDAT_INDX;

CREATE INDEX IDX_CL_ELIG_STAT_CLIENT_ID ON CLIENT_ELIG_STATUS_STG (CLIENT_ID) 
  TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX_CL_ELIG_STAT_CREATE_TS ON CLIENT_ELIG_STATUS_STG (CREATE_TS) 
   TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX_CL_ELIG_STAT_UPDATE_TS ON CLIENT_ELIG_STATUS_STG (UPDATE_TS) 
   TABLESPACE MAXDAT_INDX;

Grant select on CLIENT_ELIG_STATUS_STG to MAXDAT_READ_ONLY;
