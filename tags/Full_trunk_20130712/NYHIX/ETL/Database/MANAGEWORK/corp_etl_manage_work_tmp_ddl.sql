-- Create table
create table  CORP_ETL_MANAGE_WORK_TMP
(
  cemw_id                NUMBER,
  asf_cancel_work        VARCHAR2(1) not null,
  asf_complete_work      VARCHAR2(1) not null,
  age_in_business_days   NUMBER not null,
  age_in_calendar_days   NUMBER not null,
  cancel_work_date       DATE,
  cancel_work_flag       VARCHAR2(1) not null,
  complete_date          DATE,
  complete_flag          VARCHAR2(1) not null,
  create_date            DATE not null,
  created_by_name        VARCHAR2(100),
  escalated_flag         VARCHAR2(1) not null,
  escalated_to_name      VARCHAR2(100),
  forwarded_by_name      VARCHAR2(100),
  forwarded_flag         VARCHAR2(1) not null,
  group_name             VARCHAR2(100),
  group_parent_name      VARCHAR2(100),
  group_supervisor_name  VARCHAR2(100),
  jeopardy_flag          VARCHAR2(1) not null,
  last_update_by_name    VARCHAR2(100),
  last_update_date       DATE not null,
  owner_name             VARCHAR2(100),
  sla_days               NUMBER,
  sla_days_type          VARCHAR2(1),
  sla_jeopardy_days      NUMBER,
  sla_target_days        NUMBER,
  source_reference_id    INTEGER,
  source_reference_type  VARCHAR2(30),
  status_age_in_bus_days NUMBER not null,
  status_age_in_cal_days NUMBER not null,
  status_date            DATE not null,
  task_id                NUMBER not null,
  task_status            VARCHAR2(50) not null,
  task_type              VARCHAR2(100) not null,
  team_name              VARCHAR2(100),
  team_parent_name       VARCHAR2(100),
  team_supervisor_name   VARCHAR2(100),
  timeliness_status      VARCHAR2(20) not null,
  unit_of_work           VARCHAR2(30),
  stg_extract_date       DATE not null,
  stg_last_update_date   DATE not null,
  stage_done_date        DATE,
  date_today             DATE,
  case_id                NUMBER(18),
  client_id              NUMBER(18),
  cancel_method          VARCHAR2(50),
  cancel_reason          VARCHAR2(256),
  cancel_by              VARCHAR2(50),
  task_priority               VARCHAR2(50)
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
create unique index  CORP_ETL_MANAGE_WORK_TMP_IX1 on  CORP_ETL_MANAGE_WORK_TMP (TASK_ID)
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
create unique index  CORP_ETL_MANAGE_WORK_TMP_IX2 on  CORP_ETL_MANAGE_WORK_TMP (CEMW_ID)
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
  
create index IDX_MANAGE_WORK_TMP_CASE_ID on CORP_ETL_MANAGE_WORK_TMP (case_id) TABLESPACE  MAXDAT_INDX ;
create index IDX_MANAGE_WORK_TMP_CLIENT_ID on CORP_ETL_MANAGE_WORK_TMP (client_id) TABLESPACE  MAXDAT_INDX ;

-- Grant/Revoke object privileges 
grant select on  CORP_ETL_MANAGE_WORK_TMP to MAXDAT_READ_ONLY;
