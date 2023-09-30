-- Create table
create table STAFF_STG
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
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

