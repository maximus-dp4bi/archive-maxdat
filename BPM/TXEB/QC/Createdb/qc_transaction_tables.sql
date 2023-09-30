-- Create table
create table MAXDAT.SURVEY
(
  survey_id          NUMBER(18) not null,
  ref1_value         VARCHAR2(32),
  ref2_value         VARCHAR2(32),
  ref3_value         VARCHAR2(32),
  ref4_value         VARCHAR2(32),
  ref5_value         VARCHAR2(32),
  ref6_value         VARCHAR2(32),
  client_id          NUMBER(18),
  case_id            NUMBER(18),
  comments           VARCHAR2(4000),
  survey_template_id NUMBER(18),
  status_cd          VARCHAR2(64),
  status_date        DATE,
  followup_days      NUMBER(18),
  refuse_reason_cd   VARCHAR2(64),
  refuse_reason_text VARCHAR2(4000),
  language_cd        VARCHAR2(32),
  received_via_cd    VARCHAR2(30),
  received_date      DATE,
  created_by         VARCHAR2(80),
  create_ts          DATE,
  updated_by         VARCHAR2(80),
  update_ts          DATE
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
alter table MAXDAT.SURVEY
  add constraint XPKSURVEY primary key (SURVEY_ID)
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
alter index MAXDAT.XPKSURVEY nologging;
alter table MAXDAT.SURVEY
  add constraint FK_SURVEY_1 foreign key (SURVEY_TEMPLATE_ID)
  references MAXDAT.SURVEY_TEMPLATE (SURVEY_TEMPLATE_ID)
  disable
  novalidate;
alter table MAXDAT.SURVEY
  add constraint FK_SURVEY_2 foreign key (STATUS_CD)
  references MAXDAT.ENUM_SURVEY_STATUS (VALUE);
alter table MAXDAT.SURVEY
  add constraint FK_SURVEY_3 foreign key (REFUSE_REASON_CD)
  references MAXDAT.ENUM_SURVEY_REFUSE_REASON (VALUE);
-- Grant/Revoke object privileges 
grant select on   SURVEY to MAXDAT_READ_ONLY;

create table maxdat.SURVEY_HEADER_INFO
(
  survey_header_info_id NUMBER(18) not null,
  supervisor_id         NUMBER(18),
  review_date           DATE,
  created_by            VARCHAR2(80),
  create_ts             DATE,
  updated_by            VARCHAR2(80),
  update_ts             DATE,
  id_num                VARCHAR2(80),
  survey_id             NUMBER(18),
  agent_id              NUMBER(18),
  date_of_call          DATE,
  medicaid_chip_id      NUMBER(9),
  CISCO_AGENT_ID	VARCHAR2(80),
  CLIENT_PROGRAM	VARCHAR2(80),
  CALL_TYPE	VARCHAR2(80),
  CALL_DURATION	NUMBER(8,0),
  CALIBRATION	VARCHAR2(1),
  BRIEF_CALL_SUMMARY	VARCHAR2(4000),
  ERROR_COMMENT	VARCHAR2(4000),
  SUPPORTING_DOCUMENTATION	VARCHAR2(4000),
  CHALLENGE_TYPE	VARCHAR2(80),
  TRACKING_DATE	DATE
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
-- Create/Recreate indexes 
create unique index SURVEY_HEADER_INFO_PK on maxdat.SURVEY_HEADER_INFO (SURVEY_HEADER_INFO_ID, AGENT_ID, SURVEY_ID)
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
  
grant select on   SURVEY_HEADER_INFO to MAXDAT_READ_ONLY;

create table maxdat.SURVEY_HEADER_INFO_HIST
(
  survey_header_info_hist_id NUMBER(18) not null,
  survey_id                  NUMBER(18),
  agent_id                   NUMBER(18),
  agent_name                 VARCHAR2(80),
  reviewer_name              VARCHAR2(80),
  supervisor_name            VARCHAR2(80),
  date_of_call               DATE,
  review_date                DATE,
  id_num                     VARCHAR2(80),
  created_by                 VARCHAR2(80),
  create_ts                  DATE,
  medicaid_chip_id           NUMBER(9),
  CISCO_AGENT_ID	VARCHAR2(80),
  CLIENT_PROGRAM	VARCHAR2(80),
  CALL_TYPE	VARCHAR2(80),
  CALL_DURATION	NUMBER(8,0),
  CALIBRATION	VARCHAR2(1),
  BRIEF_CALL_SUMMARY	VARCHAR2(4000),
  ERROR_COMMENT	VARCHAR2(4000),
  SUPPORTING_DOCUMENTATION	VARCHAR2(4000),
  CHALLENGE_TYPE	VARCHAR2(80),
  TRACKING_DATE	DATE  
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
-- Create/Recreate indexes 
create unique index MAXDAT.SURVEY_HEADER_INFO_HIST_PK on MAXDAT.SURVEY_HEADER_INFO_HIST (SURVEY_ID, SURVEY_HEADER_INFO_HIST_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table maxdat.SURVEY_HEADER_INFO_HIST
  add constraint FK_SURVEY_HEADER_INFO_HIST_1 foreign key (SURVEY_ID)
  references maxdat.SURVEY (SURVEY_ID);

grant select on   SURVEY_HEADER_INFO_HIST to MAXDAT_READ_ONLY;

create table maxdat.SURVEY_SCORE
(
  survey_score_id          NUMBER(18),
  survey_id                NUMBER(18),
  survey_template_group_id NUMBER(18),
  created_by               VARCHAR2(80),
  create_ts                DATE,
  updated_by               VARCHAR2(80),
  update_ts                DATE,
  survey_score             NUMBER(18,2)
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
-- Create/Recreate indexes 
create unique index maxdat.SURVEY_SCORE_PK on MAXDAT.SURVEY_SCORE (SURVEY_SCORE_ID, SURVEY_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table maxdat.SURVEY_SCORE
  add constraint FK_SURVEY_SCORE_1 foreign key (SURVEY_ID)
  references maxdat.SURVEY (SURVEY_ID);
alter table maxdat.SURVEY_SCORE
  add constraint FK_SURVEY_TEMPLATE_GROUP_ID_1 foreign key (SURVEY_TEMPLATE_GROUP_ID)
  references maxdat.SURVEY_TEMPLATE_GROUP (SURVEY_TEMPLATE_GROUP_ID);
-- Grant/Revoke object privileges 

grant select on   SURVEY_SCORE to MAXDAT_READ_ONLY;

create table maxdat.SURVEY_SCORE_HIST
(
  survey_score_hist_id     NUMBER(18) not null,
  survey_id                NUMBER(18),
  survey_template_group_id NUMBER(18),
  created_by               VARCHAR2(80),
  create_ts                DATE,
  survey_score             NUMBER(18,2)
)
tablespace MAXDAT_indx
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
alter table MAXDAT.SURVEY_SCORE_HIST
  add constraint FK_SURVEY_SCORE_HIST_1 foreign key (SURVEY_ID)
  references MAXDAT.SURVEY (SURVEY_ID);
alter table MAXDAT.SURVEY_SCORE_HIST
  add constraint FK_SVEY_TMPL_GRP_ID_1 foreign key (SURVEY_TEMPLATE_GROUP_ID)
  references MAXDAT.SURVEY_TEMPLATE_GROUP (SURVEY_TEMPLATE_GROUP_ID);
-- Grant/Revoke object privileges 

grant select on   SURVEY_SCORE_HIST to MAXDAT_READ_ONLY;

create table MAXDAT.SURVEY_RESPONSE
(
  survey_response_id        NUMBER(18) not null,
  survey_id                 NUMBER(18),
  template_question_id      NUMBER(18),
  answer_text               VARCHAR2(4000),
  survey_template_answer_id NUMBER(18),
  comments                  VARCHAR2(4000),
  additional_text           VARCHAR2(4000),
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
    next 8M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index MAXDAT.SUR_RESP_SUVY_ID on MAXDAT.SURVEY_RESPONSE (SURVEY_ID)
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
alter table MAXDAT.SURVEY_RESPONSE
  add constraint XPKSURVEY_RESPONSE primary key (SURVEY_RESPONSE_ID)
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
alter index MAXDAT.XPKSURVEY_RESPONSE nologging;
alter table MAXDAT.SURVEY_RESPONSE
  add constraint FK_SURVEY_RESPONSE_1 foreign key (SURVEY_ID)
  references MAXDAT.SURVEY (SURVEY_ID);
alter table MAXDAT.SURVEY_RESPONSE
  add constraint FK_SURVEY_RESPONSE_2 foreign key (SURVEY_TEMPLATE_ANSWER_ID)
  references MAXDAT.SURVEY_TEMPLATE_ANSWER (SURVEY_TEMPLATE_ANSWER_ID);
-- Grant/Revoke object privileges 

grant select on   SURVEY_RESPONSE to MAXDAT_READ_ONLY;

create table MAXDAT.SURVEY_RESPONSE_HIST
(
  survey_response_hist_id   NUMBER(18) not null,
  survey_id                 NUMBER(18),
  template_question_id      NUMBER(18),
  survey_template_answer_id NUMBER(18),
  answer_text               VARCHAR2(4000),
  comments                  VARCHAR2(4000),
  additional_text           VARCHAR2(4000),
  created_by                VARCHAR2(80),
  create_ts                 DATE
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
-- Create/Recreate indexes 
create unique index MAXDAT.SURVEY_RESPONSE_HIST_PK on MAXDAT.SURVEY_RESPONSE_HIST (SURVEY_ID, SURVEY_RESPONSE_HIST_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.SURVEY_RESPONSE_HIST
  add constraint FK_SURVEY_RESPONSE_HIST_1 foreign key (SURVEY_ID)
  references MAXDAT.SURVEY (SURVEY_ID);
alter table MAXDAT.SURVEY_RESPONSE_HIST
  add constraint FK_SURVEY_RESPONSE_HIST_2 foreign key (SURVEY_TEMPLATE_ANSWER_ID)
  references MAXDAT.SURVEY_TEMPLATE_ANSWER (SURVEY_TEMPLATE_ANSWER_ID);
alter table MAXDAT.SURVEY_RESPONSE_HIST
  add constraint FK_SURVEY_RESPONSE_HIST_3 foreign key (TEMPLATE_QUESTION_ID)
  references MAXDAT.SURVEY_TEMPLATE_QUESTION (SURVEY_TEMPLATE_QUESTION_ID);
-- Grant/Revoke object privileges 

grant select on   SURVEY_RESPONSE_HIST to MAXDAT_READ_ONLY;

create table MAXDAT.SURVEY_STATUS_HISTORY
(
  survey_status_history_id NUMBER(18) not null,
  survey_id                NUMBER(18),
  status_cd                VARCHAR2(64),
  creation_date            DATE,
  updated_by               VARCHAR2(80),
  update_ts                DATE,
  created_by               VARCHAR2(80)
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
-- Create/Recreate indexes 
create unique index MAXDAT.SURVEY_STATUS_HISTORY_PK on MAXDAT.SURVEY_STATUS_HISTORY (SURVEY_ID, SURVEY_STATUS_HISTORY_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.SURVEY_STATUS_HISTORY
  add constraint XPKSURVEY_STATUS_HISTORY primary key (SURVEY_STATUS_HISTORY_ID)
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
alter index MAXDAT.XPKSURVEY_STATUS_HISTORY nologging;
alter table MAXDAT.SURVEY_STATUS_HISTORY
  add constraint FK_SURVEY_STATUS_HISTORY_1 foreign key (SURVEY_ID)
  references MAXDAT.SURVEY (SURVEY_ID);
alter table MAXDAT.SURVEY_STATUS_HISTORY
  add constraint FK_SURVEY_STATUS_HISTORY_2 foreign key (STATUS_CD)
  references MAXDAT.ENUM_SURVEY_STATUS (VALUE);
-- Grant/Revoke object privileges 

grant select on   SURVEY_STATUS_HISTORY to MAXDAT_READ_ONLY;
