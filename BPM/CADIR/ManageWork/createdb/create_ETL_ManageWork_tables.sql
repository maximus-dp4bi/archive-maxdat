-- Create  all Mange Work Corp Tables 
create table CORP_ETL_MANAGE_WORK
(
  cemw_id                NUMBER not null,
  asf_cancel_work        VARCHAR2(1) default 'N' not null,
  asf_complete_work      VARCHAR2(1) default 'N' not null,
  age_in_business_days   NUMBER default 0 not null,
  age_in_calendar_days   NUMBER default 0 not null,
  cancel_work_date       DATE,
  cancel_work_flag       VARCHAR2(1) default 'N' not null,
  complete_date          DATE,
  complete_flag          VARCHAR2(1) default 'N' not null,
  create_date            DATE not null,
  created_by_name        VARCHAR2(100),
  escalated_flag         VARCHAR2(1) default 'N' not null,
  escalated_to_name      VARCHAR2(100),
  forwarded_by_name      VARCHAR2(100),
  forwarded_flag         VARCHAR2(1) default 'N' not null,
  group_name             VARCHAR2(100),
  group_parent_name      VARCHAR2(100),
  group_supervisor_name  VARCHAR2(100),
  jeopardy_flag          VARCHAR2(1) default 'N' not null,
  last_update_by_name    VARCHAR2(100),
  last_update_date       DATE not null,
  owner_name             VARCHAR2(100),
  sla_days               NUMBER,
  sla_days_type          VARCHAR2(1),
  sla_jeopardy_days      NUMBER,
  sla_target_days        NUMBER,
  source_reference_id    INTEGER,
  source_reference_type  VARCHAR2(30),
  status_age_in_bus_days NUMBER default 0 not null,
  status_age_in_cal_days NUMBER default 0 not null,
  status_date            DATE not null,
  task_id                NUMBER not null,
  task_status            VARCHAR2(50) not null,
  task_type              VARCHAR2(100) not null,
  team_name              VARCHAR2(100),
  team_parent_name       VARCHAR2(100),
  team_supervisor_name   VARCHAR2(100),
  timeliness_status      VARCHAR2(20) default 'Not Complete' not null,
  unit_of_work           VARCHAR2(30),
  stg_extract_date       DATE default SYSDATE not null,
  stg_last_update_date   DATE default SYSDATE not null,
  stage_done_date        DATE,
  date_today             DATE,
  case_id                NUMBER(18),
  client_id              NUMBER(18),
  cancel_method          VARCHAR2(50),
  cancel_reason          VARCHAR2(256),
  cancel_by              VARCHAR2(50),
  task_priority          VARCHAR2(50),
  parent_task_id         number,
  channel                varchar2(20),
  instance_status        varchar2(20),
  instance_start_date    date,
  instance_end_date      date,
  received_date          date,
  assigned_date          date,
  original_creation_date date,
  case_number            varchar2(100)
)
tablespace MAXDAT_DATA;


-- Create/Recreate indexes 
create unique index  CORP_ETL_MANAGE_WORK_IX1 on  CORP_ETL_MANAGE_WORK (TASK_ID)  tablespace MAXDAT_INDX;
create index IDX_MANAGE_WORK_CASE_ID on CORP_ETL_MANAGE_WORK (case_id) TABLESPACE  MAXDAT_INDX ;
create index IDX_MANAGE_WORK_CLIENT_ID on CORP_ETL_MANAGE_WORK (client_id) TABLESPACE  MAXDAT_INDX ;

-- Create/Recreate primary, unique and foreign key constraints 
alter table  CORP_ETL_MANAGE_WORK  add primary key (CEMW_ID)  using index   tablespace MAXDAT_INDX;

-- Create/Recreate check constraints 
alter table  CORP_ETL_MANAGE_WORK  add constraint CHECK_ASF_CANCEL_WORK
  check (ASF_CANCEL_WORK             IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_ASF_COMPLETE_WORK
  check (ASF_COMPLETE_WORK         IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_CANCEL_WORK_FLAG
  check (CANCEL_WORK_FLAG           IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_COMPLETE_FLAG
  check (COMPLETE_FLAG                 IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_ESCALATED_FLAG
  check (ESCALATED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_FORWARDED_FLAG
  check (FORWARDED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_JEOPARDY_FLAG
  check (JEOPARDY_FLAG                 IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_SLA_DAYS_TYPE
  check (SLA_DAYS_TYPE                 IN ('B','C',NULL));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_SOURCE_REFERENCE_TYPE
  check (SOURCE_REFERENCE_TYPE IN('Application ID','Document ID','Document Set ID','Image ID','Case ID','Client ID','Call ID','Incident ID',NULL));
alter table  CORP_ETL_MANAGE_WORK   add constraint CHECK_TIMELINESS_STATUS
  check (TIMELINESS_STATUS         IN ('Timely','Untimely','Not Required','Not Complete'));

Grant select on CORP_ETL_MANAGE_WORK to MAXDAT_READ_ONLY;


create table  CORP_ETL_MANAGE_WORK_TMP
(
  cemw_id                NUMBER,
  asf_cancel_work        VARCHAR2(1),
  asf_complete_work      VARCHAR2(1),
  age_in_business_days   NUMBER,
  age_in_calendar_days   NUMBER,
  cancel_work_date       DATE,
  cancel_work_flag       VARCHAR2(1),
  complete_date          DATE,
  complete_flag          VARCHAR2(1),
  create_date            DATE,
  created_by_name        VARCHAR2(100),
  escalated_flag         VARCHAR2(1),
  escalated_to_name      VARCHAR2(100),
  forwarded_by_name      VARCHAR2(100),
  forwarded_flag         VARCHAR2(1),
  group_name             VARCHAR2(100),
  group_parent_name      VARCHAR2(100),
  group_supervisor_name  VARCHAR2(100),
  jeopardy_flag          VARCHAR2(1),
  last_update_by_name    VARCHAR2(100),
  last_update_date       DATE,
  owner_name             VARCHAR2(100),
  sla_days               NUMBER,
  sla_days_type          VARCHAR2(1),
  sla_jeopardy_days      NUMBER,
  sla_target_days        NUMBER,
  source_reference_id    INTEGER,
  source_reference_type  VARCHAR2(30),
  status_age_in_bus_days NUMBER,
  status_age_in_cal_days NUMBER,
  status_date            DATE,
  task_id                NUMBER,
  task_status            VARCHAR2(50),
  task_type              VARCHAR2(100),
  team_name              VARCHAR2(100),
  team_parent_name       VARCHAR2(100),
  team_supervisor_name   VARCHAR2(100),
  timeliness_status      VARCHAR2(20),
  unit_of_work           VARCHAR2(30),
  stg_extract_date       DATE,
  stg_last_update_date   DATE,
  stage_done_date        DATE,
  date_today             DATE,
  case_id                NUMBER(18),
  client_id              NUMBER(18),
  cancel_method          VARCHAR2(50),
  cancel_reason          VARCHAR2(256),
  cancel_by              VARCHAR2(50),
  task_priority          VARCHAR2(50),
  parent_task_id         number,
  channel                varchar2(20),
  instance_status        varchar2(20),
  instance_start_date    date,
  instance_end_date      date,
  received_date          date,
  assigned_date          date,
  original_creation_date date,
  case_number            varchar2(100),
  updated                varchar2(1)
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create unique index  CORP_ETL_MANAGE_WORK_TMP_IX1 on  CORP_ETL_MANAGE_WORK_TMP (TASK_ID)  tablespace MAXDAT_INDX;
create unique index  CORP_ETL_MANAGE_WORK_TMP_IX2 on  CORP_ETL_MANAGE_WORK_TMP (CEMW_ID)  tablespace MAXDAT_INDX;
create index IDX_MANAGE_WORK_TMP_CASE_ID          on CORP_ETL_MANAGE_WORK_TMP (case_id)   TABLESPACE MAXDAT_INDX;
create index IDX_MANAGE_WORK_TMP_CLIENT_ID        on CORP_ETL_MANAGE_WORK_TMP (client_id) TABLESPACE MAXDAT_INDX;

grant select on  CORP_ETL_MANAGE_WORK_TMP to MAXDAT_READ_ONLY;
