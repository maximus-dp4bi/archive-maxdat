/*
Created on 21-Sep-2014 by Raj A.
Description: Create all Manage Work V2 Corp Tables.
V2 release includes changes such as : 
1. Facts table is deprecated and History is being used now.
2. Added New columns to the BPM Stage table 
   2.1 CREATED_BY_STAFF_ID
   2.2 ESCALATED_TO_STAFF_ID
   2.3 FORWARDED_BY_STAFF_ID
   2.4 GROUP_SUPERVISOR_STAFF_ID
   2.5 LAST_UPDATE_BY_STAFF_ID
   2.6 OWNER_STAFF_ID
   2.7 TEAM_SUPERVISOR_STAFF_ID
   2.8 GROUP_ID  
   2.10 TEAM_ID  
   2.12 TASK_TYPE_ID
   2.13 INSTANCE_START_DATE
   2.14 INSTANCE_END_DATE
   2.15 CANCELLED_BY_STAFF_ID
   2.16 PARENT_TASK_ID
   2.17 LAST_EVENT_DATE
3. Removed columns
   3.1 COMPLETE_FLAG
   3.2 CANCEL_WORK_FLAG
   3.3 ASF_CANCEL_WORK
   3.4 ASF_COMPLETE_WORK
   3.5 AGE_IN_BUSINESS_DAYS
   3.6 AGE_IN_CALENDAR_DAYS
   3.7 DATE_TODAY
   3.8 PARENT_GROUP_ID
   3.9 PARENT_TEAM_ID
   3.10 SLA ATTRIBUTES..
4. Added a STAFF_KEY_LKUP table.

v2 Raj A. 11/06/2014 NYHIX-7711& MAXDAT-216: Renamed GROUP_ID to Business_Unit_ID; Added Source_Process_ID & Source_Process_Instance_ID columns.   
*/
create table CORP_ETL_MW_V2
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
  SOURCE_PROCESS_INSTANCE_ID NUMBER(18)
)
tablespace MAXDAT_DATA;

-- Add comments to the columns 
comment on column CORP_ETL_MW_V2.CEMW_ID
  is 'sequence';
comment on column CORP_ETL_MW_V2.CANCELLED_BY_STAFF_ID 
 is 'The Staff ID of the person or system that cancelled the instance';
comment on column CORP_ETL_MW_V2.CANCEL_WORK_DATE
  is 'Indicates the date the ETL discovered that the task was no longer available to be worked.';
comment on column CORP_ETL_MW_V2.COMPLETE_DATE
  is 'Date the task was completed (worked) in MAXe';
comment on column CORP_ETL_MW_V2.CREATE_DATE
  is 'Date the task was created in MAXe';
comment on column CORP_ETL_MW_V2.CREATED_BY_STAFF_ID
  is 'Staff ID of the staff member that created the task in MAXe.';
comment on column CORP_ETL_MW_V2.ESCALATED_FLAG
  is 'Indicates if the task is currently escalated.';
comment on column CORP_ETL_MW_V2.ESCALATED_TO_STAFF_ID
  is 'Staff ID of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MW_V2.FORWARDED_BY_STAFF_ID
  is 'Staff ID of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MW_V2.FORWARDED_FLAG
  is 'Indicates if the task was forwarded to the current location.';
comment on column CORP_ETL_MW_V2.BUSINESS_UNIT_ID
  is 'Group ID of the MAXe Group to which this task is assigned.';
comment on column  CORP_ETL_MW_V2.LAST_UPDATE_BY_STAFF_ID
  is 'Staff ID of the staff member that last claimed, modified, worked, escalated, or forwarded the task in MAXe.';
comment on column  CORP_ETL_MW_V2.LAST_UPDATE_DATE
  is 'Date the task was last updated in MAXe';
comment on column  CORP_ETL_MW_V2.OWNER_STAFF_ID
  is 'Staff ID of the staff member that owns the task in MAXe.';
comment on column CORP_ETL_MW_V2.PARENT_TASK_ID
  is 'Unique Identifier of the MAXe Task identified as the parent task of the MAXe Group to which this task is assigned.';    
comment on column  CORP_ETL_MW_V2.SOURCE_REFERENCE_ID
  is 'Unique identifier for the item to which this task is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.';
comment on column  CORP_ETL_MW_V2.SOURCE_REFERENCE_TYPE
  is 'Indicates the type of Source Reference ID that is being provided.';
comment on column  CORP_ETL_MW_V2.STATUS_DATE
  is 'Date the Task Status was set in MAXe';
comment on column  CORP_ETL_MW_V2.TASK_ID
  is 'Unique identifier for the task in MAXe';
comment on column  CORP_ETL_MW_V2.TASK_STATUS
  is 'Current status of the task in MAXe indicating if the task is claimed or unclaimed.';
comment on column  CORP_ETL_MW_V2.TASK_TYPE_ID
  is 'Unique Identifier of the task type.';
comment on column  CORP_ETL_MW_V2.TEAM_ID
  is 'Group ID of the MAXe Group identified as the team to which this task is assigned';
comment on column  CORP_ETL_MW_V2.UNIT_OF_WORK
  is 'Indicates the Production Planning Unit of Work to which this task is assigned.';
comment on column  CORP_ETL_MW_V2.STG_EXTRACT_DATE
  is 'On INSERT only, sets the current system date that the record was created.';
comment on column  CORP_ETL_MW_V2.STG_LAST_UPDATE_DATE
  is 'On INSERT or UPDATE, sets the current system date that the record was created or updated.';
comment on column  CORP_ETL_MW_V2.STAGE_DONE_DATE
  is 'Indicates the date ETL processing stopped for this record.';
comment on column CORP_ETL_MW_V2.CLIENT_ID 
  is 'Unique identifier associated to the client in MAXe';
comment on column CORP_ETL_MW_V2.CASE_ID 
  is 'Unique identifier associated to the case in MAXe';
comment on column CORP_ETL_MW_V2.CANCEL_METHOD 
  is 'The method in which the document instance was cancelled; coule be deleted, trashed by user, or exception';
comment on column CORP_ETL_MW_V2.CANCEL_REASON 
  is 'The reason that the instance was cancelled';
comment on column CORP_ETL_MW_V2.TASK_PRIORITY 
  is 'Indicates the priority of the task instance';

-- Create/Recreate indexes 
create unique index  MW_V2_TASK_ID on  CORP_ETL_MW_V2 (TASK_ID)  tablespace MAXDAT_INDX;
create index MW_V2_CASE_ID on CORP_ETL_MW_V2 (case_id) TABLESPACE  MAXDAT_INDX ;
create index MW_V2_CLIENT_ID on CORP_ETL_MW_V2 (client_id) TABLESPACE  MAXDAT_INDX ;
create index IDX_MW_V2_SRC_PROC_INST_ID on CORP_ETL_MW_V2 (SOURCE_PROCESS_INSTANCE_ID) TABLESPACE  MAXDAT_INDX ;

-- Create/Recreate primary, unique and foreign key constraints 
alter table  CORP_ETL_MW_V2  add primary key (CEMW_ID)  using index   tablespace MAXDAT_INDX;

-- Create/Recreate check constraints 
alter table  CORP_ETL_MW_V2   add constraint CHECK_ESCALATED_FLAG_V2
  check (ESCALATED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MW_V2   add constraint CHECK_FORWARDED_FLAG_V2
  check (FORWARDED_FLAG               IN ('N','Y'));
alter table  CORP_ETL_MW_V2   add constraint CHECK_SOURCE_REFERENCE_TYPE_V2
  check (SOURCE_REFERENCE_TYPE IN('Application ID','Document ID','Document Set ID','Image ID','Case ID','Client ID','Call ID','Incident ID',NULL));

Grant select on CORP_ETL_MW_V2 to MAXDAT_READ_ONLY;


create table  CORP_ETL_MW_V2_WIP
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
  CHANGE_FLAG                VARCHAR2(1) default 'N' not null  -- N for No change, I for Insert into BPM Stage , U for Update into BPM Stage.
)
tablespace MAXDAT_DATA;
comment on column CORP_ETL_MW_V2_WIP.CHANGE_FLAG 
  is 'N for No change; I for Insert into BPM Stage; U for Update into BPM Stage. This flag used while moving instances from WIP to BPM Stage table.';

-- Create/Recreate indexes 
create unique index  MW_V2_TMP_TASK_ID on CORP_ETL_MW_V2_WIP (TASK_ID)  tablespace MAXDAT_INDX;
create unique index  MW_V2_TMP_CEMW_ID on CORP_ETL_MW_V2_WIP (CEMW_ID)  tablespace MAXDAT_INDX;
create index MW_V2_TMP_CASE_ID         on CORP_ETL_MW_V2_WIP (CASE_ID)   TABLESPACE MAXDAT_INDX;
create index MW_V2_TMP_CLIENT_ID       on CORP_ETL_MW_V2_WIP (CLIENT_ID) TABLESPACE MAXDAT_INDX;

grant select on  CORP_ETL_MW_V2_WIP to MAXDAT_READ_ONLY;