CREATE TABLE "MAXDAT"."PROCESS_INCIDENTS_OLTP"
  (
    "CEPI_ID"              NUMBER NOT NULL ENABLE,
        "INCIDENT_ID"          NUMBER(18,0) NOT NULL ENABLE,
        "TRACKING_NUMBER"      VARCHAR2(32),
        "RECEIPT_DT"  	   DATE,
        "CREATE_DT"   DATE,
        "CREATED_BY_NAME"     VARCHAR2(100),
        "CREATED_BY_GROUP"     VARCHAR2(80),
        "ORIGIN_ID"            NUMBER(18,0),
       -- "STATUS_AGE_BUS_DAYS"  NUMBER(18,0), -- NOT NULLABLE
       -- "STATUS_AGE_IN_CALENDAR_DAYS" NUMBER(18,0), -- NOT NULLABLE
        "CHANNEL"              VARCHAR2(80),
        "CLIENT_NOTICE_ID"     NUMBER(18,0),
        "INSTANCE_STATUS"      VARCHAR2(10) NOT NULL ENABLE,
        "CANCEL_DT"            DATE,
        "STAGE_DONE_DT"        DATE,
        "INCIDENT_TYPE"        VARCHAR2(80),
        "INCIDENT_ABOUT"       VARCHAR2(80),
        "INCIDENT_REASON"      VARCHAR2(80),
        "INCIDENT_DESCRIPTION"   VARCHAR2(4000),
        "ABOUT_PROVIDER_ID"     NUMBER(18,0),
        "ABOUT_PLAN_CODE"       VARCHAR2(32),
        "INCIDENT_STATUS"     VARCHAR2(80),
        "INCIDENT_STATUS_DT"  DATE,
        "COMPLETE_DT"         DATE,
        "REPORTED_BY"                 VARCHAR2(80),
        "REPORTER_RELATIONSHIP"    VARCHAR2(64),
        "CASE_ID"             NUMBER(18,0),
        "ENROLLMENT_STATUS"   VARCHAR2(32),
        "PRIORITY"             VARCHAR2(256),
        "PROGRAM_TYPE"        VARCHAR2(32)  ,
        "PROGRAM_SUBTYPE"     VARCHAR2(32)   ,
        "LAST_UPDATE_BY_DT"      DATE NOT NULL ENABLE,
        "LAST_UPDATE_BY_NAME"  VARCHAR2(100),
        "PLAN_CODE"          VARCHAR2(32),
        "PROVIDER_ID"      NUMBER(18,0),
        "ACTION_TYPE"      VARCHAR2(64) ,
        "ACTION_COMMENTS"    CLOB,
        "RESOLUTION_TYPE"  VARCHAR2(64),
        "RESOLUTION_DESCRIPTION" CLOB,
        "GWF_NOTIFY_CLIENT" VARCHAR2(1),
        "ASSD_NOTIFY_CLIENT"  DATE,
        "ASED_NOTIFY_CLIENT"   DATE,
        "ASF_NOTIFY_CLIENT"    VARCHAR2(1),
        "GWF_ESCALATE_INCIDENT" VARCHAR2(1),
        "ESCALATE_DT"     DATE,
        "CURRENT_TASK_ID" NUMBER(18,0),
       -- "AGE_BUSINESS_DAYS" NUMBER(18,0), -- NOT NULLABLE
       -- "AGE_CALENDAR_DAYS" NUMBER(18,0), -- NOT NULLABLE
       -- "JEOPARDY_STATUS" VARCHAR2(),
       -- "JEOPARDY_STATUS_DT" DATE,
        "STATE_RECD_APPEAL_DT" DATE,
        "HEARING_DT" DATE,
        "SELECTION_ID" NUMBER(18,0),
        "EB_FOLLOWUP_NEEDED_IND" VARCHAR2(1),
        "OTHER_PARTY_NAME" VARCHAR2(80),
        -- "TIMELINESS_STATUS" VARCHAR2(),
        -- "ENROLLEE_RIN" VARCHAR2(30),
        -- "REPORTER_NAME" VARCHAR2(80),
        "STG_EXTRACT_DATE" DATE DEFAULT SYSDATE NOT NULL ENABLE,
        "STG_LAST_UPDATE_DATE" DATE DEFAULT SYSDATE NOT NULL ENABLE,
        "ASSD_IDENTIFY_RSRCH_INCIDENT" DATE,
        "ASED_IDENTIFY_RSRCH_INCIDENT" DATE,
        "ASF_IDENTIFY_RSRCH_INCIDENT" VARCHAR2(1),
        "ASSD_PROCESS_INCIDENT" DATE,
        "ASED_PROCESS_INCIDENT" DATE,
        "ASF_PROCESS_INCIDENT" VARCHAR2(1),
        "GWF_RETURN_INCIDENT" VARCHAR2(1),
        "ASSD_RESOLVE_CMPLT_INCIDENT" DATE,
        "ASED_RESOLVE_CMPLT_INCIDENT" DATE,
        "ASF_RESOLVE_CMPLT_INCIDENT" VARCHAR2(1),
        "RETURNED_DT" date,
       -- "INC_IN_PROCESS" VARCHAR2(1) DEFAULT 'N', 
       -- "INC_EXTRACT_COMPLETE_DT" DATE,
       -- "INC_PRIORITY_IND" NUMBER(2,0) DEFAULT 0,
       -- "STG_LAST_PROCESSED_DT" DATE,
       -- "PROC_INC_COMPLETE_DT" DATE,
       "UPDATED" VARCHAR2(1) DEFAULT 'N',
        "GENERIC_FIELD1" VARCHAR2(50),
        "GENERIC_FIELD2" VARCHAR2(50),
        "GENERIC_FIELD3" VARCHAR2(50),
        "GENERIC_FIELD4" VARCHAR2(50),
        "GENERIC_FIELD5" VARCHAR2(50),
     primary key ("CEPI_ID") using index tablespace MAXDAT_INDX
    );
  
CREATE UNIQUE INDEX "MAXDAT"."PROCESS_INCIDENTS_OLTP_IX1" ON "MAXDAT"."PROCESS_INCIDENTS_OLTP" ("INCIDENT_ID") 
TABLESPACE MAXDAT_INDX;


