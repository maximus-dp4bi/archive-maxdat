--------------------------------------------------------
--  File created - Friday-September-27-2013   
--------------------------------------------------------
DROP TABLE "FLHK_ETL_PROCESS_APP_WIP";
--------------------------------------------------------
--  DDL for Table FLHK_ETL_PROCESS_APP_WIP
--------------------------------------------------------

  CREATE TABLE "FLHK_ETL_PROCESS_APP_WIP" 
  ("PA_ID" NUMBER,
 "APP_ID" NUMBER,
 "APP_TYPE" VARCHAR2(100),
 "APP_STATUS" VARCHAR2(100),
 "APP_STATUS_DATE" DATE,
 "CHANNEL" VARCHAR2(100),
 "CREATE_DATE" DATE,
 "RECEIPT_DATE" DATE,
 "COMPLETE_DATE" DATE,
 "APP_COMPLETE_RESULT" VARCHAR2(100),
 "APP_CLEARANCE_DATE" DATE,
 "RENEWAL_DATE" DATE,
 "ACCOUNT_ID" NUMBER,
 "ASSD_ACCOUNT_CREATE_UPDATE" DATE,
 "ASED_ACCOUNT_CREATE_UPDATE" DATE,
 "ZIP_CODE_APP" VARCHAR2(50),
 "APPLICANT_ID" NUMBER,
 "NUM_CHILDREN_APP" VARCHAR2(5),
 "CURRENT_TASK_ID" NUMBER,
 "TIMEOUT_NOTIF_ID" NUMBER,
 "ASED_TIMEOUT_NOTIF" DATE,
 "CANCEL_DATE" DATE,
 "INCOMPLETE_REASON" VARCHAR2(100),
 "CONFLICT_REASON" VARCHAR2(100),
 "DATA_ENTRY_TASK" NUMBER,
 "ASSD_DATA_ENTRY" DATE,
 "ASED_DATA_ENTRY" DATE,
 "DATA_ENTRY_ORG" VARCHAR2(100),
 "ASSD_RECEIVE_PROCESS_MI" DATE,
 "ASED_RECEIVE_PROCESS_MI" DATE,
 "ALL_MI_SATISFIED" VARCHAR2(1),
 "TIMEOUT_DATE" DATE,
 "ASSD_TIME_OUT_NOTIF" DATE,
 "ASED_TIME_OUT_NOTIF" DATE,
 "ASF_CANCEL_APP" VARCHAR2(1),
 "ASF_DATA_ENTRY" VARCHAR2(1),
 "ASF_RECEIVE_PROCESS_MI" VARCHAR2(1),
 "ASF_CORRECT_ERRORS" VARCHAR2(1),
 "ASF_TIME_OUT_NOTIF" VARCHAR2(1),
 "ASF_UPDATE_ACCOUNT" VARCHAR2(1),
 "GWF_CHANNEL" VARCHAR2(100),
 "GWF_MISSING_INFO" VARCHAR2(1),
 "GWF_CONFLICT" VARCHAR2(1),
 "GWF_TIME_OUT" VARCHAR2(1),
 "STAGE_DONE_DATE" DATE,
 "STG_EXTRACT_DATE" DATE,
 "STG_LAST_UPDATE_DATE" DATE,
 "INSTANCE_STATUS" VARCHAR2(10),
 "ACCOUNT_STATE" VARCHAR2(255),
 "ACCOUNT_COUNTY" VARCHAR2(255),
 "HEAD_HOUSEHOLD_ID" NUMBER(10,0),
 "GWF_PEND_NOTIFY_RQRD" VARCHAR2(10),
 "TIMEOUT_DATE_REQUESTED" DATE,
 "UPDATED" VARCHAR2(1),
 "ACCOUNT_NUMBER" NUMBER,
 "APPLICANT_NUM" NUMBER,
 "AGE_BUSINESS_DAYS" NUMBER,
 "AGE_CALENDAR_DAYS" NUMBER,
 "STATUS_AGE_BUSINESS_DAYS" NUMBER,
 "STATUS_AGE_CAL_DAYS" NUMBER,
 "DCN" VARCHAR2(30),
 "WEB_APPLICATION_ID" VARCHAR2(19),
 "APP_STATUS_CHANGE_DATE" DATE,
 "SOURCE" VARCHAR2(255));
/
