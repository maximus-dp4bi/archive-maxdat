
-- Create table
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table STEP_DEFINITION_STG
  add constraint XPKSTEP_DEFINITION_STG primary key (STEP_DEFINITION_ID)
  using index 
  tablespace MAXDAT_INDX
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
  

