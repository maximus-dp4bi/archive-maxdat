DROP TABLE QC_REVIEW_QUESTION_ANSWER;
create table maxdat.QC_REVIEW_QUESTION_ANSWER
(
  survey_id                   NUMBER(18) not null,
  survey_template_id          INTEGER,
  survey_template_group_id    NUMBER(18),
  survey_template_question_id NUMBER(18) not null,
  survey_status_cd            VARCHAR2(64),
  survey_status_date          DATE,
  completed_date              date,
  complete_flag               number(1),
  qc_type                     VARCHAR2(105),
  sort_order                  NUMBER(10),
  group_sort_order            number(10),
  question_number             number(10),
  svey_tmpl_question_text_id  NUMBER(18),
  question_text               VARCHAR2(4000),
  comment_enabled_ind         NUMBER(1),
  parent_template_question_id NUMBER(18),
  conditional_answer_id       NUMBER(18),
  survey_template_status_cd   VARCHAR2(64),
  title                       VARCHAR2(256),
  group_text                  VARCHAR2(4000),
  survey_template_category_cd VARCHAR2(64),
  survey_answer_text          VARCHAR2(4000),
  survey_answer_comments      VARCHAR2(4000),
  survey_response_created_by  VARCHAR2(80),
  survey_response_create_ts   DATE,
  survey_response_updated_by  VARCHAR2(80),
  survey_response_update_ts   DATE,
  challenge_reason            VARCHAR2(80),
  challenge_reason_comment    VARCHAR2(4000),
  challenge_outcome           VARCHAR2(80),
  challenge_findings          VARCHAR2(4000),
  challenge_this_question     VARCHAR2(1),
  survey_answer_score         NUMBER,
  survey_template_answer_id   NUMBER,
  rqa_create_ts               date,
  rqa_created_by              varchar2(80),
  rqa_update_ts               date,
  rqa_updated_by              varchar2(80)
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
  
alter table MAXDAT.QC_REVIEW_QUESTION_ANSWER
  add constraint XPKRQA primary key (SURVEY_ID, survey_template_id, survey_template_group_id, survey_template_question_id)
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

 grant select on   QC_REVIEW_QUESTION_ANSWER to MAXDAT_READ_ONLY;  
