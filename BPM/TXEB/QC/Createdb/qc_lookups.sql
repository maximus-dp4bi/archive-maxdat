create table SVEY_TMPL_GROUP_TEXT
(
  svey_tmpl_group_text_id  NUMBER(18) not null,
  group_text               VARCHAR2(4000),
  language_cd              VARCHAR2(32),
  survey_template_group_id NUMBER(18),
  created_by               VARCHAR2(80),
  create_ts                DATE,
  updated_by               VARCHAR2(80),
  update_ts                DATE
)
tablespace maxdat_DATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table SVEY_TMPL_GROUP_TEXT
  add constraint XPKSVEY_TMPL_GROUP_TEXT primary key (SVEY_TMPL_GROUP_TEXT_ID)
  using index 
  tablespace maxdat_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
  -- Create table
  create table maxdat.SVEY_TMPL_QUESTION_TEXT
  (
    svey_tmpl_question_text_id  NUMBER(18) not null,
    question_text               VARCHAR2(4000),
    language_cd                 VARCHAR2(32),
    survey_template_question_id NUMBER(18),
    created_by                  VARCHAR2(80),
    create_ts                   DATE,
    updated_by                  VARCHAR2(80),
    update_ts                   DATE,
    help_text                   VARCHAR2(4000)
  )
  tablespace maxdat_DATA
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
  -- Create/Recreate primary, unique and foreign key constraints 
  alter table SVEY_TMPL_QUESTION_TEXT
    add constraint XPKSVEY_TMPL_QUESTION_TEXT primary key (SVEY_TMPL_QUESTION_TEXT_ID)
    using index 
    tablespace maxdat_INDX
    pctfree 10
    initrans 2
    maxtrans 255
    storage
    (
      initial 64K
      next 1M
      minextents 1
      maxextents unlimited
    );

create table SVEY_TMPL_ANSWER_TEXT
(
  svey_tmpl_answer_text_id  NUMBER(18) not null,
  answer_text               VARCHAR2(4000),
  language_cd               VARCHAR2(32),
  survey_template_answer_id NUMBER(18),
  created_by                VARCHAR2(80),
  create_ts                 DATE,
  updated_by                VARCHAR2(80),
  update_ts                 DATE
)
tablespace maxdat_DATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table SVEY_TMPL_ANSWER_TEXT
  add constraint XPKSVEY_TMPL_ANSWER_TEXT primary key (SVEY_TMPL_ANSWER_TEXT_ID)
  using index 
  tablespace maxdat_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
grant select on   SVEY_TMPL_ANSWER_TEXT to MAXDAT_READ_ONLY;
grant select on   SVEY_TMPL_QUESTION_TEXT to MAXDAT_READ_ONLY;
grant select on   SVEY_TMPL_GROUP_TEXT to MAXDAT_READ_ONLY;


CREATE TABLE survey_template
(
  SURVEY_TEMPLATE_ID INTEGER
, TITLE VARCHAR2(256)
, DESCRIPTION CLOB
, SURVEY_TEMPLATE_TYPE_CD VARCHAR2(64)
, EFFECTIVE_FROM_DATE DATE
, EFFECTIVE_THRU_DATE DATE
, REF1_TABLE VARCHAR2(32)
, REF2_TABLE VARCHAR2(32)
, REF1_KEY VARCHAR2(32)
, REF2_KEY VARCHAR2(32)
, REF3_TABLE VARCHAR2(32)
, REF3_KEY VARCHAR2(32)
, CREATED_BY VARCHAR2(80)
, CREATE_TS DATE
, UPDATED_BY VARCHAR2(80)
, UPDATE_TS DATE
, REF4_TABLE VARCHAR2(32)
, REF5_TABLE VARCHAR2(32)
, REF6_TABLE VARCHAR2(32)
, REF4_KEY VARCHAR2(32)
, REF5_KEY VARCHAR2(32)
, REF6_KEY VARCHAR2(32)
, PARENT_SURVEY_TEMPLATE_ID INTEGER
, SURVEY_TEMPLATE_CATEGORY_CD VARCHAR2(64)
, SURVEY_TEMPLATE_STATUS_CD VARCHAR2(64)
, FOLLOWUP_DAYS INTEGER
, ACCESS_PERMISSION VARCHAR2(256)
)
tablespace maxdat_DATA
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
;

alter table maxdat.SURVEY_TEMPLATE
  add constraint XPKSURVEY_TEMPLATE primary key (SURVEY_TEMPLATE_ID)
  using index 
  tablespace maxdat_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

grant select on   SURVEY_TEMPLATE to MAXDAT_READ_ONLY;

-- Create table
create table SURVEY_TEMPLATE_ANSWER
(
  survey_template_answer_id   NUMBER(18) not null,
  score                       NUMBER(18),
  survey_template_question_id NUMBER(18),
  other_ind                   NUMBER(1),
  answer_sort_order           NUMBER(10),
  created_by                  VARCHAR2(80),
  create_ts                   DATE,
  updated_by                  VARCHAR2(80),
  update_ts                   DATE
)
tablespace maxdat_DATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table SURVEY_TEMPLATE_ANSWER
  add constraint XPKSURVEY_TEMPLATE_ANSWER primary key (SURVEY_TEMPLATE_ANSWER_ID)
  using index 
  tablespace maxdat_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

grant select on   SURVEY_TEMPLATE_ANSWER to MAXDAT_READ_ONLY;


create table ENUM_SURVEY_REFUSE_REASON
(
  value                VARCHAR2(64) not null,
  description          VARCHAR2(256),
  report_label         VARCHAR2(64),
  scope                VARCHAR2(128),
  created_by           VARCHAR2(80),
  create_ts            DATE,
  updated_by           VARCHAR2(80),
  update_ts            DATE,
  order_by_default     NUMBER(10),
  effective_start_date DATE,
  effective_end_date   DATE
)
tablespace maxdat_DATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table ENUM_SURVEY_REFUSE_REASON
  add constraint XPKENUM_SURVEY_REFUSE_REASON primary key (VALUE)
  using index
  tablespace maxdat_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index XPKENUM_SURVEY_REFUSE_REASON nologging;

grant select on   ENUM_SURVEY_REFUSE_REASON to MAXDAT_READ_ONLY;

create table MAXDAT.ENUM_SURVEY_STATUS
(
  value                VARCHAR2(64) not null,
  description          VARCHAR2(256),
  report_label         VARCHAR2(64),
  scope                VARCHAR2(128),
  created_by           VARCHAR2(80),
  create_ts            DATE,
  updated_by           VARCHAR2(80),
  update_ts            DATE,
  order_by_default     NUMBER(10),
  effective_start_date DATE,
  effective_end_date   DATE
)
tablespace maxdat_data
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.ENUM_SURVEY_STATUS
  add constraint XPKENUM_SURVEY_STATUS primary key (VALUE)
  using index 
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index MAXDAT.XPKENUM_SURVEY_STATUS nologging;
-- Grant/Revoke object privileges 

grant select on   ENUM_SURVEY_STATUS to MAXDAT_READ_ONLY;

create table MAXDAT.SURVEY_TEMPLATE_GROUP
(
  survey_template_group_id NUMBER(18) not null,
  survey_template_id       NUMBER(18),
  sort_order               NUMBER(10),
  created_by               VARCHAR2(80),
  create_ts                DATE,
  updated_by               VARCHAR2(80),
  update_ts                DATE
)
tablespace maxdat_DATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.SURVEY_TEMPLATE_GROUP
  add constraint XPKSURVEY_TEMPLATE_GROUP primary key (SURVEY_TEMPLATE_GROUP_ID)
  using index 
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index MAXDAT.XPKSURVEY_TEMPLATE_GROUP nologging;
alter table MAXDAT.SURVEY_TEMPLATE_GROUP
  add constraint FK_SURVEY_TEMPLATE_GROUP_1 foreign key (SURVEY_TEMPLATE_ID)
  references MAXDAT.SURVEY_TEMPLATE (SURVEY_TEMPLATE_ID)
  disable
  novalidate;
-- Grant/Revoke object privileges 
grant select on   SURVEY_TEMPLATE_GROUP to MAXDAT_READ_ONLY;

-- Create table
create table MAXDAT.SURVEY_TEMPLATE_QUESTION
(
  survey_template_question_id NUMBER(18) not null,
  question_type_cd            VARCHAR2(64),
  answer_type_cd              VARCHAR2(64),
  question_number             VARCHAR2(32),
  sort_order                  NUMBER(10),
  weightage                   VARCHAR2(32),
  survey_template_group_id    NUMBER(18),
  comment_enabled_ind         NUMBER(1),
  parent_template_question_id NUMBER(18),
  conditional_answer_id       NUMBER(18),
  created_by                  VARCHAR2(80),
  create_ts                   DATE,
  updated_by                  VARCHAR2(80),
  update_ts                   DATE,
  survey_template_id          NUMBER(18),
  question_required           NUMBER(1) default 0
)
tablespace maxdat_data
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.SURVEY_TEMPLATE_QUESTION
  add constraint XPKSURVEY_TEMPLATE_QUESTION primary key (SURVEY_TEMPLATE_QUESTION_ID)
  using index 
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index MAXDAT.XPKSURVEY_TEMPLATE_QUESTION nologging;
alter table MAXDAT.SURVEY_TEMPLATE_QUESTION
  add constraint SURVEY_TEMPLATE_QUESTION_UK unique (SURVEY_TEMPLATE_ID, QUESTION_NUMBER)
  using index 
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index MAXDAT.SURVEY_TEMPLATE_QUESTION_UK nologging;
alter table MAXDAT.SURVEY_TEMPLATE_QUESTION
  add constraint FK_SURVEY_TEMPLATE_QUESTION_3 foreign key (SURVEY_TEMPLATE_GROUP_ID)
  references MAXDAT.SURVEY_TEMPLATE_GROUP (SURVEY_TEMPLATE_GROUP_ID);
alter table MAXDAT.SURVEY_TEMPLATE_QUESTION
  add constraint FK_SURVEY_TEMPLATE_QUESTION_4 foreign key (SURVEY_TEMPLATE_ID)
  references MAXDAT.SURVEY_TEMPLATE (SURVEY_TEMPLATE_ID)
  disable
  novalidate;
-- Grant/Revoke object privileges 
grant select on   SURVEY_TEMPLATE_QUESTION to MAXDAT_READ_ONLY;

-- Create table
create table MAXDAT.QC_STAFF
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
  void_ind               NUMBER(1) default 0,
  title                  VARCHAR2(50)
)
tablespace maxdat_data
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
-- Create/Recreate indexes 
create index MAXDAT.STAFF_IDX1 on MAXDAT.QC_STAFF (LAST_NAME, FIRST_NAME, MIDDLE_NAME, SSN)
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
  nologging;
create index MAXDAT.STAFF_IDX3 on MAXDAT.QC_STAFF (EXT_STAFF_NUMBER)
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
  nologging;
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.QC_STAFF
  add constraint XPKSTAFF primary key (STAFF_ID)
  using index 
  tablespace maxdat_indx
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index MAXDAT.XPKSTAFF nologging;

grant select on   QC_STAFF to MAXDAT_READ_ONLY;
