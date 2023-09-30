-- Create table
create table MAXDAT.STEP_INSTANCE_STG
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
  ir_processed             VARCHAR2(1) default 'N'
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
create index MAXDAT.STEP_INS_INDX1 on MAXDAT.STEP_INSTANCE_STG (REF_ID, REF_TYPE, STATUS)
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
create index MAXDAT.STEP_INS_INDX2 on MAXDAT.STEP_INSTANCE_STG (STEP_INSTANCE_ID)
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
create index MAXDAT.STEP_INS_INDX3 on MAXDAT.STEP_INSTANCE_STG (STEP_INSTANCE_HISTORY_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.STEP_INSTANCE_STG
  add constraint STEP_INSTANCE_STG_PK primary key (STEP_INSTANCE_ID, STEP_INSTANCE_HISTORY_ID)
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
-- Grant/Revoke object privileges 
grant select on MAXDAT.STEP_INSTANCE_STG to MAXDAT_READ_ONLY;
