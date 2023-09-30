create table maxdat.SURVEY_TEMPLATE_CONTEXT
(
  survey_template_context_id NUMBER(18) not null,
  survey_template_id         NUMBER(18),
  ref_type                   VARCHAR2(100),
  ref_id                     VARCHAR2(100),
  required_ind               NUMBER(1),
  created_by                 VARCHAR2(80),
  create_ts                  DATE,
  updated_by                 VARCHAR2(80),
  update_ts                  DATE
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
  )
nologging;

alter table maxdat.SURVEY_TEMPLATE_CONTEXT
  add constraint SURVEY_TEMPLATE_CONTEXT_PK primary key (SURVEY_TEMPLATE_CONTEXT_ID)
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

alter index maxdat.SURVEY_TEMPLATE_CONTEXT_PK nologging;
alter table maxdat.SURVEY_TEMPLATE_CONTEXT
  add constraint SURVEY_TEMPLATE_CONTEXT_FK foreign key (SURVEY_TEMPLATE_ID)
  references maxdat.SURVEY_TEMPLATE (SURVEY_TEMPLATE_ID) on delete set null;

grant select on SURVEY_TEMPLATE_CONTEXT to MAXDAT_READ_ONLY;
grant select on SURVEY_TEMPLATE_CONTEXT to maxdat_reports;
