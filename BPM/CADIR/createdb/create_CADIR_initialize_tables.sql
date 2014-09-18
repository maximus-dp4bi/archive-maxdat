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

CREATE TABLE CADIR_MAXDAT_STG (
   ID                      NUMBER
 , C_ASSIGNMENT_FROM       NUMBER
 , C_ASSIGNMENT_TO         NUMBER
 , C_CREATED_BY            NUMBER
 , C_CREATED_ON            DATE
 , ASSIGNMENT_ID           NUMBER
 , DATA_OBJECT_KEY         VARCHAR2(10)
 , TRACKING_ID             NUMBER
 , SUBJECT_TYPE            NUMBER
 , SUBJECT_ID              NUMBER
 , ROLE_ID                 NUMBER
 , IS_CURRENT              NUMBER
 , IS_DELEGATE             NUMBER
 , IS_CREATOR              NUMBER
 , ASSIGNMENT_DATE         DATE
 , DESCRIPTION             VARCHAR2(200)
 , STG_EXTRACT_DATE        DATE          DEFAULT SYSDATE
 , STG_LAST_UPDATE_DATE    DATE          DEFAULT SYSDATE
 , PREVIOUS_ASSIGNMENT_ID  NUMBER
 , C_ASSIGNED_DATE         DATE
 , C_RECEIVED_DATE         DATE
 , C_CASE_NUMBER           VARCHAR2(100)
 , C_CLAIM_TYPE0           NUMBER
)
tablespace MAXDAT_DATA;

  alter table CADIR_MAXDAT_STG add constraint CMAX_STG_PK primary key (ID)
  using index tablespace MAXDAT_INDX;


Grant select on CADIR_MAXDAT_STG to MAXDAT_READ_ONLY;


CREATE TABLE CADIR_PERSON_STG (
   PERSON_ID    NUMBER
 , FIRST_NAME   VARCHAR2(50)
 , LAST_NAME    VARCHAR2(50)
 , MIDDLE_NAME  VARCHAR2(50)
 , NAME_TITLE   VARCHAR2(50)
 , NAME_SUFFIX  VARCHAR2(50)
)
tablespace MAXDAT_DATA;

Grant select on CADIR_PERSON_STG to MAXDAT_READ_ONLY;


CREATE TABLE CADIR_ROLE_STG  (
   ROLE_ID       NUMBER
 , NAME          VARCHAR2(50)
 , DESCRIPTION   VARCHAR2(200)
 , BUSINESS_KEY  VARCHAR2(50)
)
tablespace MAXDAT_DATA;

Grant select on CADIR_ROLE_STG  to MAXDAT_READ_ONLY;


CREATE TABLE CADIR_USER_STG (
   USER_ID                NUMBER
 , LOCKED                 NUMBER
 , USERNAME               VARCHAR2(50)
 , ACC_ENHANCE            NUMBER
 , PERSON_ID              NUMBER
 , DEFAULT_ROLE_ID        NUMBER
 , DEFAULT_PREFERENCE_ID  NUMBER
 , TYPE_OF_USER           NUMBER
 , AUTHENTICATION_TYPE    NUMBER
)
tablespace MAXDAT_DATA;

Grant select on CADIR_USER_STG to MAXDAT_READ_ONLY;

CREATE TABLE CADIR_CLAIM_TYPE_STG (
   ID              NUMBER
 , C_ACTIVE        NUMBER
 , C_DISPLAY_ORDER NUMBER
 , C_NAME          VARCHAR2(255)
 , C_CODE          VARCHAR2(255)
)
TABLESPACE MAXDAT_DATA;

Grant select on CADIR_USER_STG to MAXDAT_READ_ONLY;

CREATE TABLE CADIR_MANAGEWORK_LOGGING (
   START_DATE DATE
 , END_DATE   DATE
 , MODULE     VARCHAR2(20)
)
TABLESPACE MAXDAT_DATA;

Grant select on CADIR_USER_STG to MAXDAT_READ_ONLY;

