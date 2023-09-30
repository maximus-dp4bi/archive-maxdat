create table SVEY_TMPL_ANSWER_TEXT_DEL
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

  create table maxdat.SVEY_TMPL_QUESTION_TEXT_DEL
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

grant select on   SVEY_TMPL_ANSWER_TEXT_DEL to MAXDAT_READ_ONLY;
grant select on   SVEY_TMPL_QUESTION_TEXT_DEL to MAXDAT_READ_ONLY;
