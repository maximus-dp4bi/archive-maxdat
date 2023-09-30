
-- Create table
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
-- Add comments to the columns 
comment on column CORP_ETL_MANAGE_WORK.cemw_id
  is 'sequence';
comment on column CORP_ETL_MANAGE_WORK.asf_cancel_work
  is 'Indicates if the Cancel Work step in the business process has been completed';
comment on column CORP_ETL_MANAGE_WORK.asf_complete_work
  is 'Indicates if the Complete Work step in the business process has been completed.';
comment on column CORP_ETL_MANAGE_WORK.age_in_business_days
  is 'Number of days from the Create Date to the Complete Date, or to the Current Date for tasks that are not yet complete, excluding weekends and project holidays.';
comment on column CORP_ETL_MANAGE_WORK.age_in_calendar_days
  is 'Number of days from the Creates Date to the Complete Date, or to the current date for tasks that are not yet complete.';
comment on column CORP_ETL_MANAGE_WORK.cancel_work_date
  is 'Indicates the date the ETL discovered that the task was no longer available to be worked.';
comment on column CORP_ETL_MANAGE_WORK.cancel_work_flag
  is 'Indicates if the task is no longer available to be worked (deleted or disregarded).';
comment on column CORP_ETL_MANAGE_WORK.complete_date
  is 'Date the task was completed (worked) in MAXe';
comment on column CORP_ETL_MANAGE_WORK.complete_flag
  is 'Indicates if the task was completed in MAXe';
comment on column CORP_ETL_MANAGE_WORK.create_date
  is 'Date the task was created in MAXe';
comment on column CORP_ETL_MANAGE_WORK.created_by_name
  is 'Name of the staff member that created the task in MAXe.';
comment on column CORP_ETL_MANAGE_WORK.escalated_flag
  is 'Indicates if the task is currently escalated.';
comment on column CORP_ETL_MANAGE_WORK.escalated_to_name
  is 'Name of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MANAGE_WORK.forwarded_by_name
  is 'Name of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MANAGE_WORK.forwarded_flag
  is 'Indicates if the task was forwarded to the current location.';
comment on column CORP_ETL_MANAGE_WORK.group_name
  is 'Name of the MAXe Group to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.group_parent_name
  is 'Name of the MAXe Group identified as the parent group of the MAXe Group to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.group_supervisor_name
  is 'Name of the staff member in MAXe identified as the supervisor of the group to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.jeopardy_flag
  is 'Indicates if the task is in jeopardy based on the SLA Days Type and SLA Jeopardy Days.';
comment on column  CORP_ETL_MANAGE_WORK.last_update_by_name
  is 'Name of the staff member that last claimed, modified, worked, escalated, or forwarded the task in MAXe.';
comment on column  CORP_ETL_MANAGE_WORK.last_update_date
  is 'Date the task was last updated in MAXe';
comment on column  CORP_ETL_MANAGE_WORK.owner_name
  is 'Name of the staff member that owns the task in MAXe.';
comment on column  CORP_ETL_MANAGE_WORK.sla_days
  is 'Age at which time the task is determined to be untimely. If no SLA applies then this value is null.';
comment on column  CORP_ETL_MANAGE_WORK.sla_days_type
  is 'Indicates if the SLA is based on Business Days or Calendar Days. If no SLA applies then this value is null.';
comment on column  CORP_ETL_MANAGE_WORK.sla_jeopardy_days
  is 'Age at which time the task is determined to be in Jeopardy. If no SLA applies then this value is null.';
comment on column  CORP_ETL_MANAGE_WORK.sla_target_days
  is 'Age at which time the task is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.';
comment on column  CORP_ETL_MANAGE_WORK.source_reference_id
  is 'Unique identifier for the item to which this task is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.';
comment on column  CORP_ETL_MANAGE_WORK.source_reference_type
  is 'Indicates the type of Source Reference ID that is being provided.';
comment on column  CORP_ETL_MANAGE_WORK.status_age_in_bus_days
  is 'Number of days from the Status Date to the current date excluding weekends and project holidays for tasks that are not yet complete. Once a task is complete, this value should be 0.';
comment on column  CORP_ETL_MANAGE_WORK.status_age_in_cal_days
  is 'Number of days from the Status Date to the current date for tasks that are not yet complete. Once a task is complete, this value should be 0.';
comment on column  CORP_ETL_MANAGE_WORK.status_date
  is 'Date the Task Status was set in MAXe';
comment on column  CORP_ETL_MANAGE_WORK.task_id
  is 'Unique identifier for the task in MAXe';
comment on column  CORP_ETL_MANAGE_WORK.task_status
  is 'Current status of the task in MAXe indicating if the task is claimed or unclaimed.';
comment on column  CORP_ETL_MANAGE_WORK.task_type
  is 'Indicates the type of work.';
comment on column  CORP_ETL_MANAGE_WORK.team_name
  is 'Name of the MAXe Group identified as the team to which this task is assigned';
comment on column  CORP_ETL_MANAGE_WORK.team_parent_name
  is 'Name of the MAXe Group identified as the parent group of the MAXe Group identified to which this task is assigned.';
comment on column  CORP_ETL_MANAGE_WORK.team_supervisor_name
  is 'Name of the staff member in MAXe identified as the supervisor of the team to which this task is assigned.';
comment on column  CORP_ETL_MANAGE_WORK.timeliness_status
  is 'Indicates if the task was processed timely or untimely based on the SLA Days Type, SLA Days, and Age of task.';
comment on column  CORP_ETL_MANAGE_WORK.unit_of_work
  is 'Indicates the Production Planning Unit of Work to which this task is assigned.';
comment on column  CORP_ETL_MANAGE_WORK.stg_extract_date
  is 'On INSERT only, sets the current system date that the record was created.';
comment on column  CORP_ETL_MANAGE_WORK.stg_last_update_date
  is 'On INSERT or UPDATE, sets the current system date that the record was created or updated.';
comment on column  CORP_ETL_MANAGE_WORK.stage_done_date
  is 'Indicates the date ETL processing stopped for this record.';
comment on column CORP_ETL_MANAGE_WORK.CLIENT_ID is 'Unique identifier associated to the client in MAXe';
comment on column CORP_ETL_MANAGE_WORK.CASE_ID is 'Unique identifier associated to the case in MAXe';
comment on column CORP_ETL_MANAGE_WORK.cancel_by is 'The name of the person or system that cancelled the instance';
comment on column CORP_ETL_MANAGE_WORK.cancel_method is 'The method in which the document instance was cancelled; coule be deleted, trashed by user, or exception';
comment on column CORP_ETL_MANAGE_WORK.cancel_reason is 'The reason that the instance was cancelled';
comment on column CORP_ETL_MANAGE_WORK.task_priority is 'Indicates the priority of the task instance';
-- Create/Recreate indexes 
create unique index  CORP_ETL_MANAGE_WORK_IX1 on  CORP_ETL_MANAGE_WORK (TASK_ID)
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
alter table  CORP_ETL_MANAGE_WORK
  add primary key (CEMW_ID)
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
  
create index IDX_MANAGE_WORK_CASE_ID on CORP_ETL_MANAGE_WORK (case_id) TABLESPACE  MAXDAT_INDX ;
create index IDX_MANAGE_WORK_CLIENT_ID on CORP_ETL_MANAGE_WORK (client_id) TABLESPACE  MAXDAT_INDX ;

-- Create/Recreate check constraints 
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_ASF_CANCEL_WORK
  check (ASF_CANCEL_WORK             IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_ASF_COMPLETE_WORK
  check (ASF_COMPLETE_WORK         IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_CANCEL_WORK_FLAG
  check (CANCEL_WORK_FLAG           IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_COMPLETE_FLAG
  check (COMPLETE_FLAG                 IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_ESCALATED_FLAG
  check (ESCALATED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_FORWARDED_FLAG
  check (FORWARDED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_JEOPARDY_FLAG
  check (JEOPARDY_FLAG                 IN ('N','Y'));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_SLA_DAYS_TYPE
  check (SLA_DAYS_TYPE                 IN ('B','C',NULL));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_SOURCE_REFERENCE_TYPE
  check (SOURCE_REFERENCE_TYPE IN('Application ID','Document ID','Document Set ID','Image ID','Case ID','Client ID','Call ID','Incident ID',NULL));
alter table  CORP_ETL_MANAGE_WORK
  add constraint CHECK_TIMELINESS_STATUS
  check (TIMELINESS_STATUS         IN ('Timely','Untimely','Not Required','Not Complete'));
