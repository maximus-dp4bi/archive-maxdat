/*
Created on 11-Oct-2017 by Guy T.
Description: Create all Manage Work Rel 6 Corp Tables.
Rel 6 includes changes such as : 
*/
create table CORP_ETL_MW
(
  CEMW_ID                    NUMBER NOT NULL,
  CANCELLED_BY_STAFF_ID      NUMBER DEFAULT 0 NOT NULL,
  CANCEL_METHOD              VARCHAR2(50),
  CANCEL_REASON              VARCHAR2(256),
  CANCEL_WORK_DATE           DATE,
  CASE_ID                    NUMBER(18),
  CLIENT_ID                  NUMBER(18), 
  COMPLETE_DATE              DATE,
  CREATE_DATE                DATE NOT NULL,
  CREATED_BY_STAFF_ID	     NUMBER DEFAULT 0 NOT NULL,
  ESCALATED_FLAG             VARCHAR2(1) DEFAULT 'N' NOT NULL,
  ESCALATED_TO_STAFF_ID	     NUMBER DEFAULT 0 NOT NULL,
  FORWARDED_FLAG             VARCHAR2(1) DEFAULT 'N' NOT NULL,
  FORWARDED_BY_STAFF_ID	     NUMBER DEFAULT 0 NOT NULL,  
  BUSINESS_UNIT_ID           NUMBER DEFAULT 0 NOT NULL,
  INSTANCE_START_DATE        DATE NOT NULL,    -- set by trigger
  INSTANCE_END_DATE          DATE,    -- set by trigger
  LAST_UPDATE_BY_STAFF_ID	 NUMBER DEFAULT 0 NOT NULL,
  LAST_UPDATE_DATE           DATE not null,
  LAST_EVENT_DATE            DATE,
  OWNER_STAFF_ID	         NUMBER DEFAULT 0 NOT NULL, 
  PARENT_TASK_ID             NUMBER, 
  SOURCE_REFERENCE_ID        INTEGER,
  SOURCE_REFERENCE_TYPE      VARCHAR2(30),
  STATUS_DATE                DATE not null,
  STG_EXTRACT_DATE           DATE default SYSDATE not null,  -- set via trigger
  STG_LAST_UPDATE_DATE       DATE default SYSDATE not null,  -- set via trigger
  STAGE_DONE_DATE            DATE,
  TASK_ID                    NUMBER not null,
  TASK_PRIORITY              VARCHAR2(50),
  TASK_STATUS                VARCHAR2(50) not null,
  TASK_TYPE_ID               NUMBER not null,
  TEAM_ID                    NUMBER DEFAULT 0 NOT NULL,
  UNIT_OF_WORK               VARCHAR2(30),
  WORK_RECEIPT_DATE          DATE NOT NULL,
  SOURCE_PROCESS_ID          NUMBER(18),
  SOURCE_PROCESS_INSTANCE_ID NUMBER(18),
  CLAIM_DATE				 DATE
)
tablespace MAXDAT_DATA;

-- Add comments to the columns 
comment on column CORP_ETL_MW.CEMW_ID
  is 'sequence';
comment on column CORP_ETL_MW.CANCELLED_BY_STAFF_ID 
 is 'The Staff ID of the person or system that cancelled the instance';
comment on column CORP_ETL_MW.CANCEL_WORK_DATE
  is 'Indicates the date the ETL discovered that the task was no longer available to be worked.';
comment on column CORP_ETL_MW.COMPLETE_DATE
  is 'Date the task was completed (worked) in MAXe';
comment on column CORP_ETL_MW.CREATE_DATE
  is 'Date the task was created in MAXe';
comment on column CORP_ETL_MW.CREATED_BY_STAFF_ID
  is 'Staff ID of the staff member that created the task in MAXe.';
comment on column CORP_ETL_MW.ESCALATED_FLAG
  is 'Indicates if the task is currently escalated.';
comment on column CORP_ETL_MW.ESCALATED_TO_STAFF_ID
  is 'Staff ID of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MW.FORWARDED_BY_STAFF_ID
  is 'Staff ID of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MW.FORWARDED_FLAG
  is 'Indicates if the task was forwarded to the current location.';
comment on column CORP_ETL_MW.BUSINESS_UNIT_ID
  is 'Group ID of the MAXe Group to which this task is assigned.';
comment on column  CORP_ETL_MW.LAST_UPDATE_BY_STAFF_ID
  is 'Staff ID of the staff member that last claimed, modified, worked, escalated, or forwarded the task in MAXe.';
comment on column  CORP_ETL_MW.LAST_UPDATE_DATE
  is 'Date the task was last updated in MAXe';
comment on column  CORP_ETL_MW.OWNER_STAFF_ID
  is 'Staff ID of the staff member that owns the task in MAXe.';
comment on column CORP_ETL_MW.PARENT_TASK_ID
  is 'Unique Identifier of the MAXe Task identified as the parent task of the MAXe Group to which this task is assigned.';    
comment on column  CORP_ETL_MW.SOURCE_REFERENCE_ID
  is 'Unique identifier for the item to which this task is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.';
comment on column  CORP_ETL_MW.SOURCE_REFERENCE_TYPE
  is 'Indicates the type of Source Reference ID that is being provided.';
comment on column  CORP_ETL_MW.STATUS_DATE
  is 'Date the Task Status was set in MAXe';
comment on column  CORP_ETL_MW.TASK_ID
  is 'Unique identifier for the task in MAXe';
comment on column  CORP_ETL_MW.TASK_STATUS
  is 'Current status of the task in MAXe indicating if the task is claimed or unclaimed.';
comment on column  CORP_ETL_MW.TASK_TYPE_ID
  is 'Unique Identifier of the task type.';
comment on column  CORP_ETL_MW.TEAM_ID
  is 'Group ID of the MAXe Group identified as the team to which this task is assigned';
comment on column  CORP_ETL_MW.UNIT_OF_WORK
  is 'Indicates the Production Planning Unit of Work to which this task is assigned.';
comment on column  CORP_ETL_MW.STG_EXTRACT_DATE
  is 'On INSERT only, sets the current system date that the record was created.';
comment on column  CORP_ETL_MW.STG_LAST_UPDATE_DATE
  is 'On INSERT or UPDATE, sets the current system date that the record was created or updated.';
comment on column  CORP_ETL_MW.STAGE_DONE_DATE
  is 'Indicates the date ETL processing stopped for this record.';
comment on column CORP_ETL_MW.CLIENT_ID 
  is 'Unique identifier associated to the client in MAXe';
comment on column CORP_ETL_MW.CASE_ID 
  is 'Unique identifier associated to the case in MAXe';
comment on column CORP_ETL_MW.CANCEL_METHOD 
  is 'The method in which the document instance was cancelled; coule be deleted, trashed by user, or exception';
comment on column CORP_ETL_MW.CANCEL_REASON 
  is 'The reason that the instance was cancelled';
comment on column CORP_ETL_MW.TASK_PRIORITY 
  is 'Indicates the priority of the task instance';

-- Create/Recreate indexes 
create unique index  MW_TASK_ID on  CORP_ETL_MW (TASK_ID)  tablespace MAXDAT_INDX;
create index MW_CASE_ID on CORP_ETL_MW (case_id) TABLESPACE  MAXDAT_INDX ;
create index MW_CLIENT_ID on CORP_ETL_MW (client_id) TABLESPACE  MAXDAT_INDX ;
create index IDX_MW_SRC_PROC_INST_ID on CORP_ETL_MW (SOURCE_PROCESS_INSTANCE_ID) TABLESPACE  MAXDAT_INDX ;

-- Create/Recreate primary, unique and foreign key constraints 
alter table  CORP_ETL_MW  add primary key (CEMW_ID)  using index   tablespace MAXDAT_INDX;

-- Create/Recreate check constraints 
alter table  CORP_ETL_MW   add constraint CHECK_ESCALATED_FLAG
  check (ESCALATED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MW   add constraint CHECK_FORWARDED_FLAG
  check (FORWARDED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MW   add constraint CHECK_SOURCE_REFERENCE_TYPE
  check (SOURCE_REFERENCE_TYPE IN('Application ID','Document ID','Document Set ID','Image ID','Case ID','Client ID','Call ID','Incident ID',NULL));

Grant select on CORP_ETL_MW to MAXDAT_READ_ONLY;


create table  CORP_ETL_MW_WIP
(
  CEMW_ID                    NUMBER not null,
  CANCELLED_BY_STAFF_ID      NUMBER DEFAULT 0 NOT NULL,
  CANCEL_METHOD              VARCHAR2(50),
  CANCEL_REASON              VARCHAR2(256),
  CANCEL_WORK_DATE           DATE,
  CASE_ID                    NUMBER(18),
  CLIENT_ID                  NUMBER(18), 
  COMPLETE_DATE              DATE,
  CREATE_DATE                DATE not null,
  CREATED_BY_STAFF_ID	     NUMBER DEFAULT 0 NOT NULL,
  ESCALATED_FLAG             VARCHAR2(1) default 'N' not null,
  ESCALATED_TO_STAFF_ID	     NUMBER DEFAULT 0 NOT NULL,
  FORWARDED_FLAG             VARCHAR2(1) default 'N' not null,
  FORWARDED_BY_STAFF_ID	     NUMBER DEFAULT 0 NOT NULL,  
  BUSINESS_UNIT_ID           NUMBER DEFAULT 0 NOT NULL,
  INSTANCE_START_DATE        DATE NOT NULL,    -- set by trigger
  INSTANCE_END_DATE          DATE,    -- set by trigger
  LAST_UPDATE_BY_STAFF_ID	 NUMBER DEFAULT 0 NOT NULL,
  LAST_UPDATE_DATE           DATE not null,
  LAST_EVENT_DATE            DATE,
  OWNER_STAFF_ID	         NUMBER DEFAULT 0 NOT NULL, 
  PARENT_TASK_ID             NUMBER, 
  SOURCE_REFERENCE_ID        INTEGER,
  SOURCE_REFERENCE_TYPE      VARCHAR2(30),
  STATUS_DATE                DATE not null,
  STG_EXTRACT_DATE           DATE default SYSDATE not null,  -- set via trigger
  STG_LAST_UPDATE_DATE       DATE default SYSDATE not null,  -- set via trigger
  STAGE_DONE_DATE            DATE,
  TASK_ID                    NUMBER not null,
  TASK_PRIORITY              VARCHAR2(50),
  TASK_STATUS                VARCHAR2(50) not null,
  TASK_TYPE_ID               NUMBER not null,
  TEAM_ID                    NUMBER DEFAULT 0 NOT NULL,
  UNIT_OF_WORK               VARCHAR2(30),
  WORK_RECEIPT_DATE          DATE NOT NULL,
  SOURCE_PROCESS_ID          NUMBER(18),
  SOURCE_PROCESS_INSTANCE_ID NUMBER(18),
  CHANGE_FLAG                VARCHAR2(1) default 'N' not null, -- N for No change, I for Insert into BPM Stage , U for Update into BPM Stage.
  CLAIM_DATE				 DATE
)
tablespace MAXDAT_DATA;
comment on column CORP_ETL_MW_WIP.CHANGE_FLAG 
  is 'N for No change; I for Insert into BPM Stage; U for Update into BPM Stage. This flag used while moving instances from WIP to BPM Stage table.';

-- Create/Recreate indexes 
create unique index  MW_TMP_TASK_ID on CORP_ETL_MW_WIP (TASK_ID)  tablespace MAXDAT_INDX;
create unique index  MW_TMP_CEMW_ID on CORP_ETL_MW_WIP (CEMW_ID)  tablespace MAXDAT_INDX;
create index MW_TMP_CASE_ID         on CORP_ETL_MW_WIP (CASE_ID)   TABLESPACE MAXDAT_INDX;
create index MW_TMP_CLIENT_ID       on CORP_ETL_MW_WIP (CLIENT_ID) TABLESPACE MAXDAT_INDX;

grant select on  CORP_ETL_MW_WIP to MAXDAT_READ_ONLY;