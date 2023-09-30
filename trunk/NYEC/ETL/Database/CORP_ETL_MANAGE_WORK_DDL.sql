CREATE TABLE "MAXDAT"."CORP_ETL_MANAGE_WORK"
  (
    "CEMW_ID"              NUMBER,
    "ASF_CANCEL_WORK"      VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "ASF_COMPLETE_WORK"    VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "AGE_IN_BUSINESS_DAYS" NUMBER DEFAULT 0 NOT NULL ENABLE,
    "AGE_IN_CALENDAR_DAYS" NUMBER DEFAULT 0 NOT NULL ENABLE,
    "CANCEL_WORK_DATE" DATE,
    "CANCEL_WORK_FLAG" VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "COMPLETE_DATE" DATE,
    "COMPLETE_FLAG" VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "CREATE_DATE" DATE NOT NULL ENABLE,
    "CREATED_BY_NAME"       VARCHAR2(100),
    "ESCALATED_FLAG"        VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "ESCALATED_TO_NAME"     VARCHAR2(100),
    "FORWARDED_BY_NAME"     VARCHAR2(100),
    "FORWARDED_FLAG"        VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "GROUP_NAME"            VARCHAR2(100),
    "GROUP_PARENT_NAME"     VARCHAR2(100),
    "GROUP_SUPERVISOR_NAME" VARCHAR2(100),
    "JEOPARDY_FLAG"         VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE,
    "LAST_UPDATE_BY_NAME"   VARCHAR2(100),
    "LAST_UPDATE_DATE" DATE NOT NULL ENABLE,
    "OWNER_NAME"             VARCHAR2(100),
    "SLA_DAYS"               NUMBER,
    "SLA_DAYS_TYPE"          VARCHAR2(1),
    "SLA_JEOPARDY_DAYS"      NUMBER,
    "SLA_TARGET_DAYS"        NUMBER,
    "SOURCE_REFERENCE_ID"    NUMBER(*,0),
    "SOURCE_REFERENCE_TYPE"  VARCHAR2(30),
    "STATUS_AGE_IN_BUS_DAYS" NUMBER DEFAULT 0 NOT NULL ENABLE,
    "STATUS_AGE_IN_CAL_DAYS" NUMBER DEFAULT 0 NOT NULL ENABLE,
    "STATUS_DATE" DATE NOT NULL ENABLE,
    "TASK_ID"              NUMBER NOT NULL ENABLE,
    "TASK_STATUS"          VARCHAR2(50) NOT NULL ENABLE,
    "TASK_TYPE"            VARCHAR2(100) NOT NULL ENABLE,
    "TEAM_NAME"            VARCHAR2(100),
    "TEAM_PARENT_NAME"     VARCHAR2(100),
    "TEAM_SUPERVISOR_NAME" VARCHAR2(100),
    "TIMELINESS_STATUS"    VARCHAR2(20) DEFAULT 'Not Complete' NOT NULL ENABLE,
    "UNIT_OF_WORK"         VARCHAR2(30),
    "STG_EXTRACT_DATE" DATE DEFAULT SYSDATE NOT NULL ENABLE,
    "STG_LAST_UPDATE_DATE" DATE DEFAULT SYSDATE NOT NULL ENABLE,
    "STAGE_DONE_DATE" DATE,
    "DATE_TODAY" DATE,
    PRIMARY KEY ("CEMW_ID") USING INDEX TABLESPACE MAXDAT_INDX,
    CONSTRAINT "CHECK_SOURCE_REFERENCE_TYPE" CHECK (SOURCE_REFERENCE_TYPE IN('Application ID','Document ID','Document Set ID','Image ID','Case ID','Client ID','Call ID','Incident ID',NULL)) ENABLE,
    CONSTRAINT "CHECK_SLA_DAYS_TYPE" CHECK (SLA_DAYS_TYPE                 IN ('B','C',NULL)) ENABLE,
    CONSTRAINT "CHECK_ASF_CANCEL_WORK" CHECK (ASF_CANCEL_WORK             IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_ASF_COMPLETE_WORK" CHECK (ASF_COMPLETE_WORK         IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_CANCEL_WORK_FLAG" CHECK (CANCEL_WORK_FLAG           IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_COMPLETE_FLAG" CHECK (COMPLETE_FLAG                 IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_ESCALATED_FLAG" CHECK (ESCALATED_FLAG               IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_FORWARDED_FLAG" CHECK (FORWARDED_FLAG               IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_JEOPARDY_FLAG" CHECK (JEOPARDY_FLAG                 IN ('N','Y')) ENABLE,
    CONSTRAINT "CHECK_TIMELINESS_STATUS" CHECK (TIMELINESS_STATUS         IN ('Timely','Untimely','Not Required','Not Complete')) ENABLE
  );
  
  
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."CEMW_ID" IS  'sequence';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."ASF_CANCEL_WORK" IS  'Indicates if the Cancel Work step in the business process has been completed';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."ASF_COMPLETE_WORK" IS  'Indicates if the Complete Work step in the business process has been completed.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."AGE_IN_BUSINESS_DAYS" IS  'Number of days from the Create Date to the Complete Date, or to the Current Date for tasks that are not yet complete, excluding weekends and project holidays.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."AGE_IN_CALENDAR_DAYS" IS  'Number of days from the Creates Date to the Complete Date, or to the current date for tasks that are not yet complete.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."CANCEL_WORK_DATE" IS  'Indicates the date the ETL discovered that the task was no longer available to be worked.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."CANCEL_WORK_FLAG" IS  'Indicates if the task is no longer available to be worked (deleted or disregarded).';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."COMPLETE_DATE" IS  'Date the task was completed (worked) in MAXe';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."COMPLETE_FLAG" IS  'Indicates if the task was completed in MAXe';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."CREATE_DATE" IS  'Date the task was created in MAXe';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."CREATED_BY_NAME" IS  'Name of the staff member that created the task in MAXe.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."ESCALATED_FLAG" IS  'Indicates if the task is currently escalated.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."ESCALATED_TO_NAME" IS  'Name of the staff member in MAXe to whom the task has been escalated.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."FORWARDED_BY_NAME" IS  'Name of the staff member in MAXe to whom the task has been escalated.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."FORWARDED_FLAG" IS  'Indicates if the task was forwarded to the current location.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."GROUP_NAME" IS  'Name of the MAXe Group to which this task is assigned.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."GROUP_PARENT_NAME" IS  'Name of the MAXe Group identified as the parent group of the MAXe Group to which this task is assigned.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."GROUP_SUPERVISOR_NAME" IS  'Name of the staff member in MAXe identified as the supervisor of the group to which this task is assigned.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."JEOPARDY_FLAG" IS  'Indicates if the task is in jeopardy based on the SLA Days Type and SLA Jeopardy Days.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."LAST_UPDATE_BY_NAME" IS  'Name of the staff member that last claimed, modified, worked, escalated, or forwarded the task in MAXe.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."LAST_UPDATE_DATE" IS  'Date the task was last updated in MAXe';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."OWNER_NAME" IS  'Name of the staff member that owns the task in MAXe.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."SLA_DAYS" IS  'Age at which time the task is determined to be untimely. If no SLA applies then this value is null.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."SLA_DAYS_TYPE" IS  'Indicates if the SLA is based on Business Days or Calendar Days. If no SLA applies then this value is null.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."SLA_JEOPARDY_DAYS" IS  'Age at which time the task is determined to be in Jeopardy. If no SLA applies then this value is null.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."SLA_TARGET_DAYS" IS  'Age at which time the task is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."SOURCE_REFERENCE_ID" IS  'Unique identifier for the item to which this task is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."SOURCE_REFERENCE_TYPE" IS  'Indicates the type of Source Reference ID that is being provided.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."STATUS_AGE_IN_BUS_DAYS" IS  'Number of days from the Status Date to the current date excluding weekends and project holidays for tasks that are not yet complete. Once a task is complete, this value should be 0.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."STATUS_AGE_IN_CAL_DAYS" IS  'Number of days from the Status Date to the current date for tasks that are not yet complete. Once a task is complete, this value should be 0.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."STATUS_DATE" IS  'Date the Task Status was set in MAXe';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TASK_ID" IS  'Unique identifier for the task in MAXe';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TASK_STATUS" IS  'Current status of the task in MAXe indicating if the task is claimed or unclaimed.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TASK_TYPE" IS  'Indicates the type of work.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TEAM_NAME" IS  'Name of the MAXe Group identified as the team to which this task is assigned';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TEAM_PARENT_NAME" IS  'Name of the MAXe Group identified as the parent group of the MAXe Group identified to which this task is assigned.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TEAM_SUPERVISOR_NAME" IS  'Name of the staff member in MAXe identified as the supervisor of the team to which this task is assigned.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."TIMELINESS_STATUS" IS  'Indicates if the task was processed timely or untimely based on the SLA Days Type, SLA Days, and Age of task.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."UNIT_OF_WORK" IS  'Indicates the Production Planning Unit of Work to which this task is assigned.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."STG_EXTRACT_DATE" IS  'On INSERT only, sets the current system date that the record was created.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."STG_LAST_UPDATE_DATE" IS  'On INSERT or UPDATE, sets the current system date that the record was created or updated.';
  COMMENT ON COLUMN "MAXDAT"."CORP_ETL_MANAGE_WORK"."STAGE_DONE_DATE" IS 'Indicates the date ETL processing stopped for this record.';


CREATE UNIQUE INDEX "MAXDAT"."CORP_ETL_MANAGE_WORK_IX1" ON "MAXDAT"."CORP_ETL_MANAGE_WORK" ("TASK_ID") 
TABLESPACE MAXDAT_INDX;

CREATE SEQUENCE SEQ_CEMW_ID
 NOMAXVALUE
 NOMINVALUE
 NOCYCLE
/


CREATE OR REPLACE TRIGGER "MAXDAT"."TRG_R_CORP_ETL_MANAGE_WORK" BEFORE
  INSERT OR
  UPDATE ON corp_etl_manage_work FOR EACH ROW 
BEGIN 
  IF Inserting THEN 
    IF :new.cemw_Id IS NULL THEN
      SELECT Seq_cemw_Id.Nextval INTO :NEW.cemw_Id FROM Dual;
    END IF;
    IF :NEW.STG_EXTRACT_DATE IS NULL THEN
      :NEW.STG_EXTRACT_DATE  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/
ALTER TRIGGER "MAXDAT"."TRG_R_CORP_ETL_MANAGE_WORK" ENABLE;
